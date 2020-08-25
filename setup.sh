# Start minikube
# Faire condition pour le faire que si minikube est pas allume
sudo minikube start --driver=none
sudo chown -R user42 $HOME/.kube $HOME/.minikube