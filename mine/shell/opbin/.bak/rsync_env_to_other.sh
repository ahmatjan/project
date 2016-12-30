#!/bin/bash

today=`date +%Y%m%d`

host[0]="cq01-sf-vchgrd00.vm"
user[0]="work"
local_dir[0]='/home/yangkai04/bin/'
remote_dir[0]='/home/${user}/bin/'
local_dir[1]='/home/yangkai04/.bash_profile'
remote_dir[1]='/home/${user}/.bash_profile'
local_dir[2]='/home/yangkai04/.vim/'
remote_dir[2]='/home/${user}/.vim/'
local_dir[3]='/home/yangkai04/.vimrc'
remote_dir[3]='/home/${user}/.vimrc'
local_dir[4]='/home/yangkai04/local/'
remote_dir[4]='/home/${user}/local/'
local_dir[5]='/home/yangkai04/btest/'
remote_dir[5]='/home/${user}/btest/'
local_dir[6]='/home/yangkai04/CI/'
remote_dir[6]='/home/${user}/CI/'
local_dir[7]='/home/yangkai04/opbin/'
remote_dir[7]='/home/${user}/opbin/'

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

