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
    vim tmux htop

RUN sed -i "28s/.*/PermitRootLogin yes/" /etc/ssh/sshd_config
RUN sed -i "s/.*bind-address.*=.*/bind-address=0.0.0.0/g" /etc/mysql/my.cnf; \
    sed -i "s/.*#bind-address.*127.0.0.1.*/bind-address=127.0.0.1/g" /etc/mysql/mariadb.cnf

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

RUN ip a show eth0 | grep -Po 'inet \K[\d.]+' > /root/local_ip; \
    echo 'root:$ROOTPASS' | chpasswd

RUN /etc/init.d/mysql restart; mysql -e "CREATE DATABASE $DBNAME;CREATE USER '$DBUSER'@'localhost' IDENTIFIED BY '$DBPASS';GRANT ALL PRIVILEGES ON *.* to $DBUSER@'localhost' identified by '$DBROOTPW';GRANT ALL PRIVILEGES ON *.* TO '$DBUSER'@'localhost' WITH GRANT OPTION;FLUSH PRIVILEGES"; \
    mysql $DBNAME < $DB_FILE;

RUN sed -i_bak -e "/$UPDATE_PORT/d" /etc/services; \
    sed -i_bak -e "/$GAME_PORT/d" /etc/services; \
    sed -i_bak -e "/$TEST_PORT/d" /etc/services; \
    sed -i_bak -e "/$ROUTER_PORT/d" /etc/services; \
    sed -i_bak -e "/$DATAMGR_PORT/d" /etc/services; \
    echo "sgi-crsd		 17002/udp" >> /etc/services; \
    echo "realmupdate   $UPDATE_PORT/tcp" >> /etc/services; \
    echo "realmgame     $GAME_PORT/tcp" >> /etc/services; \
    echo "realmtestgame $TEST_PORT/tcp" >> /etc/services; \
    echo "realmrouter   $ROUTER_PORT/tcp" >> /etc/services; \
    echo "realmdatamgr  $DATAMGR_PORT/tcp" >> /etc/services

WORKDIR $SETUP_DIR
RUN sed -i "s/.*export MYSQL_USER.*/export MYSQL_USER=${DBUSER}/g" $SETUP_DIR/scripts/password.sh; \
    sed -i "s/.*export MYSQL_PWD=.*/export MYSQL_PWD=${DBPASS}/g" $SETUP_DIR/scripts/password.sh


WORKDIR $REALMFOLDER

RUN sed -i "s/.*sqlDB.*/sqlDB ${DBNAME}/g" router/router.conf; \
    sed -i "s/.*sqlUser.*/sqlUser ${DBUSER}/g" router/router.conf; \
    sed -i "s/.*sqlPW.*/sqlPW ${DBPASS}/g" router/router.conf; \
    sed -i "s/.*updatePort.*/updatePort ${UPDATE_PORT}/g" router/router.conf; \
    sed -i "s/.*sqlDB.*/sqlDB ${DBNAME}/g" datamgr/datamgr.conf; \
    sed -i "s/.*sqlUser.*/sqlUser ${DBUSER}/g" datamgr/datamgr.conf; \
    sed -i "s/.*sqlPW.*/sqlPW ${DBPASS}/g" datamgr/datamgr.conf; \
    sed -i "s/.*listenHost.*/listenHost realmserver/g" datamgr/datamgr.conf; \
    sed -i "/.*Table2/s/^/#/" datamgr/datamgr.conf; \
    sed -i "/.*Table3/s/^/#/" datamgr/datamgr.conf

RUN chmod +x $REALMFOLDER/*/st*; \
    chmod +x $REALMFOLDER/dawn/bin/st*; \
    chmod +x $REALMFOLDER/dawn/bin/main; \
    chmod +x $REALMFOLDER/live/bin/roommgr; \
    chmod +x $REALMFOLDER/live/bin/st*; \
    chmod +x setUpdateIp.sh startrealm.sh

EXPOSE 22
EXPOSE $UPDATE_PORT $GAME_PORT $TEST_PORT $ROUTER_PORT $DATAMG_PORT

ENV REALMFOLDER=$REALMFOLDER
ENV DBNAME=$DBNAME
ENV DBUSER=$DBUSER
ENV DBPASS=$DBPASS
