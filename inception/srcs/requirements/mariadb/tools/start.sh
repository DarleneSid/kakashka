# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    start.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dsydelny <dsydelny@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/02/29 19:22:01 by dsydelny          #+#    #+#              #
#    Updated: 2024/02/29 19:22:02 by dsydelny         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash
if [ ! -d /var/lib/mysql/${MYSQL_DB_NAME} ];
then
# Running this command initializes the data directory and sets up the basic
# directory structure and system tables required for the MariaDB server to
# function correctly. It prepares the database environment for first-time use.
    mysql_install_db --user=root --ldata=/var/lib/mysql
# mysqld is the command to start mariaDB server daemon.
# "&" at the end of the line is to run the process in the background.
    mysqld&
    sleep 2

    echo "CREATE DATABASE IF NOT EXISTS  ${MYSQL_DB_NAME};"
    mariadb -u root -e "CREATE DATABASE IF NOT EXISTS  ${MYSQL_DB_NAME};"

    echo "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';"
    mariadb -u root -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';"

    echo "GRANT ALL PRIVILEGES ON ${MYSQL_DB_NAME}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mariadb -u root -e "GRANT ALL PRIVILEGES ON ${MYSQL_DB_NAME}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

    echo "SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${MYSQL_ROOT_PASSWORD}');"
    mariadb -u root -e "SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${MYSQL_ROOT_PASSWORD}');"

    echo "FLUSH PRIVILEGES;"
    mariadb -u root -e "FLUSH PRIVILEGES;"
# to restart
    killall mysqld
fi

exec mysqld
