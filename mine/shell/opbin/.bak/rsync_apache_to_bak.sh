#!/bin/bash

today=`date +%Y%m%d`

host[0]="cp01-ecom-shifen07.cp01"
user[0]="work"
local_dir[0]='/home/yangkai04/local/apache/'
remote_dir[0]='/home/${user}/dashboard/apache/'

#delete log
rm /home/yangkai04/local/apache/logs/error_log
# main process

loop=${#host[*]}
idx=0
while [ $idx -lt $loop ]
do
	user=${user[$idx]}
	host=${host[$idx]}
	inner_loop=${#local_dir[*]}
	inner_idx=0
	while [ $inner_idx -lt $inner_loop ]
	do
		eval "rsync --bwlimit=20480 -av ${local_dir[$inner_idx]} -P ${user}@${host}:${remote_dir[$inner_idx]}"
		inner_idx=`expr $inner_idx + 1`
	done
	idx=`expr $idx + 1`
done

