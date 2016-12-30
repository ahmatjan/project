#!/bin/sh

i=0
LOG_PATH_ROOT[$i]="/home/work/var/"
RESERVE_DAYS[$i]=730

((i++))
LOG_PATH_ROOT[$i]="/home/work/var/integ/cq01-fc-bgt0[012]"
RESERVE_DAYS[$i]=30
((i++))
LOG_PATH_ROOT[$i]="/home/work/var/integ/st01-fc-bgt0[0123]"
RESERVE_DAYS[$i]=30
((i++))
LOG_PATH_ROOT[$i]="/home/work/var/integ/dbl-fc-bgt00"
RESERVE_DAYS[$i]=30
((i++))
LOG_PATH_ROOT[$i]="/home/work/var/bcmain/cq01-fc-bgt0[01]"
RESERVE_DAYS[$i]=80
((i++))
LOG_PATH_ROOT[$i]="/home/work/var/bcmain/st01-fc-bgt0[013]"
RESERVE_DAYS[$i]=80
((i++))
LOG_PATH_ROOT[$i]="/home/work/var/bcmain/cq01-fc-bgt02"
RESERVE_DAYS[$i]=40
((i++))
LOG_PATH_ROOT[$i]="/home/work/var/bcmain/st01-fc-bgt02"
RESERVE_DAYS[$i]=40
((i++))
LOG_PATH_ROOT[$i]="/home/work/var/bcmain/dbl-fc-bgt00"
RESERVE_DAYS[$i]=80
((i++))
LOG_PATH_ROOT[$i]="/home/work/var/bcmain-*/*01-fc-bgt04"
RESERVE_DAYS[$i]=80
((i++))

OUTPUT_PATH="${0%.*}"
mkdir -p ${OUTPUT_PATH}
rm -f ${OUTPUT_PATH}/*	

idx=0                                                                                               
loop=${#LOG_PATH_ROOT[*]}
while [ $idx -lt $loop ]
do
	LOG_PATH_ROOT=${LOG_PATH_ROOT[${idx}]}
	RESERVE_DAYS=${RESERVE_DAYS[${idx}]}
	ALL_FILES="${OUTPUT_PATH}/$0.${idx}.1.all_files"
	:>${ALL_FILES}
	
	find ${LOG_PATH_ROOT}/* -follow | sed -n '/.*\([0-9]\{8\}\).*/p' >> ${ALL_FILES}
	
	ALL_DATES="${OUTPUT_PATH}/$0.${idx}.2.all_dates"
	cat ${ALL_FILES} | sed -n 's/.*\([0-9]\{8\}\).*/\1/p' | sort | uniq -c > ${ALL_DATES}
	
	DEL_DATES="${OUTPUT_PATH}/$0.${idx}.3.del_dates"
	DAY_THRESHOLD=`date -d "${RESERVE_DAYS} days ago" +%Y%m%d`
	awk 'BEGIN{
		FS=OFS=" ";
		day_threshold='${DAY_THRESHOLD}'
	}
	{
		the_day = $2;
		if (the_day~/^([0-9])+$/)
		{
			if (the_day < day_threshold)
			{
				print the_day;
			}
		}
	}
	END{
	}' ${ALL_DATES} > ${DEL_DATES}
	
	DEL_FILES="${OUTPUT_PATH}/$0.${idx}.4.del_files"
	awk 'BEGIN{
		FS=OFS="\t";
		while(getline<"'${DEL_DATES}'">0)
		{
			dict[$1]=0;
		}
	}
	{
		for (item in dict)
		{
			if (match($0,item)>0)
			{
				print $0;
				next;
			}
		}
	}
	END{
	}' ${ALL_FILES} | grep -v ":"|grep "/"> ${DEL_FILES}
	
	cat ${DEL_FILES} | while read line 
	do 
		rm -rf ${line}
		echo ${line}
	done

	((idx++))
done
