#!/bin/bash

# General log rotate script for c programs
# by yangkai04@baidu.com 20140328

SPLIT_DEFAULT="60"
RESERV_DEFAULT="1"
LOG_PATH_ROOT="/home/work/dashboard/"

i=0
find ${LOG_PATH_ROOT}/* -name "log" | while read line
do
	today=`date -d "10 minute ago" +%Y%m%d`
	subpath=${line}
	echo "num:$i"
	path[$i]=${subpath}
	echo ${path[$i]}
	log[$i]=`cd ${subpath} && ls *.*`
	echo ${log[$i]}
	split[$i]="${SPLIT_DEFAULT}"
	echo ${split[$i]}
	reserv[$i]="${RESERV_DEFAULT}"
	echo ${reserv[$i]}

	cd ${path[$i]}
	if [ ! $? -eq 0 ];then
		echo "Can't access to ${path[$i]}!"
		exit 1
	fi

	mkdir -p ${path[$i]}/logbk/$today

	hour=`date -d "10 minute ago" +%H`
	min=`date -d "10 minute ago" +%M`
	min=`expr $min / ${split[$i]} \* ${split[$i]}`
	if [ $min -lt 10 ];then
		min="0"$min
	fi

	goodbye_day=`date -d "${reserv[$i]} day ago" +%Y%m%d`
	goodbye_day_before=$(date -d "$(expr ${reserv[$i]} + 1) day ago" +%Y%m%d)

	for log_bak in ${log[$i]}
	do
		cp $log_bak logbk/$today/$log_bak.${hour}${min}
		:> $log_bak
		rm -f logbk/$goodbye_day/$log_bak.${hour}${min}
	done

	if [ -d "logbk/${goodbye_day_before}" ];then
		rmdir logbk/${goodbye_day_before}
	fi

	((i++))
done

