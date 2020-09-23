#!/usr/bin/env zsh

kubectl delete --all deployment
kubectl delete --all svc
kubectl delete --all pods
kubectl delete --all statefulset
kubectl delete --all pvc
kubectl delete --all pv
kubectl delete --all secret
#kubectl delete --all nodes
#kubectl delete --all namespaces

# which donne le chemin du binaire
if ! which conntrack &>/dev/null; then # si y a pas le binaire de conntrack
	sudo apt-get install -y conntrack
fi
# Start minikube
if ! kubectl version &>/dev/null; then
	service nginx stop
	sudo minikube start --driver=none
	sudo chown -R user42 $HOME/.kube $HOME/.minikube
	echo "Starting minikube..."
fi

# Web dashboard opening to run the cluster
echo "Opening dashboard..."
sudo minikube dashboard & # -> on peut encore se servir du terminal tout en naviguant sur le dashboard
# minikube addons enable dashboard

# see what changes would be made, returns nonzero returncode if different
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl diff -f - -n kube-system

# actually apply the changes, returns nonzero returncode on errors only
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system

# Install Metallb
echo "Installing MetalLB..."
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
# kubectl delete secrets memberlist
kubectl create secret generic -n metallb-system memberlist \
--from-literal=secretkey="$(openssl rand -base64 128)"
kubectl delete -f ./srcs/metallb-conf.yaml; kubectl apply -f ./srcs/metallb-conf.yaml
# If you want to see your secret : kubectl get secrets
# To use it : a pod has to reference the secret

IP=$(kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | sed -n 2p)
echo "IP : ${IP}"
kubectl apply -k ./srcs/

# Build images for each services :
echo "Building images..."
docker build -t nginx_img srcs/nginx
docker build -t ftps_img srcs/ftps
docker build -t mysql_img srcs/mysql
docker build -t phpmyadmin_img srcs/phpmyadmin
#docker build -t wordpress_img srcs/wordpress
#docker build -t grafana_img srcs/grafana
#docker build -t influxdb_img srcs/influxdb

echo "Building my new secret..."
kubectl create secret generic db-id \
	--from-literal=name=${DB_NAME} \
	--from-literal=user=${DB_USER} \
	--from-literal=password=${DB_PASSWORD} \
	--from-literal=host=${DB_HOST}

# Deploy services
echo "Building deployments and services..."
kubectl create -f ./srcs/nginx.yaml
kubectl create -f ./srcs/ftps.yaml
kubectl create -f ./srcs/mysql.yaml
kubectl create -f ./srcs/phpmyadmin.yaml
#kubectl create -f ./srcs/wordpress.yaml