# ft_services

Ce projet a pour but de nous faire découvrir Kubernetes afin de virtualiser un réseau et découvrir ce qu'est un environnement de production. Pour cela, le projet consiste à mettre en place un cluster regroupant plusieurs containers de services. Chaque service fonctionne dans un conteneur dédié construit sous Linux Alpine.

## Pour commencer

- git clone le projet

### Démarrage
- ./setup.sh

## Ressources

* [Kubernetes](https://kubernetes.io/fr/docs/home/) - Comprendre Kubernetes, ce que sont les .yaml, les services, pods, etc
* [Minikube](https://kubernetes.io/fr/docs/setup/learning-environment/minikube/) - "Outil facilitant l’exécution locale de Kubernetes"
* [MetalLB](https://metallb.universe.tf/installation/) - Pour installer le Loadbalancer
* [Alpine Linux](https://pkgs.alpinelinux.org/packages) - Pour trouver les packages correspondants à Alpine

Si vous souhaitez contribuer, lisez le fichier [CONTRIBUTING.md](https://example.org) pour savoir comment le faire.

## Versions

**Version d'Alpine: 3.12.3

The project consists of setting up an infrastructure of different services, with a multi-service cluster. Each service runs in a dedicated container, builds using Alpine Linux with its own Dockerfile, called in the setup.sh which builds the images.
Other features :
- a Kubernetes web dashboard to manage the cluster
- a Load Balancer which manages the external access of the services. The Load Balancer has a single IP
- a WordPress website which works with a MySQL database and has its own nginx server
- phpMyAdmin linked with the MySQL database, with its own nginx server
- a nginx server with port 80 (http) and redirection of type 301 to 443 (https)
- a FTPS server
- a grafana platform linked with an InfluxDB database, monitoring all the containers, with one dashboard per service
