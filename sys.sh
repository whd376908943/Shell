#/bin/bash


# cpu

cpu=`top -bi -n 2 -d 0.1 | grep Cpu | tail -1 `
us=`echo $cpu | awk -F'[ %]' '{print $2}'`
sy=`echo $cpu | awk -F'[ %]' '{print $4}'`
id=`echo $cpu | awk -F'[ %]' '{print $8}'`
if [ "$a" == "id," ];then
id=100.0
fi

# mem

Mem=`free -m | grep Mem`
mem_total=`echo $Mem | awk '{print $2}'`
mem_used=`echo $Mem | awk '{print $3}'`
mem=`awk 'BEGIN{printf "%.2f\n",'$mem_used'/'$mem_total'}'`

# load

uptime=`uptime`
uptime_15=` echo $uptime | awk '{print $11}'`

# disk

lv_root=`df -Th | grep root`
root_used=` echo $lv_root | awk '{print $6}'`
lv_home=`df -Th | grep home`
home_used=` echo $lv_home | awk '{print $6}'`

content="
sys_info

cpu_info:
kernel_space : ${sy} 
user_space : ${us} 
free_space : ${id} 

mem_info:
mem : ${mem} 

load_info:
load : ${uptime_15} 

disk_info:
/ : ${root_used} 
/home : ${home_used}

"
echo "$content" | /bin/mail -s 'sys_info' wanghuidong@vjwealth.com
                                                               
