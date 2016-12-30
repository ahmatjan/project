#!/bin/sh

source ../host_list/host_list.sh

#order_list[0]='ssh ${user}@${host} "ls id_rsa.pub"'
#order_list[1]='`scp id_rsa.pub ${user}@${host}://home/${user}/`'
#order_list[2]='ssh ${user}@${host} "ls /home/${user}/id_rsa.pub"'
#order_list[3]='ssh ${user}@${host} "cat /home/${user}/id_rsa.pub >> /home/${user}/.ssh/authorized_keys"'
#order_list[2]='ssh ${user}@${host} "cat /home/${user}/id_rsa.pub > /home/${user}/.ssh/authorized_keys"'
#order_list[4]='ssh ${user}@${host} "rm /home/${user}/id_rsa.pub"'
order_list[0]='ssh ${user}@${host} "grep -v yangkai04 /home/${user}/.ssh/authorized_keys | sort | uniq > /home/${user}/.ssh/authorized_keys.new"'
order_list[1]='ssh ${user}@${host} "chmod 600 /home/${user}/.ssh/authorized_keys.new"'
order_list[2]='ssh ${user}@${host} "mv /home/${user}/.ssh/authorized_keys.new /home/${user}/.ssh/authorized_keys"'
#order_list[2]='ssh ${user}@${host} "ls /home/${user}/.ssh/authorized_keys.new"'
#order_list[0]='ssh ${user}@${host} "ls /home/work/var/integ"'
#order_list[0]='`scp -r /home/yangkai04/bin ${user}@${host}://home/${user}/`'
#order_list[0]='ssh ${user}@${host} "ls /home/${user}/bin/pwd*"'
#order_list[0]='ssh ${user}@${host} "ls /home/${user}/bin/mykillall"'
#order_list[0]='ssh ${user}@${host} "mkdir -p /home/${user}/bin"'
#order_list[1]='`scp -r /home/yangkai04/bin/bd_plan_rate ${user}@${host}://home/${user}/bin/`'
#order_list[2]='`scp -r /home/yangkai04/bin/fc_user_rate ${user}@${host}://home/${user}/bin/`'
#order_list[3]='`scp -r /home/yangkai04/bin/chginfo ${user}@${host}://home/${user}/bin/`'

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
