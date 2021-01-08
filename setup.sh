#!/usr/bin/env zsh

# which donne le chemin du binaire
if ! which conntrack &>/dev/null; then # si y a pas le binaire de conntrack
	sudo apt-get install -y conntrack
fi

#if kubectl version &>/dev/null; then
#	echo "Cleaning environment..."
#	sudo minikube stop
#	docker stop $(docker ps -a -q)
#	docker rm $(docker ps -a -q)
#	docker rmi $(docker images -a -q)
#fi

if ! kubectl version &>/dev/null; then
	service nginx stop
	echo -en "\033[33mStarting minikube...\033[00m\n"
	tput sgr0
	sudo minikube start --driver=none
fi

#rm -rf /var/www/html/wordpress/
echo -en "\033[33mCleaning environment...\033[00m\n"
tput sgr0
kubectl delete --all deployment
kubectl delete --all svc
kubectl delete --all pods
kubectl delete --all statefulset
kubectl delete --all pvc
kubectl delete --all pv
kubectl delete --all secret
#sudo rm -rf /tmp/k8s_pvc/
#kubectl delete --all nodes
#kubectl delete --all namespaces

sudo chown -R user42 $HOME/.kube $HOME/.minikube

# see what changes would be made, returns nonzero returncode if different
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl diff -f - -n kube-system

# actually apply the changes, returns nonzero returncode on errors only
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system

# Install Metallb
echo -en '\E[47;34'"\033[1mK\033[0m"
echo "Installing MetalLB..."
tput sgr0
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
# kubectl delete secrets memberlist
kubectl create secret generic -n metallb-system memberlist \
--from-literal=secretkey="$(openssl rand -base64 128)"
kubectl delete -f ./srcs/metallb-conf.yaml; kubectl apply -f ./srcs/metallb-conf.yaml
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
kubectl create -f ./srcs/nginx.yaml
kubectl create -f ./srcs/ftps.yaml
kubectl create -f ./srcs/mysql.yaml
kubectl create -f ./srcs/phpmyadmin.yaml
kubectl create -f ./srcs/wordpress.yaml
kubectl create -f ./srcs/influxdb.yaml
kubectl create -f ./srcs/grafana.yaml

echo -en "\033[33mOpening dashboard...\033[00m\n"
tput sgr0
sudo minikube dashboard
