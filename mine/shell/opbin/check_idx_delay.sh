#!/bin/bash

time_now=$(date +%s)
time_sec=$((time_now/900*900))
YMD=$(date -d "1970-01-01 UTC $time_sec seconds" +%Y%m%d)
HHMM=$(date -d "1970-01-01 UTC $time_sec seconds" +%H%M)
DATA_FILE="/home/work/var/bcmain/${YMD}/outputflow.${YMD}-${HHMM}.log"
IDX_FILE="/home/work/fc-shark/dbset/idx/idx_primary.dump"

if [ ! -f ${DATA_FILE} ]
then
	exit 1
fi

FILE_LEN=`ls -l ${DATA_FILE} | awk '{print $5}'`

awk 'BEGIN{
	FS=OFS="\t";
	time_stamp="'$YMD'-'$HHMM'";
	min_time_stamp=time_stamp;
	max_len=0;
	file_len='$FILE_LEN'+0;
}
{
	if(NF<3)
	{
		next;
	}
	if(min_time_stamp > $2)
	{
		min_time_stamp = $2;
	}
	if($2==time_stamp)
	{
		if($3>max_len)
		{
			max_len=$3;
		}
	}
}
END{
	mintime=mktime(substr(min_time_stamp,1,4)" "substr(min_time_stamp,5,2)" "substr(min_time_stamp,7,2)" "substr(min_time_stamp,10,2)" "substr(min_time_stamp,12,2)" 00");
	nowtime=mktime(substr(time_stamp,1,4)" "substr(time_stamp,5,2)" "substr(time_stamp,7,2)" "substr(time_stamp,10,2)" "substr(time_stamp,12,2)" 00");
	print "FCSHARK_DBSET_DELAY_BYTES:"file_len-max_len;
	print "FCSHARK_DBSET_DELAY_SECNS:"nowtime-mintime;
}' ${IDX_FILE}

echo "BDEOF"
