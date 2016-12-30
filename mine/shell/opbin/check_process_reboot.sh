#!/bin/sh

LOG_FILE=$0.log
EXCEED_TIME=500

OUTPUT_FILE=$0.txt
PROCESS_ID_LIST=`ps aux | grep "add_" | grep -v "grep" | grep -v "$0" | awk '{print $NF"("$2")";}' | sed ':a;N;$!ba;s/\n/ /g'`
echo "PROCESS_ID_LIST:${PROCESS_ID_LIST}"

MESSAGE=""
idx=0
for subid in ${PROCESS_ID_LIST}
do
	num=`grep ${subid} ${OUTPUT_FILE} | wc -l`
	if [ ${num} -ne 1 ]
	then
		MESSAGE="${MESSAGE}SUB PROCESS[${subid}] reboot!\n"
	fi
	((idx++))
done

if [ ! -z "${MESSAGE}" ]
then
    MESSAGE="${MESSAGE}\n\n before:`cat ${OUTPUT_FILE}`"
    echo -e "${MESSAGE}" | mail -s "[ÏßÏÂ¼à¿Ø]`hostname`:`pwd`/$0 ABNORMAL!" "yangkai04@baidu.com"
fi

echo ${PROCESS_ID_LIST} > ${OUTPUT_FILE}
