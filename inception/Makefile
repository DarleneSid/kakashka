# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dsydelny <dsydelny@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/02/29 19:09:15 by dsydelny          #+#    #+#              #
#    Updated: 2024/02/29 19:09:16 by dsydelny         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

name =    inception

all:
    @printf "Launching configuration ${name}...\n"
    @mkdir -p ~/data/db ~/data/wp
    @docker-compose -f srcs/docker-compose.yml build
    @docker-compose -f srcs/docker-compose.yml up -d

down:
    @printf "Shutting down configuration ${name}...\n"
    @docker-compose -f srcs/docker-compose.yml down

clean:    down
    @printf "Cleaning configuration ${name}...\n"
    @docker system prune -a

fclean:    clean
    @printf "Total clean of all docker configurations\n"
    @docker system prune --all --force --volumes

re:     fclean all

PHONY: all down clean fclean re
