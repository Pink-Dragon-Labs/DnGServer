#!/bin/bash
MYSQL_USER=root
MYSQL_PWD=1234

#Use rar or tar ?
 use_rar=true;

#Use scp to clear files ?
 use_scp=true;

# Backup dir no trailing /
 backup_path="/root/Backups/db_backup"

# The database to backup
 db_name="realmdb"

# Create backup directory
if [ ! -d $backup_path ]; then
    mkdir $backup_path
fi

# Get date and time script is run
 date=$(date +"%d-%b-%Y:%H:%M")

 archiveFilename=$backup_path/$db_name-$date
 sqlFilename=$backup_path/$db_name-$date.sql


# Set umask permissions
 umask 177

# Run the dump
 mysqldump --user=$MYSQL_USER --password=$MYSQL_PWD --host=localhost $db_name > $sqlFilename

#Compress it
if $use_rar; then
 archiveFilename="$archiveFilename.rar"
 rar a $archiveFilename $sqlFilename
else
 archiveFilename="$archiveFilename.gz"
 tar czvf $archiveFilename $sqlFilename
fi

# Delete the orig dump if we were able to compress it
 if [ -f "$archiveFilename" ]
 then
    rm $sqlFilename
 fi