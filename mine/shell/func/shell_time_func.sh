#!/bin/bash

##! @TODO: 时间通用函数
##! @VERSION: 1.0.0.0
##! @AUTHOR: yangkai04@baidu.com

DAY="20141218"

date -d "1 day ago ${DAY}" +"%Y%m%d"

DAY_="${DAY:0:4}-${DAY:4:2}-${DAY:6:2}"
echo ${DAY_}

DAYS=`expr $(date -d"${DAY:0:4}-${DAY:4:2}-${DAY:6:2} 00:00:00 UTC" +"%s") \/ 86400`
echo ${DAYS}

SECONDS=`date +"%s"`
DATE=`date -d"1970-01-01 UTC ${SECONDS} seconds" +"%Y-%m-%d %H:%M:%S"`
echo ${DATE}

TOTAL_WEEKS=$(expr ${SECONDS} / $(expr 86400 \* 7 ))
echo ${TOTAL_WEEKS}

MONDAY_SECONDS=$(expr $(expr ${TOTAL_WEEKS} \* 86400) \* 7)
echo ${MONDAY_SECONDS}

MONDAY=`date -d"1970-01-01 UTC ${MONDAY_SECONDS} seconds" +"%Y-%m-%d %H:%M:%S"`
echo ${MONDAY}


# loop
BEGIN_DATE=`date -d"1 days ago" +"%Y%m%d"`
END_DATE=`date -d"1 days ago" +"%Y%m%d"`
BEGIN_DATE="20141117"
END_DATE="20141120"

BEGIN="${BEGIN_DATE:0:4}-${BEGIN_DATE:4:2}-${BEGIN_DATE:6:2} 00:00:00"
END="${END_DATE:0:4}-${END_DATE:4:2}-${END_DATE:6:2} 23:59:00"
STEP="$((86400))"
FORMAT="%Y%m%d"

cur_s=$(date -d" ${BEGIN}" +"%s")
end_s=$(date -d" ${END}" +"%s")

while [ "${cur_s}" -lt "${end_s}" ]
do
    cur=$(date -d" 00:00:00 1970-01-01 UTC +${cur_s} sec " +"${FORMAT}")
    echo ${cur}
    cur_s=$((cur_s + STEP))
done
