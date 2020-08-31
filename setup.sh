#!/usr/bin/env zsh

# which donne le chemin du binaire
if ! which conntrack &>/dev/null; then # si y a pas le binaire de conntrack
	sudo apt-get install -y conntrack
fi
# Start minikube
if ! kubectl version &>/dev/null; then
	sudo minikube start --driver=none
	echo "Starting minikube..."
fi

sudo chown -R user42 $HOME/.kube $HOME/.minikube
# End minikube -> minikube delete

# Web dashboard opening to run the cluster
echo "Opening dashboard..."
sudo minikube dashboard & # -> on peut encore se servir du terminal tout en naviguant sur le dashboard
# minikube addons enable dashboard

# Loadbalancer

# see what changes would be made, returns nonzero returncode if different
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl diff -f - -n kube-system

# actually apply the changes, returns nonzero returncode on errors only
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system

# Install Metallb
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
# On first install only
kubectl create secret generic -n metallb-system memberlist \
--from-literal=secretkey="$(openssl rand -base64 128)"
# If you want to see your secret : kubectl get secrets
# To use it : a pod has to reference the secret

# In metallb system : 
# metallb-system/controller : cluster-wide controller that handles IP address assignments
# metallb-system/speaker : speaks the protocols to make the services reachable
# Need to define and deploy a configmap ?

# Need to clean Metallb ?

# Build images for each services :

docker build -t nginx_img srcs/nginx
#docker build -t ftps_img srcs/ftps
#docker build -t wordpress_img srcs/wordpress
#docker build -t mysql_img srcs/mysql
#docker build -t phpmyadmin_img srcs/phpmyadmin
#docker build -t grafana_img srcs/grafana
#docker build -t influxdb_img srcs/influxdb

# Deploy services
#kubectl create -f ./srcs/