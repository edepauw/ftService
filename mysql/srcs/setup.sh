# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tgrangeo <tgrangeo@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/29 08:57:45 by jdel-ros          #+#    #+#              #
#    Updated: 2021/05/31 11:36:19 by tgrangeo         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

telegraf &
/etc/init.d/mariadb setup
service mariadb start

mysql -u root -e "create user '${MYSQL_ROOT_USERNAME}'@'%' identified by '${MYSQL_ROOT_PASSWORD}'"
mysql -u root -e "create database wordpress"
mysql -u root -e "grant all privileges on *.* to '${MYSQL_ROOT_USERNAME}'@'%'"
mysql -u root -e "flush privileges"
mysql -u root -e "exit"
service mariadb stop
sed -i "s|.*skip-networking.*|#skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
service mariadb start
mysql -u root -D wordpress < wordpress.sql
mysqld --user=root
while true;
do
	if ! pgrep mysql >/dev/null 2>&1 ; then
		exit 1
	fi
	sleep 2
done
