FROM ubuntu:18.04 

RUN apt update && apt install -y gnupg2
RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
RUN echo deb [arch=amd64,i386,ppc64el] http://mirror.jmu.edu/pub/mariadb/repo/10.1/ubuntu xenial main >> /etc/apt/sources.list
RUN dpkg --add-architecture i386
RUN apt update; exit 0
RUN apt install -y \
    openssh-server \
    libc6:i386 libstdc++6:i386 \
    software-properties-common \
    mariadb-server \
    libstdc++5 \
    libmysqlclient-dev \
    lib32ncurses5 lib32z1 \
    vim tmux git net-tools ssh htop

RUN sed -i "28s/.*/PermitRootLogin yes/" /etc/ssh/sshd_config
RUN sed -i "s/.*bind-address.*=.*/bind-address=0.0.0.0/g" /etc/mysql/my.cnf

RUN service ssh restart

ARG USELESS_ARG_FLAG=COPY
COPY ./ /opt/streborn

ARG ROOTPASS=1234
ARG DBNAME=realmdb
ARG DBUSER=game
ARG DBPASS=$ROOTPASS

ARG REALMFOLDER=/opt/streborn
ARG DATAFOLDER=$REALMFOLDER/dawn/data/lib
ARG SETUP_DIR=$REALMFOLDER/setup
ARG DB_FILE=$SETUP_DIR/database/realmdb.sql

ARG UPDATE_PORT=6005
ARG GAME_PORT=6008
ARG TEST_PORT=6009
ARG ROUTER_PORT=7002
ARG DATAMGR_PORT=7006

COPY setup/libclient /usr/lib/i386-linux-gnu
COPY setup/mysql /etc/mysql
COPY setup/cron /etc

RUN ip a show eth0 | grep -Po 'inet \K[\d.]+' > /root/local_ip
RUN echo 'root:$ROOTPASS' | chpasswd

RUN /etc/init.d/mysql restart; mysql -e "CREATE DATABASE $DBNAME;CREATE USER '$DBUSER'@'localhost' IDENTIFIED BY '$DBPASS';GRANT ALL PRIVILEGES ON *.* to $DBUSER@'localhost' identified by '$DBROOTPW';GRANT ALL PRIVILEGES ON *.* TO '$DBUSER'@'localhost' WITH GRANT OPTION;FLUSH PRIVILEGES"
RUN /etc/init.d/mysql restart; mysql $DBNAME < $DB_FILE

RUN /etc/init.d/mysql restart; LOCAL_IP=$(cat /root/local_ip); mysql $DBNAME -e "UPDATE serverList SET ip = '$LOCAL_IP' WHERE id='0'"
RUN /etc/init.d/mysql restart; LOCAL_IP=$(cat /root/local_ip); mysql $DBNAME -e "UPDATE serverList SET ip = '$LOCAL_IP' WHERE id='1'"

RUN sed -i_bak -e "/$UPDATE_PORT/d" /etc/services
RUN sed -i_bak -e "/$GAME_PORT/d" /etc/services
RUN sed -i_bak -e "/$TEST_PORT/d" /etc/services
RUN sed -i_bak -e "/$ROUTER_PORT/d" /etc/services
RUN sed -i_bak -e "/$DATAMGR_PORT/d" /etc/services
RUN echo "sgi-crsd		 17002/udp" >> /etc/services
RUN echo "realmupdate   $UPDATE_PORT/tcp" >> /etc/services
RUN echo "realmgame     $GAME_PORT/tcp" >> /etc/services
RUN echo "realmtestgame $TEST_PORT/tcp" >> /etc/services
RUN echo "realmrouter   $ROUTER_PORT/tcp" >> /etc/services
RUN echo "realmdatamgr  $DATAMGR_PORT/tcp" >> /etc/services

RUN LOCAL_IP=$(cat /root/local_ip); echo "$LOCAL_IP 	realmserver" >> /etc/hosts

#WORKDIR $REALMFOLDER/server
#RUN sed -i "5s/.*/sqlDB ${DBNAME}/" router.conf
#RUN sed -i "8s/.*/sqlUser ${DBUSER}/" router.conf
#RUN sed -i "11s/.*/sqlPW ${DBPASS}/" router.conf
#RUN LOCAL_IP=$(cat /root/local_ip); sed -i "25s/.*/updateIP-0 $LOCAL_IP/" router.conf
#
#RUN sed -i "5s/.*/sqlDB ${DBNAME}/" datamgr.conf
#RUN sed -i "8s/.*/sqlUser ${DBUSER}/" datamgr.conf
#RUN LOCAL_IP=$(cat /root/local_ip); sed -i "12s/.*/listenHost $LOCAL_IP/" datamgr.conf
#RUN sed -i "18s/.*/sqlPW ${DBPASS}/" datamgr.conf
#
#RUN chmod 775 datamgr
#RUN chmod 775 datamgr.conf
#RUN chmod 775 roommgr
#RUN chmod 775 roommgr.conf
#RUN chmod 775 router
#RUN chmod 775 router.conf
#RUN chmod 775 update
#RUN chmod 775 update.conf


#WORKDIR $DATAFOLDER
#RUN chmod 775 compile
#RUN chmod 775 stripCR
#RUN chmod 775 tokenize
#RUN ./compile

WORKDIR $SETUP_DIR
RUN sed -i "s/.*export MYSQL_USER.*/export MYSQL_USER=${DBUSER}/g" $SETUP_DIR/scripts/password.sh
RUN sed -i "s/.*export MYSQL_PWD=.*/export MYSQL_PWD=${DBPASS}/g" $SETUP_DIR/scripts/password.sh


WORKDIR $REALMFOLDER

RUN sed -i "s/.*sqlDB.*/sqlDB ${DBNAME}/g" router/router.conf
RUN sed -i "s/.*sqlUser.*/sqlUser ${DBUSER}/g" router/router.conf
RUN sed -i "s/.*sqlPW.*/sqlPW ${DBPASS}/g" router/router.conf
RUN LOCAL_IP=$(cat /root/local_ip); sed -i "s/.*updateIP.*/updateIP $LOCAL_IP/g" router/router.conf
RUN sed -i "s/.*updatePort.*/updatePort ${UPDATE_PORT}/g" router/router.conf

RUN sed -i "s/.*sqlDB.*/sqlDB ${DBNAME}/g" datamgr/datamgr.conf
RUN sed -i "s/.*sqlUser.*/sqlUser ${DBUSER}/g" datamgr/datamgr.conf
RUN sed -i "s/.*sqlPW.*/sqlPW ${DBPASS}/g" datamgr/datamgr.conf
RUN sed -i "s/.*listenHost.*/listenHost realmserver/g" datamgr/datamgr.conf
RUN sed -i "/.*Table2/s/^/#/" datamgr/datamgr.conf
RUN sed -i "/.*Table3/s/^/#/" datamgr/datamgr.conf

RUN chmod +x $REALMFOLDER/*/st*
RUN chmod +x $REALMFOLDER/dawn/bin/st*
RUN chmod +x $REALMFOLDER/dawn/bin/roommgr
RUN chmod +x $REALMFOLDER/live/bin/roommgr
RUN chmod +x $REALMFOLDER/live/bin/st*

EXPOSE 22
EXPOSE $UPDATE_PORT $GAME_PORT $TEST_PORT $ROUTER_PORT $DATAMG_PORT

ENV REALMFOLDER=$REALMFOLDER
ENTRYPOINT ["./startrealm.sh"]
