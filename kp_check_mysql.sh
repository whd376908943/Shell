#!/bin/bash
# Script function: check MySQL keepalived exchange
# Init Version 1.0
# Date:2015-11-02
# Write by 967409@qq.com
# Change log: none


# Env

#DB setting
DBUSER=dbcheck
DBPWD=
DBHOST=127.0.0.1
DBPORT=$1
MYSQLBINDIR=/data/mysql/bin
CHECK_SQL="update db_check.check_table set dataValue=dataValue+1 where id=1"

# Get IP address
#LanIP=`/sbin/ifconfig | grep "inet addr" | awk '{print $2}' | sed s/addr:// | grep "^172\|^192" | head -n 1`

# Mail disable or enable (0 is disable,1 is enable)
mailenable=1
#mailaddress=noc@lianshang.cn
mailaddress=tom.meng@lianshang.com


# check main process
# check mysql update
        a=$("$MYSQLBINDIR"/mysql -u"$DBUSER" -p"$DBPWD" -h"$DBHOST" -P"$DBPORT" -e "$CHECK_SQL" -vv | grep "1  Changed")
                if [ "$a" == "Rows matched: 1  Changed: 1  Warnings: 0" ];then
                alive1=1
                fi


# check mysqld process
        mysqlprocess=`/bin/ps aux | grep mysqld | wc -l`
                if [ "$mysqlprocess" != 1 ];then
                alive2=1
                fi


# check mysqld status
        b=$(/sbin/service mysqld status | grep running | wc -l)
                if [ "$b" == 1 ];then
                alive3=1
                fi


# Check mysql status and then kill keepalived process for change write from master to slave
        if [ "$alive1" == 1 -a "$alive2" == 1 -a "$alive3" == 1 ];then
                echo ''
        else
                #LanIP=`/sbin/ifconfig | grep "inet addr" | awk '{print $2}' | sed s/addr:// | grep "^172.16.11" | head -n 1`
                /bin/sleep 10
                #/etc/init.d/keepalived stop

                #if [ $mailenable=1 ];then
                #        /bin/mail -s "$LanIP KEEPALIVED STOPPED!!!" $mailaddress
                #fi
        fi
