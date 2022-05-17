FROM debian:latest

# Install services, packages and do cleanup
RUN    apt-get -y update
RUN    apt-get -y install systemctl
RUN    apt-get -y install vsftpd 

RUN cp /etc/vsftpd.conf /etc/vsftpd.conf.orig

# Copy files


COPY ./vsftpd.conf /etc/vsftpd.conf

# Expose Apache
EXPOSE 20
EXPOSE 21

RUN systemctl restart vsftpd
RUN systemctl enable vsftpd
