#!/bin/sh

LOG_FILE=${0%.*}.log
RESULT_FILE=${0%.*}.res
EXCEED_TIME=600

ps aux | grep "rsync" | grep -v "grep" | grep -v "$0" | awk '{print $0;}' > ${RESULT_FILE}
PROCESS_ID_LIST=`cat ${RESULT_FILE} | awk '{print $2;}' | sed ':a;N;$!ba;s/\n/ /g'`
echo "PROCESS_ID_LIST:${PROCESS_ID_LIST}"

sleep ${EXCEED_TIME}

MESSAGE=""
idx=0
for subid in ${PROCESS_ID_LIST}
do
    ps -p ${subid} >> ${LOG_FILE} 2>&1
    if [ $? -eq 0 ]
    then
        MESSAGE="${MESSAGE}SUB PROCESS[${subid}] run exceed [${EXCEED_TIME}] seconds exist!\n"
    fi
    ((idx++))
done

if [ ! -z "${MESSAGE}" ]
then
    MESSAGE="${MESSAGE}\n\n name list:\n`cat ${RESULT_FILE}`"
    echo -e "${MESSAGE}" | mail -s "[线下监控]`hostname`:`pwd`/$0 ABNORMAL!" "yangkai04@baidu.com"
fi

process_num=`ps axu | wc -l`
if [ ${process_num} -gt 350 ]
then
    echo -e "process num : ${process_num}" | mail -s "[线下监控]`hostname`:`pwd`/$0 ABNORMAL!" "yangkai04@baidu.com"
fi

