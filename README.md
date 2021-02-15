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

## Relancer seulement certains services
Commandes à exécuter :
- source fct.zsh
- kre nom_du_pod

## Contributeurs
* [Jehanne Dussert](https://github.com/JehanneDussert) - Projet
* [Marc Li](https://github.com/mli42) - Fichier fct.zsh

## Versions

**Version d'Alpine: 3.12.3
