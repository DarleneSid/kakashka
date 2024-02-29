# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    start.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dsydelny <dsydelny@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/02/29 19:16:29 by dsydelny          #+#    #+#              #
#    Updated: 2024/02/29 19:16:30 by dsydelny         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

if [ ! -e /var/www/html/wp-config.php ];
then
    cd /var/www/html/
    sleep 5
    echo "wp core download --allow-root"
    wp core download --allow-root
    echo "wp config create ${MYSQL_DB_NAME}"
    wp config create \
        --dbname=${MYSQL_DB_NAME} \
        --dbuser=${MYSQL_USER} \
        --dbpass=${MYSQL_USER_PASSWORD} \
        --dbcharset="utf8" \
        --dbhost=mariadb:3306 \
        --locale=en_FR \
        --allow-root
    
    echo "wp core install"    
    wp core install \
        --url=${DOMAIN_NAME} \
        --title=${WP_TITLE} \
        --admin_user=${WP_ADMIN_LOGIN} \
        --admin_password=${WP_ADMIN_PASSWD} \
        --admin_email=${WP_ADMIN_EMAIL} \
        --allow-root

    echo "wp user create $WP_USER_LOGIN $WP_USER_EMAIL"
    wp user create $WP_USER_LOGIN $WP_USER_EMAIL \
        --role=author \
        --user_pass=$WP_USER_PASSWD \
        --allow-root

    echo "chown"
    chown -R www-data:www-data /var/www/html/

fi

php-fpm7.3 --nodaemonize
