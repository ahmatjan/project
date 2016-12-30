#!/bin/bash

MARK="$0.running"

if [ -f "${MARK}" ]
then
	echo "${MARK} exist, rsync exit!"
	exit 0
fi

touch ${MARK}

machines="cq01-fc-bgt-log00.cq01" 
i=0
src_var_log[$i]='/home/work/var/bcmain/cq01-fc-bgt00/'
dst_var_log[$i]='/home/work/var/bcmain/cq01-fc-bgt00/'
((i++))
src_var_log[$i]='/home/work/var/bcmain/cq01-fc-bgt01/'
dst_var_log[$i]='/home/work/var/bcmain/cq01-fc-bgt01/'
((i++))
src_var_log[$i]='/home/work/var/bcmain/st01-fc-bgt00/'
dst_var_log[$i]='/home/work/var/bcmain/st01-fc-bgt00/'
((i++))
src_var_log[$i]='/home/work/var/bcmain/st01-fc-bgt01/'
dst_var_log[$i]='/home/work/var/bcmain/st01-fc-bgt01/'
((i++))
src_var_log[$i]='/home/work/var/bcmain/'
dst_var_log[$i]='/home/work/var/bcmain/'
exclude_paths[$i]='--exclude="cq01-fc-bgt00/" --exclude="cq01-fc-bgt01/" --exclude="st01-fc-bgt00/" --exclude="st01-fc-bgt01/"'
((i++))
src_var_log[$i]='/home/work/var/integ/cq01-fc-bgt00/'
dst_var_log[$i]='/home/work/var/integ/cq01-fc-bgt00/'
((i++))
src_var_log[$i]='/home/work/var/integ/cq01-fc-bgt01/'
dst_var_log[$i]='/home/work/var/integ/cq01-fc-bgt01/'
((i++))
src_var_log[$i]='/home/work/var/integ/st01-fc-bgt00/'
dst_var_log[$i]='/home/work/var/integ/st01-fc-bgt00/'
((i++))
src_var_log[$i]='/home/work/var/integ/st01-fc-bgt01/'
dst_var_log[$i]='/home/work/var/integ/st01-fc-bgt01/'
((i++))
src_var_log[$i]='/home/work/var/integ/'
dst_var_log[$i]='/home/work/var/integ/'
exclude_paths[$i]='--exclude="cq01-fc-bgt00/" --exclude="cq01-fc-bgt01/" --exclude="st01-fc-bgt00/" --exclude="st01-fc-bgt01/"'
((i++))
src_var_log[$i]='/home/work/var/'
dst_var_log[$i]='/home/work/var/'
exclude_paths[$i]='--exclude="bcmain/" --exclude="integ/"'
((i++))

cmd_head="rsync -av  --bwlimit=20480 "

date_cnt=0
while [ $date_cnt -lt 2 ]
do
	the_day=`date -d"$date_cnt days ago" +"%Y%m%d"`
	echo ${the_day}
	
	for machine in $machines
	do
		echo "====================  rsync $machine "
		idx=0
		looptimes=${#src_var_log[*]}
		while [ $idx -lt $looptimes ] 
		do
			machine_name=$(echo "$machine" | awk -F"\." '{print $1}')
			eval local_path=${dst_var_log[$idx]}
			if [ ! -e ${local_path} ];then
				mkdir -p ${local_path}
			fi
			eval src_path=${src_var_log[$idx]}
			cmd="${cmd_head} ${exclude_paths[$idx]} ${machine}:${src_path} ${local_path}"
			echo "executing ${cmd}\n"
			eval ${cmd}
			if [ ! $? == 0 ];then
				echo "execute ${cmd} err"
				let idx++
				continue
			fi
			let idx++
		done
	done
	((date_cnt++))
done
	
rm ${MARK}

exit 0
