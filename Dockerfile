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

CMD ["./bin/sh", ""]

RUN sudo systemctl start jellyfin
RUN sudo systemctl enable jellyfin

CMD ["systemctl", "start", "jellyfin"]

    
# Expose Nginx   
EXPOSE 8096



