#FROM debian:latest

#Instalando ferramentas de teste de rede

#RUN apt update
#RUN apt upgrade -y
#RUN apt install net-tools dnsutils -y
#RUN apt install -y net-tools dnsutils iputils-ping

FROM debian:11
RUN apt-get update && \
    apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*
COPY index.html /var/www/html/index.html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
