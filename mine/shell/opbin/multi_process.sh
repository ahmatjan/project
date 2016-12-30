#!/bin/sh
EXCEED_TIME=60
PROCESS_NUM=5
LOG_FILE="$0.log"
:> "${LOG_FILE}"

start_time=`date +"%Y-%m-%d %H:%M:%S"`
echo ${start_time} >> ${LOG_FILE}

function multi_process() {
SUB_PROCESS_ID_LIST=""
TEMP_FIFOFILE="/tmp/$$.fifo"
mkfifo "$TEMP_FIFOFILE" 
exec 6<>"$TEMP_FIFOFILE"
for((i=0;i<$PROCESS_NUM;i++))
do
    echo
done >&6 

idx=0
while [ $idx -lt ${PROCESS_NUM} ]
do
    read -u 6 
    { 
        echo "PROCESS[$!] run[${EXE_PATH[${idx}]}]"
        sleep 10
        echo >&6
    }&
    SUB_PROCESS_ID_LIST="${SUB_PROCESS_ID_LIST} $!"
    ((idx++))
done

echo "SUB_PROCESS_ID_LIST:${SUB_PROCESS_ID_LIST}"

wait                                                                                            
exec 6>&-  
}

multi_process

end_time=`date +"%Y-%m-%d %H:%M:%S"`
echo ${end_time} >> ${LOG_FILE}

