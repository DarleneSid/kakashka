# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dsydelny <dsydelny@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/02/29 19:19:22 by dsydelny          #+#    #+#              #
#    Updated: 2024/02/29 19:19:23 by dsydelny         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# use debian as the base image
FROM debian:buster
# install NGINX and openssl
RUN apt-get update && apt-get -y install nginx openssl
# 1)create a directory to store certificates and keys 2)generate the keys
#openssl  : provides functions like generating SSL certificates.
#req      : used for generating certificate signing requests.
#-x509    : to output a self-signed certificate instead of a CSR.
#-nodes   : not to encrypt the private key so it won't prompt for a passphrase.
#-days 365: This sets the validity period of the certificate to 365 days.
RUN openssl req -x509 -nodes -days 365 \
#-subj    : to specify the fields of certificate.
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=dev/CN=ankhabar/emailAddress=ankhabar@student.42.fr"\
    -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;
# copy the provided config file to the container
COPY conf/nginx.conf /etc/nginx/sites-available/default
EXPOSE 443
#ENTRYPOINT will be the first thing executed once the container is launched.
#it is necessary to run the server in the foreground (non-daemon mode)
#since Docker expects the main process to stay in the foreground to
#keep the container running.
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
#Из RUN невозможно запустить приложение напрямую. В ряде случаев это можно
#делать через скрипт, но в целом для запуска используются инструкции CMD и
#ENTRYPOINT. RUN создаёт статичный слой, изменения внутри которого записываются
#в образ, но ничего не вызывают, CMD и ENTRYPOINT запускают что-либо, но
#НЕ ЗАПИСЫВАЮТ изменений в образ. Потому не стоит выполнять ими скрипты,
#результат которых нужно "положить" в конечный образ или раздел. Для этого есть RUN.
