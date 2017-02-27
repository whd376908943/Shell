#!/usr/bin/bash
for ip in 192.168.{10.{150,151,153,154},50.{3,4,8,51,52,57,118}}
do
ping $ip -c 1 > /dev/null 2>&1
res=$?
if [ $res -ne 0 ];then
/usr/bin/sendEmail -f sysadmin@cmcaifu.com -s mail.cmcaifu.com -u server-alive-state -xu sysadmin -xp 'Abcd1234#' -m "$ip is down at `date '+%Y-%m-%d %H:%M:%S'`" -o message-content-type=html -o message-charset=utf8 -t wanghuidong@cmcaifu.com
fi
done
