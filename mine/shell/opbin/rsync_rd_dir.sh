#!/bin/bash

source ./host_list/host_list.sh

lockfile $0.lock

log_file="$0.log"

subfix_list=".sh .py .conf"
for subfix in ${subfix_list}
do
    outter_idx=0
    while [ ${outter_idx} -lt ${#host[*]} ]
    do
        if [ "${user[$outter_idx]}" == "rd" ]
        then
            remote_dir="/home/${user[$outter_idx]}/"
            local_dir="/home/yangkai04/shell/machine_rd/${host[$outter_idx]}/"
        
        	filenames=(`ssh ${user[$outter_idx]}@${host[$outter_idx]} " [ -d ${remote_dir} ] && cd ${remote_dir} && find . -name \"*${subfix}\""`)
        
        	idx=0
        	echo ${#filenames[*]}
        	while [ $idx -lt ${#filenames[*]} ]
        	do
                echo ""
                echo "#################################################"
                echo "subfix[${subfix}] IN total subfix[${subfix_list}]"
        		echo "host[${outter_idx}] IN total host[${#host[*]}]"
                echo "file[${idx}] IN total file[${#filenames[*]}]"
                echo "filename[${filenames[$idx]}]"
        		file_path=${local_dir}/${filenames[$idx]%/*}
        		file_path_name_local=${local_dir}/${filenames[$idx]}
        		file_path_name_remote=${remote_dir}/${filenames[$idx]}
        		mkdir -p ${file_path}
                echo "${user[$outter_idx]}@${host[$outter_idx]}:${file_path_name_remote}"
        		eval "rsync --bwlimit=20480 -av ${user[$outter_idx]}@${host[$outter_idx]}:${file_path_name_remote} -p ${file_path_name_local}"
        		((idx++))
    	    done
        else
            echo "not rd dir, ignored"
        fi
    	((outter_idx++))
    done
done

rm -f $0.lock

