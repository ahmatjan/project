#!/bin/bash

today=`date +%Y%m%d`

lockfile $0.lock

i=0
host[$i]="cp01-ecom-shifen01.cp01"
user[$i]="yangkai04"
local_dir[$i]='/home/yangkai04'
remote_dir[$i]='/home/yangkai04'

((i++))
host[$i]="cp01-ecom-shifen07.cp01"
user[$i]="yangkai04"
local_dir[$i]='/home/yangkai04'
remote_dir[$i]='/home/yangkai04'

((i++))
host[$i]="cp01-sf-toadbk02.cp01"
user[$i]="work"
local_dir[$i]='/home/yangkai04'
remote_dir[$i]='/home/disk11/yangkai04'

rm /home/yangkai04/errHunter_versions.txt

loop=${#host[*]}
idx=0
while [ $idx -lt $loop ]
do
	ssh ${user[$idx]}@${host[$idx]} "mkdir -p ${remote_dir[$idx]}"
	eval "rsync --bwlimit=20480 -av ${exclude_dir[$idx]} ${local_dir[$idx]}/ -P ${user[$idx]}@${host[$idx]}:${remote_dir[$idx]}/"
	if [ 0 -ne $? ]
	then
		echo "rsync --bwlimit=20480 -av ${exclude_dir[$idx]} ${local_dir[$idx]}/ -P ${user[$idx]}@${host[$idx]}:${remote_dir[$idx]}/" | mail -s "[ÏßÏÂ¼à¿Ø]`hostname`:`pwd`/$0 rsync error" yangkai04@baidu.com
	fi
	idx=`expr $idx + 1`
done

rm -f $0.lock

