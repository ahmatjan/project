#!/bin/bash

today=`date +%Y%m%d`

lockfile $0.lock

i=0
host[$i]="cp01-vchgrd00.epc"
user[$i]="yangkai04"
remote_dir[$i]='/home/yangkai04'
local_dir[$i]='/home/yangkai04/shell/vchgrd00'
((i++))

host[$i]="cp01-sf-toadbk02.cp01"
user[$i]="work"
remote_dir[$i]='/home/work/local/apache/htdocs'
local_dir[$i]='/home/yangkai04/shell/toadbk02/home/work/local/apache/htdocs'
((i++))

host[$i]="cp01-sf-toadbk02.cp01"
user[$i]="work"
remote_dir[$i]='/home/work/local/apache/conf'
local_dir[$i]='/home/yangkai04/shell/toadbk02/home/work/local/apache/conf'
((i++))

host[$i]="cp01-sf-toadbk02.cp01"
user[$i]="work"
remote_dir[$i]='/home/work/local/php'
local_dir[$i]='/home/yangkai04/shell/toadbk02/home/work/local/php'
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

rm -f $0.lock
