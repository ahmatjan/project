#!/bin/sh
EXE_PATH[0]="circle.sh"
EXE_PATH[1]="run_ssh.sh"
EXCEED_TIME=600
PROCESS_NUM=${#EXE_PATH[*]}
LOG_FILE="$0.log"
:> "${LOG_FILE}"

SUB_PROCESS_ID_LIST=""
TEMP_FIFOFILE="/tmp/$$.fifo"
mkfifo "$TEMP_FIFOFILE" 
exec 6<>"$TEMP_FIFOFILE"
for((i=0;i<$PROCESS_NUM;i++))
do
    echo
done >&6 

loop=${#EXE_PATH[*]}
idx=0
while [ $idx -lt $loop ]
do
    read -u 6 
    { 
        echo "PROCESS[$!] run[${EXE_PATH[${idx}]}]"
        sh ${EXE_PATH[${idx}]} >> ${LOG_FILE} 2>&1
        if [ 0 -ne $? ] 
        then
            echo "PROCESS[$!] run error!" 
            exit 1
        fi
        sleep 2
        echo >&6
    }&
    SUB_PROCESS_ID_LIST="${SUB_PROCESS_ID_LIST} $!"
    ((idx++))
done

sleep ${EXCEED_TIME}
#echo "SUB_PROCESS_ID_LIST:${SUB_PROCESS_ID_LIST}"

MESSAGE=""
idx=0
for subid in ${SUB_PROCESS_ID_LIST}
do
    ps -p ${subid} >> ${LOG_FILE} 2>&1
    if [ $? -eq 0 ]
    then
        MESSAGE="${MESSAGE}SUB PROCESS[${subid}] [${EXE_PATH[${idx}]}] run exceed [${EXCEED_TIME}] seconds exist!\n"
    fi
    ((idx++))
done

#echo -e ${MESSAGE}

if [ ! -z "${MESSAGE}" ]
then
    echo -e "${MESSAGE}" | mail -s "[$0]`hostname` ABNORMAL!" "yangkai04@baidu.com"
fi

process_num=`ps axu | wc -l`
if [ ${process_num} -gt 200 ]
then
    echo -e "process num : ${process_num}" | mail -s "[ÏßÏÂ¼à¿Ø]`hostname`:`pwd`/$0 ABNORMAL!" "yangkai04@baidu.com"
fi

echo "main_process finished, wait sub process"

wait                                                                                            
exec 6>&-  
