#!/bin/bash

MAIL_LIST="yangkai04@baidu.com"
outfile=$0.txt

time_now=$(date +%s)
time_sec=$((time_now/900*900))
YMD=$(date -d "1970-01-01 UTC $time_sec seconds" +%Y%m%d)
HHMM=$(date -d "1970-01-01 UTC $time_sec seconds" +%H%M)
IDX_FILE=`find /home/work/dashboard/add_* -name "add.idx"`
THRESHOLD=3600

:> ${outfile}
(
awk 'BEGIN{
	FS=OFS="\t";
	time_stamp="'$YMD'-'$HHMM'";
	min_time_stamp=time_stamp;
	filename=""
	threshold='${THRESHOLD}'+0
}
{
	if(NF<2)
	{
		next;
	}
	if(min_time_stamp > $1)
	{
		min_time_stamp = $1;
		filename=FILENAME;
	}
}
END{
	mintime=mktime(substr(min_time_stamp,1,4)" "substr(min_time_stamp,5,2)" "substr(min_time_stamp,7,2)" "substr(min_time_stamp,10,2)" "substr(min_time_stamp,12,2)" 00");
	nowtime=mktime(substr(time_stamp,1,4)" "substr(time_stamp,5,2)" "substr(time_stamp,7,2)" "substr(time_stamp,10,2)" "substr(time_stamp,12,2)" 00");
	timediff = nowtime - mintime;
	if (timediff > threshold)
	{
		nowtime_str=strftime("%Y-%m-%d %H:%M:%S", nowtime);
		mintime_str=strftime("%Y-%m-%d %H:%M:%S", mintime);
		print "filename["filename"], nowtime["nowtime_str"] - mintime["mintime_str"] > threshold["threshold"]";
	}
}' ${IDX_FILE}
) >> ${outfile}
buff=`cat ${outfile}`
if [ ! -z "${buff}" ]
then
	echo ${buff} | mail -s "[ÏßÏÂ¼à¿Ø]`hostname`/$0 idx ¼à¿Ø" "$MAIL_LIST"
fi
