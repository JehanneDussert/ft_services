# My Shebang to execute my code
#!/bin/bash

# Is it the right place to put this ?
sudo apt-get install -y conntrack

# Start minikube
# Faire condition pour le faire que si minikube est pas allume : if / fi
sudo minikube start --driver=none
sudo chown -R user42 $HOME/.kube $HOME/.minikube
# End minikube -> minikube delete

# Web dashboard opening to run the cluster
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
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
# If you want to see your secret : kubectl get secrets
# To use it : a pod has to reference the secret

# In metallb system : 
# metallb-system/controller : cluster-wide controller that handles IP address assignments
# metallb-system/speaker : speaks the protocols to make the services reachable
# Need to define and deploy a configmap ?

# Need to clean Metallb
#kubectl delete --