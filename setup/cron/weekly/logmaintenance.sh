#!/bin/bash

date=$(date +"%d-%b-%Y:%H:%M")

logDir="/opt/streborn/live/logs"
logArchive="/root/Backups/logs"

if [ ! -d $logArchive ]; then
     mkdir $logArchive
fi

if [ ! -d $logArchive/$date ]; then
     mkdir $logArchive/$date
fi

mv $logDir/permanent/hacks.log $logArchive/$date/hacks.log
mv $logDir/chat.log $logArchive/$date/chat.log
mv $logDir/roommgr.log $logArchive/$date/roommgr.log
mv $logDir/fatal.log $logArchive/$date/fatal.log
mv $logDir/msgstats.txt $logArchive/$date/msgstats.log
mv $logDir/system.log $logArchive/$date/system.log
mv $logDir/spelluse.txt $logArchive/$date/spelluse.log
