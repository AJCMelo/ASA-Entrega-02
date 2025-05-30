# 1) Base: usamos uma imagem oficial do Ubuntu
FROM ubuntu:latest

# 2) Instalamos o serviço BIND9 (servidor DNS) e utilitários
RUN apt-get update && \
    apt-get install -y bind9 dnsutils && \
    rm -rf /var/lib/apt/lists/*

# 3) Copiamos a configuração de zona para dentro do container
COPY named.conf.local /etc/bind/named.conf.local
COPY db.asa.br        /etc/bind/db.asa.br

# 4) Expomos a porta 53/UDP (porta padrão de DNS)
EXPOSE 53/udp

# 5) Comando para iniciar o BIND em primeiro plano
CMD ["named", "-g", "-c", "/etc/bind/named.conf.local"]
