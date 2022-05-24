# Compte Rendu SAE 2.03  

**Équipe :** Équipe n°5  

**Nom des membres de l'équipe :**  

Andoche Keran,  

Dinh Tran Thai Duc,  

Claccin Noemie,  

Rocha Anthony  


**Année :** 2021/2022   

**Département Informatique , IUT Le Havre - Sae2.03**

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

# <center> SOMMAIRE </center>

## I)   Présentation de Docker

## II)  Installation du serveur  multimédia Jellyfin et la rédaction de  Dockerfile 

## III) Les problèmes survenus à l'installation

## IV) Les solutions apportées à ces problèmes d'installation

## Conclusion

-------------------------------------------------------------------------------- 
-------------------------------------------------------------------------------- 


## I) Présentation de Docker

#### Qu'est-ce qu'un container ?



Tout d'abord, il est nécessaire de définir un container avant Docker. Un container Docker est un environnement d’exécution virtualisé dans lequel les utilisateurs peuvent isoler les applications du système sous-jacent. Ces conteneurs sont des unités compactes et portables dans lesquelles on peut démarrer une application rapidement et facilement.  
      
Il ne faut pas le confondre avec une une image Docker qui est un fichier immuable  qui contient le code source, les bibliothèques, les dépendances, les outils et autres fichiers nécessaires à l’exécution d’une application.

Plus concrètement, un container est une image Docker en cours d'exécution. Il dépend d'une image pour pourvoir exister : 

![Image_container](./Images/Image_container.png)

#### Qu'est-ce que Docker ?  

Il s’agit d’une plateforme logicielle open source permettant de créer, de déployer et de gérer des containers d’applications virtualisées sur un système d’exploitation.  Les services ou fonctions de l’application et ses différentes bibliothèques, fichiers de configuration, dépendances et autres composants sont regroupés au sein du container.


#### Les avantages et inconvénients de l'utilisation de Docker

![container_VM](./Images/container_VM.png)

Par rapport aux machines virtuelles, Docker présente également plusieurs avantages. Elle permet de développer des applications de façon plus efficiente, en utilisant moins de ressources, et de déployer ces applications plus rapidement. En effet, les machines virtuelles utilisent du matériel informatique comme les hyperviseurs tandis que les containers partagent le même système d'exploitation. Par conséquent, les containers sont plus efficient en terme de consommation de ressources systèmes. 

Cependant, Docker possède également des inconvénients :  

Il est difficile de gérer de manière efficiente plusieurs containers à la fois.  
La sécurité est insuffisante : les containers sont isolés et partagent un même système d'exploitation.  

  

## II) Installation du serveur  multimédia Jellyfin et la rédaction de  Dockerfile
# 1.1. Notre  dockerfile
```shell
FROM debian:latest

# Install services, packages and do cleanup

RUN   apt update  -y
RUN   apt upgrade -y
RUN   apt-get install sudo -y
RUN   sudo apt install debconf -y
RUN   apt-get install wget apt-utils -y

RUN  sudo apt install apt-transport-https ca-certificates gnupg2 curl git -y
RUN  sudo wget -O- https://repo.jellyfin.org/jellyfin_team.gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/jellyfin.gpg
RUN  echo "deb [arch=$( dpkg --print-architecture ) signed-by=/usr/share/keyrings/jellyfin.gpg] https://repo.jellyfin.org/debian bullseye main" | sudo tee /etc/apt/sources.list.d/jellyfin.list 

RUN sudo apt update  -y
RUN sudo apt upgrade -y
RUN sudo apt install jellyfin -y
RUN apt install systemctl -y

RUN sudo systemctl start jellyfin
RUN sudo systemctl enable jellyfin

#Set up Apache as a reverse Proxy

RUN sudo apt install apache2 -y
RUN sudo systemctl enable apache2
RUN sudo a2enmod proxy proxy_http headers proxy_wstunnel

COPY jellyfin.conf /etc/apache2/sites-available/jellyfin.conf

RUN sudo a2ensite jellyfin.conf
RUN sudo systemctl restart apache2

# Expose Porte   
EXPOSE 8096

CMD ["systemctl", "start", "jellyfin"]
```



## III) Les problèmes survenus à l'installation

Durant l'installation du serveur Jellyfin, nous nous sommes exposés à diverses problèmes comme :  
  
Privilèges insuffisants pour l'installation  
La configuration de logicielle insuffisante  



## IV) Les solutions apportées à ces problèmes d'installation

Pour résoudre le problème des privilèges / des droits d'accès pour exécuter certaines commandes, nous devions installer les paquets relatifs à sudo :  
 ``` apt install sudo - y```

Quant à la configuration logicielle , nous avions fait appel à nos responsable de la SAE.

## Conclusion












