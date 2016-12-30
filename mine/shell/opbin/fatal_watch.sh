#!/bin/bash

outfile=$0.txt

MAIL_LIST="yangkai04@baidu.com"

DELAY_SEC=60
DETAIL=`date -d''${DELAY_SEC}' sec ago' +"%m-%d %H:%M:"`

#配置日志的路径
i=0
all_path=""
:> ${outfile}
find /home/work/dashboard/* -name "*log" | while read line
do
	#echo "num:${i}"
	#sub_path="${line}"
	#echo ${sub_path}/*.*
	CONTENT=`grep "FATAL" ${line} | grep -v "ack failed"`
	if [ ! -z "${CONTENT}" ]
	then
	echo "${line}" >> ${outfile}
	echo "${CONTENT}" >> ${outfile}
	fi
	((i++))
done


if [ `cat ${outfile} | wc -l` -ne 0 ];then
	head -n 100 ${outfile} | mail -s "[线下监控]`hostname`:`pwd`/$0 FATAL 监控" "$MAIL_LIST"
fi

