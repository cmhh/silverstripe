#! /usr/bin/env bash

mariadb --protocol=socket -uroot -hlocalhost --socket="${SOCKET}" -p${MARIADB_ROOT_PASSWORD} \
  -e "CREATE DATABASE ${SS_DATABASE_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;"

mariadb --protocol=socket -uroot -hlocalhost --socket="${SOCKET}" -p${MARIADB_ROOT_PASSWORD} \
  -e "CREATE USER '${SS_DATABASE_USERNAME}' IDENTIFIED BY '${SS_DATABASE_PASSWORD}';"

mariadb --protocol=socket -uroot -hlocalhost --socket="${SOCKET}" -p${MARIADB_ROOT_PASSWORD} \
  -e "GRANT ALL PRIVILEGES ON silverstripe.* TO '${SS_DATABASE_USERNAME}'@'%';"

mariadb --protocol=socket -uroot -hlocalhost --socket="${SOCKET}" -p${MARIADB_ROOT_PASSWORD} \
  -e "FLUSH PRIVILEGES;"