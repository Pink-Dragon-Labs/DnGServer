#!/bin/bash

IP=$(getent hosts 'realmserver' | awk '{print $1}')

tmux new -d -s Realm
tmux send-keys "cd $REALMFOLDER/dawn/bin; ./startmain" C-m
tmux rename-window 'dawn'
tmux new-window "cd $REALMFOLDER/update; ./startupdate"
tmux rename-window 'update'
tmux new-window "/etc/init.d/mysql start; \
        mysql $DBNAME -e \"UPDATE serverList SET ip = '$IP' WHERE id='0'\"; \
        mysql $DBNAME -e \"UPDATE serverList SET ip = '$IP' WHERE id='1'\"; \
        echo \"ServerList IP's Updated in serverList table\"; \
        cd setup/scripts; \
        ./user test test Y PR ; \
        cd $REALMFOLDER/datamgr; ./startdatamgr"
tmux rename-window 'datamgr'

tmux new-window "/etc/init.d/mysql start; cd $REALMFOLDER/router; ./startrouter"
tmux rename-window 'router'
tmux a
