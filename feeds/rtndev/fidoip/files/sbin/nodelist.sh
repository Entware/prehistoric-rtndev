#!/bin/sh
CWD=`pwd`
OSNAME=`uname`
USERNAME=`whoami`
date=`date +%Y%m%d%m%s`

T1="root"
T2="Linux"
T3="FreeBSD"

if [ "$T2" = "$OSNAME" ]; then
echo ''
echo 'Detecting OS...'
echo 'Your OS is Linux.'
echo 'Updating golded nodelist index.'
/opt/sbin/gnlnx -C /opt/etc/golded+/golded.cfg
fi

if [ "$T3" = "$OSNAME" ]; then
echo ''
echo 'Detecting OS...'
echo 'Your OS is FreeBSD.'
echo 'Updating golded nodelist index.'
/opt/sbin/goldnode -C /opt/etc/golded+/golded.cfg
fi

