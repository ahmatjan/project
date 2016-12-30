#!/bin/bash

user="work"
host="cq01-fc-bgt-log00.cq01"
remote_dir='/home/work/fc-shark/shell_report/'
local_dir='./shell_report/shark_report/'

filenames=(`ssh ${user}@${host} "cd ${remote_dir} && find . -name \"*.sh\""`)

idx=0
echo ${#filenames[*]}
while [ $idx -lt ${#filenames[*]} ]
do
	echo $idx":"${filenames[$idx]}
	file_path=${local_dir}/${filenames[$idx]%/*}
	file_path_name_local=${local_dir}/${filenames[$idx]}
	file_path_name_remote=${remote_dir}/${filenames[$idx]}
	mkdir -p ${file_path}
	eval "rsync --bwlimit=20480 -av work@${host}:${file_path_name_remote} -p ${file_path_name_local}"
	((idx++))
done

