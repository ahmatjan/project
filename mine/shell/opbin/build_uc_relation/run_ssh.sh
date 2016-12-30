#!/bin/sh

source ./host_list.sh

order_list[0]='ssh ${user}@${host} "mkdir -p /home/${user}/.ssh"'
order_list[1]='ssh ${user}@${host} "mkdir -p /home/${user}/.ssh"'
order_list[2]='ssh ${user}@${host} "chmod 755 /home/${user}/"'
order_list[3]='ssh ${user}@${host} "chmod 700 /home/${user}/.ssh"'
order_list[4]='ssh ${user}@${host} "touch /home/${user}/.ssh/authorized_keys"'
order_list[5]='ssh ${user}@${host} "chmod 600 /home/${user}/.ssh/authorized_keys"'
order_list[6]='ssh ${user}@${host} "rm -f /home/${user}/id_rsa.pub*"'
order_list[7]='ssh ${user}@${host} "wget ftp://tc-sf-drd30.tc.baidu.com/home/rd/yangkai/build_relation/id_rsa.pub"'
order_list[8]='ssh ${user}@${host} "cat /home/${user}/id_rsa.pub >> /home/${user}/.ssh/authorized_keys"'
order_list[9]='ssh ${user}@${host} "rm /home/${user}/id_rsa.pub*"'

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
