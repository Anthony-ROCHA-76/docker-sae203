FROM debian:latest
# Pour s'assurer que l'installation se déroule correctement, on met à jour le système
RUN   apt update  -y
RUN   apt upgrade -y

# On installe les paquetages sudo pour permettre de prendre les droits du root pour exécuter les commandes
RUN   apt-get install sudo -y

# Install services, packages
RUN   sudo apt install debconf -y
RUN   apt-get install wget apt-utils -y

# On s'assure que l'on peut utiliser des référentiels accessibles via le protocole HTTPS, tout en indiquant l'autorité de certification gnup2 et de s'assurer le transfert des données avec git :
RUN   sudo apt install -y apt-transport-https \
                          ca-certificates \ 
                          gnupg2 \
                          curl \
                          git
# Pour éviter que l'installation échoue, on importe la clé et le référentiel Jellyfin GPG pour vérifier l’authenticité du paquet
RUN  sudo wget -O- https://repo.jellyfin.org/jellyfin_team.gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/jellyfin.gpg

RUN  echo "deb [arch=$( dpkg --print-architecture ) signed-by=/usr/share/keyrings/jellyfin.gpg] https://repo.jellyfin.org/debian bullseye main" | sudo tee /etc/apt/sources.list.d/jellyfin.list 

# Metter a jour et puis installer jellyfin
RUN sudo apt update  -y
RUN sudo apt upgrade -y
RUN sudo apt install jellyfin -y
RUN apt install systemctl -y

# Lancer jellyfin
RUN sudo systemctl start jellyfin
RUN sudo systemctl enable jellyfin

# Set up Apache as a reverse Proxy

RUN sudo apt install apache2 -y
RUN sudo systemctl enable apache2
RUN sudo a2enmod proxy proxy_http headers proxy_wstunnel

COPY jellyfin.conf /etc/apache2/sites-available/jellyfin.conf

RUN sudo a2ensite jellyfin.conf
RUN sudo systemctl restart apache2

# S'assurer que l'on soit sur le port par défaut de Jellyfin qui est le port 8096
EXPOSE 8096

CMD ["systemctl", "start", "jellyfin"]

    

