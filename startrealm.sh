#!/bin/bash

IP=$(getent hosts 'realmserver' | awk '{print $1}')

tmux new -d -s Realm
tmux send-keys "cd $REALMFOLDER/dawn/bin; ./startmain" C-m
tmux rename-window 'dawn'
tmux new-window "cd $REALMFOLDER/update; ./startupdate"
tmux rename-window 'update'
tmux new-window "/etc/init.d/mysql restart; \
        mysql $DBNAME -e \"UPDATE serverList SET ip = '$IP' WHERE id='0'\"; \
        mysql $DBNAME -e \"UPDATE serverList SET ip = '$IP' WHERE id='1'\"; \
        echo \"ServerList IP's Updated in serverList table\"; \
        cd $REALMFOLDER/datamgr; ./startdatamgr"
tmux rename-window 'datamgr'

sleep 5
tmux new-window "cd $REALMFOLDER/router; ./startrouter"
tmux rename-window 'router'
tmux a
