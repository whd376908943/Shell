#!/bin/bash

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

export PATH

#数据库用户名

dbuser='root'

#数据库用密码

dbpasswd='********'

需要备份的数据库，多个数据库用空格分开

dbname='xiaohuai xiaohuai2'

#备份时间

backtime=`date +%Y%m%d%H%M%S`

#日志备份路径

logpath='/home/mysqlbak'

#数据备份路径

datapath='/home/mysqlbak'

#日志记录头部

echo ‘"备份时间为${backtime},备份数据库表 ${dbname} 开始" >> ${logpath}/log.log

#正式备份数据库

for table in $dbname; do

source=`mysqldump -u ${dbuser} -p${dbpasswd} ${table}> ${logpath}/${backtime}.sql` 2>> ${logpath}/mysqllog.log;

#备份成功以下操作

if [ "$?" == 0 ];then

cd $datapath

#为节约硬盘空间，将数据库压缩

tar jcf ${table}${backtime}.tar.bz2 ${backtime}.sql > /dev/null

#删除原始文件，只留压缩后文件

rm -f ${datapath}/${backtime}.sql

#删除七天前备份，也就是只保存7天内的备份

find $datapath -name "*.tar.bz2" -type f -mtime +7 -exec rm -rf {} \; > /dev/null 2>&1

echo "数据库表 ${dbname} 备份成功!!" >> ${logpath}/mysqllog.log

else

#备份失败则进行以下操作

echo "数据库表 ${dbname} 备份失败!!" >> ${logpath}/mysqllog.log

fi

done
