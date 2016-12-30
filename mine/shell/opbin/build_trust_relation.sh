#!/bin/bash

user="rd"
host="tc-sf-drd28.tc"
user="yangkai04"
host="cq01-sf-vchgrd07.vm"
user="zhangxiao"
host="cq01-sf-vchgrd08.vm"
user="yangkai04"
host="cq01-sf-vchgrd07.vm"
user="work"
host="db-sf-antitp02.db01"
user="work"
host="db-sf-antitp03.db01"
user="work"
host="jx-sf-remora04.jx"
user="work"
host="cq01-testing-ecom135.vm"
user="work"
host="cq01-sf-vchgrd03.vm"
user="work"
host="cq01-fc-bgt-log00.cq01"
user="work"
host="st01-ecom-shifen01.st01"
user="work"
host="cq01-fc-bgt04.cq01.baidu.com"
user="work"
host="st01-fc-bgt04.st01.baidu.com"
user="yangkai04"
host="st01-ecom-shifen07.st01"""
user="yangkai04"
host="st01-ecom-shifen01.st01"""
user="work"
host="cq02-sf-toadbk02.cq02"
user="rd"
pass=""
host="jx-sf-drd30.jx"
user="work"
pass="chg213456"
host="cq02-sf-toadbk03.cq02"
user="root"
pass="tIILccRI"
host="cq02-sf-toadbk01.cq02"
user="root"
pass="fYzFsdl2"
host="cq02-sf-toadbk00.cq02"
host="cq01-sf-vchgrd07.vm"
user="zhangzhichao"

host="cq01-vs-health-as00.cq01"
user="work"

host="cq01-fc-wireless00.cq01"
user="work"

host="cp01-wangguiping.epc"
user="work"

host="cq01-sf-chgrd00.cq01"
user="work"

host="10.101.38.31"
user="yangkai04"

scp ~/.ssh/id_rsa.pub ${user}@${host}:/home/${user}/

i=0
order[$i]="mkdir -p /home/${user}/.ssh"
((i++))
order[$i]="cat /home/${user}/id_rsa.pub >> /home/${user}/.ssh/authorized_keys"
((i++))
order[$i]="rm /home/${user}/id_rsa.pub"
((i++))
order[$i]="chmod 755 /home/${user}"
((i++))
order[$i]="chmod 700 /home/${user}/.ssh"
((i++))
order[$i]="chmod 600 /home/${user}/.ssh/authorized_keys"
((i++))

idx=0
loop=${#order[*]}
while [ $idx -lt $loop ]
do
    expect_execute "${host}" "${user}" "${pass}" "${order[$idx]}"
    ((idx++))
done

#ssh ${user}@${host} "mkdir -p /home/${user}/.ssh"
#ssh ${user}@${host} "cat /home/${user}/id_rsa.pub >> /home/${user}/.ssh/authorized_keys"
#ssh ${user}@${host} "rm /home/${user}/id_rsa.pub"
#ssh ${user}@${host} "chmod 755 /home/${user}"
#ssh ${user}@${host} "chmod 700 /home/${user}/.ssh"
#ssh ${user}@${host} "chmod 600 /home/${user}/.ssh/authorized_keys"

