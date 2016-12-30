#!/bin/sh

source ./host_list/host_list.sh

order_list[0]='ssh ${user}@${host} "ls /home/work/var/result_log"'

loop=${#host[*]}
i=0;
echo ${loop}

while [ $i -lt $loop ]
do
	user=${user[$i]}
	host=${host[$i]}
	order_loop=${#order_list[*]}
	order_i=0;
	echo "-------------------------------------------------"
	while [ $order_i -lt $order_loop ]
	do
		echo $order_i
		order="${order_list[$order_i]}"
		eval "echo $order"
		eval "$order"
		((order_i++))
	done
	echo "-------------------------------------------------"
	((i++))
done
