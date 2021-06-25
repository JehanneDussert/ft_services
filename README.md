### Welcome to my ft_services [multi-service cluster] repository 👋

⭐️ This project aims to introduce us to Kubernetes in order to virtualize a network and discover what a production environment is. For this, the project consists in setting up a cluster gathering several service containers. Each service runs in a dedicated container built under Linux Alpine.

## ✅ __Features__ ⤵️
- A Kubernetes web __dashboard__
- A __Load Balancer__ with a single ip which manages the external access of the services. It is the only entry point to the cluster
- A __WordPress website__ listening on port 5050, which works with a __MySQL database__. Both services run in separate containers. Wordpress has its own nginx server. 
- __phpMyAdmin__, listening on port 5000 and linked with the MySQL database. it has its own nginx server. 
- A container with an __nginx server__ listening on ports 80 and 443. Port 80 is in http and is a systematic redirection of type 301 to 443, which is in https.
- A __FTPS server__ listening on port 21.
- A __Grafana platform__, listening on port 3000, linked with an __InfluxDB database__. Grafana is monitoring all the containers. 

## 💡 Usage
- ./setup.sh
- If you want to restart only some services : __source fct.zsh__ then __kre service_name__

## Reference
* [Kubernetes](https://kubernetes.io/fr/docs/home/) - Understand Kubernetes, what .yaml is, services, pods, etc.
* [Minikube](https://kubernetes.io/fr/docs/setup/learning-environment/minikube/) - "Tool to facilitate local execution of Kubernetes"
* [MetalLB](https://metallb.universe.tf/installation/) - To install the Loadbalancer
* [Alpine Linux](https://pkgs.alpinelinux.org/packages) - To find the packages corresponding to Alpine

## Version
Version of Alpine: 3.12.3

## Contributors
* [Jehanne Dussert](https://github.com/JehanneDussert) - Projet
* [Marc Li](https://github.com/mli42) - Fichier fct.zsh
