#!/bin/bash

today=`date +%Y%m%d`

i=0
#host[$i]="cq01-fc-bgt-log00.cq01"
#user[$i]="work"
#remote_dir[$i]='/home/work/var/watch_log'
#local_dir[$i]='/home/yangkai04/var/watch_log'
#((i++))
host[$i]="cq01-sf-chgrd00.cq01"
user[$i]="work"
remote_dir[$i]='/home/work/var/result_log'
local_dir[$i]='/home/yangkai04/var/result_log'
((i++))

loop=${#host[*]}
idx=0
while [ $idx -lt $loop ]
do
	mkdir -p ${local_dir[$idx]}
	eval "rsync --bwlimit=20480 -av ${user[$idx]}@${host[$idx]}:${remote_dir[$idx]}/ -P ${local_dir[$idx]}/"
	if [ 0 -ne $? ]
	then
		echo "rsync --bwlimit=20480 -av ${user[$idx]}@${host[$idx]}:${remote_dir[$idx]}/ -P ${local_dir[$idx]}/" | mail -s "[ÏßÏÂ¼à¿Ø]`hostname`:`pwd`/$0 rsync error" yangkai04@baidu.com
	fi
	idx=`expr $idx + 1`
done

