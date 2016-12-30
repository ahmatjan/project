#!/bin/bash

# General log rotate script for c programs
# by lizhaowen@baidu.com 20110725
i=0
path[$i]="/home/work/fc-shark/bcmain/log"
log[$i]="bcmain.log bcmain.log.trace bcmain.log.wf"
split[$i]="60"	# minute
reserv[$i]="8"	# day
((i++))

path[$i]="/home/work/fc-shark/bmqget/log"
log[$i]="bmqget.log bmqget.log.wf zookeeper.log"
split[$i]="60"
reserv[$i]="15"
((i++))

path[$i]="/home/work/fc-shark/bmqget_bd_finance/log"
log[$i]="bmqget.log bmqget.log.wf zookeeper.log"
split[$i]="60"
reserv[$i]="15"
((i++))

path[$i]="/home/work/fc-shark/bmqget_pool_conf/log"
log[$i]="bmqget.log bmqget.log.wf zookeeper.log"
split[$i]="60"
reserv[$i]="15"
((i++))

path[$i]="/home/work/fc-shark/bmqsend/log"
log[$i]="bmqsender.log  bmqsender.log.wf zookeeper.log"
split[$i]="60"
reserv[$i]="15"
((i++))

path[$i]="/home/work/fc-shark/integrator/log"
log[$i]="integ.log integ.log.wf"
split[$i]="60"
reserv[$i]="45"
((i++))

path[$i]="/home/work/fc-shark/msgget-bdclk/log"
log[$i]="msgget-bdclk.log msgget-bdclk.log.wf"
split[$i]="60"
reserv[$i]="15"
((i++))

path[$i]="/home/work/fc-shark/msgget-fcclk/log"
log[$i]="msgget-fcclk.log msgget-fcclk.log.wf"
split[$i]="60"
reserv[$i]="15"
((i++))

path[$i]="/home/work/fc-shark/msgget-fcorgclk/log"
log[$i]="msgget-fcorgclk.log msgget-fcorgclk.log.wf"
split[$i]="60"
reserv[$i]="15"
((i++))

path[$i]="/home/work/fc-shark/msgget-wbudget/log"
log[$i]="msgget-wbudget.log msgget-wbudget.log.wf"
split[$i]="60"
reserv[$i]="15"
((i++))

path[$i]="/home/work/fc-shark/msgget-planinfo/log"
log[$i]="msgget-planinfo.log msgget-planinfo.log.wf"
split[$i]="60"
reserv[$i]="15"
((i++))

path[$i]="/home/work/fc-shark/msgget-zx-budget/log"
log[$i]="msgget-zx-budget.log  msgget-zx-budget.log.wf  zookeeper.log"
split[$i]="60"
reserv[$i]="15"
((i++))

path[$i]="/home/work/fc-shark/msgget_rebateclk/log"
log[$i]="msgget-rebateclk.log  msgget-rebateclk.log.wf  zookeeper.log"
split[$i]="60"
reserv[$i]="15"
((i++))

path[$i]="/home/work/fc-shark/msgget-bdbudget/log/"
log[$i]="msgget-bdbudget.log  msgget-bdbudget.log.wf  zookeeper.log"
split[$i]="60"
reserv[$i]="15"
((i++))

path[$i]="/home/work/fc-shark/msgget-bd-rebateclk/log/"
log[$i]="msgget.log  msgget.log.wf  zookeeper.log"
split[$i]="60"
reserv[$i]="15"
((i++))

path[$i]="/home/work/fc-shark/msgget-bd-rawclk/log/"
log[$i]="msgget.log  msgget.log.wf  zookeeper.log"
split[$i]="60"
reserv[$i]="15"
((i++))

path[$i]="/home/work/fc-shark/msgget-bindrelation/log/"
log[$i]="msgget-bindrelation.log  msgget-bindrelation.log.wf  zookeeper.log"
split[$i]="60"
reserv[$i]="15"
((i++))

path[$i]="/home/work/fc-shark/msgget_deltaplaninfo/log/"
log[$i]="msgget.log  msgget.log.wf  zookeeper.log"
split[$i]="60"
reserv[$i]="15"
((i++))

path[$i]="/home/work/fc-shark/msgget_deltabudget/log/"
log[$i]="msgget.log  msgget.log.wf  zookeeper.log"
split[$i]="60"
reserv[$i]="15"
((i++))

today=`date -d "10 minute ago" +%Y%m%d`
idx=0
loop=${#path[*]}
while [ $idx -lt $loop ]
do
	cd ${path[$idx]}
	if [ ! $? -eq 0 ];then
		echo "Can't access to ${path[$idx]}!"
		exit 1
	fi

	mkdir -p ${path[$idx]}/logbk/$today

	hour=`date -d "10 minute ago" +%H`
	min=`date -d "10 minute ago" +%M`
	min=`expr $min / ${split[$idx]} \* ${split[$idx]}`
	if [ $min -lt 10 ];then
		min="0"$min
	fi

	goodbye_day=`date -d "${reserv[$idx]} day ago" +%Y%m%d`
	goodbye_day_before=$(date -d "$(expr ${reserv[$idx]} + 1) day ago" +%Y%m%d)

	for log_bak in ${log[$idx]}
	do
		cp $log_bak logbk/$today/$log_bak.${hour}${min}
		:> $log_bak
		rm -f logbk/$goodbye_day/$log_bak.${hour}${min}
	done

	if [ -d "logbk/${goodbye_day_before}" ];then
		rmdir logbk/${goodbye_day_before}
	fi

	idx=`expr $idx + 1`
done
