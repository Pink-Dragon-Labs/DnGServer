tmux new-session -d -s Realm "cd $REALMFOLDER/dawn/bin; ./startroommgr"
tmux rename-window 'dawn'
tmux new-window "cd $REALMFOLDER/update; ./startupdate"
tmux rename-window 'update'
tmux new-window "/etc/init.d/mysql restart; cd $REALMFOLDER/datamgr; ./startdatamgr"
tmux rename-window 'datamgr'

sleep 5
tmux new-window "cd $REALMFOLDER/router; ./startrouter"
tmux rename-window 'router'
