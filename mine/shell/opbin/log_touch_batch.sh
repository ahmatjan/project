#!/bin/sh

# General touch files script for c programs
# by yangkai04@baidu.com 20140401

DAYS_AGO=60
SECONDS_AGO=86400
MAIL_LIST="yangkai04@baidu.com"

i=0
LOG_PATH_ROOT[$i]="/home/work/var/bcmain"
((i++))
LOG_PATH_ROOT[$i]="/home/work/var/bcmain-qs"
((i++))
LOG_PATH_ROOT[$i]="/home/work/var/bcmain-siva"
((i++))

while getopts t OPT 
do			  
	case $OPT in	  
		t) AUTO_TOUCH=1
		;;
		\?) usage $0;
		exit 0
		;;
	esac
done

OUTPUT_PATH="${0%.*}"
mkdir -p ${OUTPUT_PATH}
rm -f ${OUTPUT_PATH}/*	

STEP="$((900))"
FORMAT="%Y%m%d-%H%M"

RESULT_FILE="${OUTPUT_PATH}/$0.result"
:>${RESULT_FILE}

idx=0																							   
loop=${#LOG_PATH_ROOT[*]}
while [ $idx -lt $loop ]
do
	LOG_PATH_ROOT=${LOG_PATH_ROOT[${idx}]}
	ALL_FILES="${OUTPUT_PATH}/$0.${idx}.1.all_files"
	:>${ALL_FILES}
	find ${LOG_PATH_ROOT}/* ! -name ".*" -follow | sed -n '/.*\([0-9]\{8\}-[0-9]\{4\}\).*/p' >> ${ALL_FILES}
	ALL_PATS="${OUTPUT_PATH}/$0.${idx}.2.all_PATs"
	cat ${ALL_FILES} | sed -n 's/\(.*\)\([0-9]\{8\}\)\(.*\)\([0-9]\{8\}-[0-9]\{4\}\)\(.*\)/\1${DAY}\3${TIMESTAMP}\5/p' | sort | uniq -c > ${ALL_PATS}

	BEGIN_DATE=`date -d"${DAYS_AGO} days ago" +"%Y%m%d"`
	BEGIN="${BEGIN_DATE:0:4}-${BEGIN_DATE:4:2}-${BEGIN_DATE:6:2} 00:00:00"
	END_SECONDS=`date -d"${SECONDS_AGO} seconds ago" +"%s"`
	#echo ${END_SECONDS}
	END_SECONDS=`expr ${END_SECONDS} \/ ${STEP} \* ${STEP}`
	#echo ${END_SECONDS}
	END=`date -d"1970-01-01 UTC ${END_SECONDS} seconds" +"%Y-%m-%d %H:%M:%S"`
	#echo ${BEGIN},${END}
	
	cat ${ALL_PATS} | while read line
	do
		VAR=(`echo ${line} | sed "s/	/ /g"`)
		line=${VAR[1]}
		#echo ${line}
		cur_s=$(date -d" ${BEGIN}" +"%s")
		end_s=$(date -d" ${END}" +"%s")
		while [ "${cur_s}" -lt "${end_s}" ]
		do
			TIMESTAMP=$(date -d" 00:00:00 1970-01-01 UTC +${cur_s} sec " +"${FORMAT}")
			DAY=${TIMESTAMP:0:8}
			day=${cur:0:8}
			hour=${cur:9:2}
			quarter=${cur:11:2}
		
			file=`eval echo ${line}`
			if [ ! -f ${file} ]
			then
				echo ${file} >> ${RESULT_FILE}
				if [ ! -z "${AUTO_TOUCH}" ]
				then
					mkdir -p ${file%/*}
					touch ${file}
				fi
			fi
			cur_s=$((cur_s + STEP))
		done
	done
	((idx++))
done

if [ `cat ${RESULT_FILE} | wc -l` -ne 0 ];then
	head -n 100 ${RESULT_FILE} | mail -s "[线下监控]`hostname`:`pwd`/$0 文件缺失 监控" "$MAIL_LIST"
fi

