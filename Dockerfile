FROM debian:latest

# Install services, packages 

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

    

