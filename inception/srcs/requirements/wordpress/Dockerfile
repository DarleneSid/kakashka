# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dsydelny <dsydelny@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/02/29 19:15:30 by dsydelny          #+#    #+#              #
#    Updated: 2024/02/29 19:15:42 by dsydelny         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster
RUN apt-get update && apt-get -y install php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli \
    php7.3-common php7.3-json php7.3-opcache php-curl php-gd php-intl \
    php-mbstring php-xml mariadb-client curl

COPY conf/www.conf /etc/php/7.3/fpm/pool.d
COPY tools/start.sh .
RUN chmod +x /start.sh

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

RUN rm -f /var/www/wordpress/wp-config-sample.php
RUN mkdir /run/php/

EXPOSE 9000

ENTRYPOINT [ "/start.sh" ]
