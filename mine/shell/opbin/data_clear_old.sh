#!/bin/bash

# General data clear script for dorado
# by lizhaowen 20110725

i=0
data[$i]='/home/work/var/watch_log/*/*$day*'
reserve_day[$i]='365'
((i++))

data[$i]='/home/work/var/integ/*/$day'
reserve_day[$i]='6'
((i++))

data[$i]='/home/work/var/finance/*/$day'
((i++))

data[$i]='/home/work/var/budget/*/$day'
((i++))

data[$i]='/home/work/var/bmqsend/*/$day'
((i++))

data[$i]='/home/work/var/bcmain/*/$day'
reserve_day[$i]='30'
((i++))

data[$i]='/home/work/fc-shark/*/log/*/logbk/$day'
((i++))

reserve_default="7"

idx=0
loop=${#data[*]}
while [ $idx -lt $loop ]
do
        if [ -n "${reserve_day[$idx]}" ];then
                day=`date -d "${reserve_day[$idx]} day ago" +%Y%m%d`
        else
                day=`date -d "${reserve_default} day ago" +%Y%m%d`
        fi
        eval "rm -rf ${data[$idx]}"
        #eval "echo ${data[$idx]}"
        idx=`expr $idx + 1`
done
exit 0   



