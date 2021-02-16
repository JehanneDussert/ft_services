#!/usr/bin/env zsh
#sudo usermod -aG docker user42; newgrp docker

minikube delete
minikube start --vm-driver=docker
eval $(minikube docker-env)

# Install Metallb
echo -en "\033[33mInstalling MetalLB...\033[00m\n"
tput sgr0
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist \
--from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f ./srcs/metallb-conf.yaml
# If you want to see your secret : kubectl get secrets
# To use it : a pod has to reference the secret

IP=$(kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | sed -n 2p)
echo -en "\033[33mIP : ${IP}\033[00m\n"
tput sgr0
kubectl apply -k ./srcs/

# Build images for each services :
echo -en "\033[33mBuilding images...\033[00m\n"
tput sgr0
docker build -t nginx_img srcs/nginx
docker build -t ftps_img srcs/ftps
docker build -t mysql_img srcs/mysql
docker build -t phpmyadmin_img srcs/phpmyadmin
docker build -t wordpress_img srcs/wordpress
docker build -t grafana_img srcs/grafana
docker build -t influxdb_img srcs/influxdb

DB_NAME=wordpress; DB_USER=wp_user; DB_PASSWORD=password; DB_HOST=mysql;

echo -en "\033[33mBuilding my new secrets...\033[00m\n"
tput sgr0
kubectl create secret generic db-id \
	--from-literal=name=${DB_NAME} \
	--from-literal=user=${DB_USER} \
	--from-literal=password=${DB_PASSWORD} \
	--from-literal=host=${DB_HOST}

kubectl create secret generic jdussert \
	--from-literal=user="jdussert" \
	--from-literal=password="password"

# Deploy services
echo -en "\033[33mBuilding deployments and services...\033[00m\n"
tput sgr0
kubectl create -f ./srcs/mysql.yaml
kubectl create -f ./srcs/nginx.yaml
kubectl create -f ./srcs/ftps.yaml
kubectl create -f ./srcs/phpmyadmin.yaml
kubectl create -f ./srcs/wordpress.yaml
kubectl create -f ./srcs/influxdb.yaml
kubectl create -f ./srcs/grafana.yaml

echo -en "\033[33mOpening dashboard...\033[00m\n"
tput sgr0
minikube dashboard
