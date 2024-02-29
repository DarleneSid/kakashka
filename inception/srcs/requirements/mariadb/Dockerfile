# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dsydelny <dsydelny@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/02/29 19:21:19 by dsydelny          #+#    #+#              #
#    Updated: 2024/02/29 19:21:19 by dsydelny         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster
RUN apt-get update && apt-get -y install mariadb-server

COPY tools/start.sh ./
RUN chmod +x start.sh

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/
RUN mkdir -p /var/lib/mysql /run/mysqld
RUN chown -R mysql:root /var/lib/mysql /run/mysqld
EXPOSE 3306

CMD [ "./start.sh" ]
