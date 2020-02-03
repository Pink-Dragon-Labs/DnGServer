#!/bin/bash


IP=$(getent hosts 'realmserver' | awk '{print $1}')
sed -i "s/.*updateIP.*/updateIP $IP/g" $REALMFOLDER/router/router.conf
