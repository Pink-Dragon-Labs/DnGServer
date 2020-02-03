#!/bin/bash


IP=$(getent hosts 'realmserver' | awk '{print $1}')
sed -i "s/.*updateIP.*/updateIP $IP/g" $REALMFOLDER/router/router.conf

service mysql start
mysql -h 127.0.0.1 -u$DBUSER -p$DBPASS $DBNAME -e "UPDATE serverList SET ip = '$IP' WHERE id='0'"
mysql -h 127.0.0.1 -u$DBUSER -p$DBPASS $DBNAME -e "UPDATE serverList SET ip = '$IP' WHERE id='1'"
