#!/bin/sh

DATABASES="fcdashboard bgtserver_dashboard budget_dashboard"
RESERVE_DAY=30

result_file="$0.res"

for database in ${DATABASES}
do
	:>${result_file}
	/home/work/local/mysql/bin/mysql -h10.50.77.12 -P6606 -ufcwrite -p123456 -N -e"use ${database};show tables;" | while read line
	do
		echo "${line}" | grep -v "minute" >> ${result_file}
	done
	
	DAY=`date -d "${RESERVE_DAY} days ago" +%Y%m%d`
	
	awk 'BEGIN{
		FS=OFS="\t";
		datenow='${DAY}'
	}
	{
		N=split($0,array,"_");
		if (array[N]~/^([0-9])+$/)
		{
			if (array[N] < datenow)
			{
				print "drop table "$0";";
			}
		}
	}
	END{
	}' ${result_file} | while read line
	do
		echo ${line}
		/home/work/local/mysql/bin/mysql -h10.50.77.12 -P6606 -ufcwrite -p123456 -D${database} -N -e"${line}"
	done
done
