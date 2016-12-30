#!/bin/sh

BEGIN_DATE="20140225"
END_DATE="20140226"

BEGIN="${BEGIN_DATE:0:4}-${BEGIN_DATE:4:2}-${BEGIN_DATE:6:2} 00:00:00"
END="${END_DATE:0:4}-${END_DATE:4:2}-${END_DATE:6:2} 23:59:59"
STEP="$((900))"
FORMAT="%Y%m%d-%H%M"

cur_s=$(date -d" ${BEGIN}" +"%s")
end_s=$(date -d" ${END}" +"%s")

INPUT_LIST=""

i=0
#log[$i]='/home/yangkai04/project/work.shark/app/ecom/fengchao/fc-shark/bcmain/tools/dump_correct/data/qs_im/${day}/qs_budget.${day}-${hour}${quarter}.log'
#log[$i]='/home/yangkai04/project/work.shark/app/ecom/fengchao/fc-shark/bcmain/tools/dump_correct/data/siva_im/${day}/sivabudget.${day}-${hour}${quarter}.log'
log[$i]='/home/yangkai04/project/work.shark/app/ecom/fengchao/fc-shark/bcmain/tools/dump_correct/data/zx_im/${day}/zxbudget.${day}-${hour}${quarter}.log'
((i++))

idx=0 
loop=${#log[*]}
while [ $idx -lt $loop ]
do
    while [ "${cur_s}" -lt "${end_s}" ]
    do
    	cur=$(date -d" 00:00:00 1970-01-01 UTC +${cur_s} sec " +"${FORMAT}")
    	day=${cur:0:8}
        hour=${cur:9:2}
        quarter=${cur:11:2}
    
        file=`eval echo ${log[$idx]}`
        touch ${file}
    	cur_s=$((cur_s + STEP))
    done
    ((idx++))
done


