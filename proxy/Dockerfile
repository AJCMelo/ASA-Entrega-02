# 1) Base: usamos o Nginx oficial
FROM nginx:alpine

# 2) Copiamos nossa configuração personalizada
COPY default.conf /etc/nginx/conf.d/default.conf

# 3) Expomos porta HTTP
EXPOSE 80

# 4) O próprio Nginx, na imagem, já está preparado para iniciar
