#!/bin/sh
find /home/work/dashboard/add_status_* -name "*.conf" | xargs grep "NEXT_NUM_FILE=1" | awk -F":" '{print $1;}' | while read line 
do 
	echo ${line}
	file="${line}"
	newfile="${line}.new"
	cat ${file} | sed "s/NEXT_NUM_FILE=1/NEXT_NUM_FILE=2/g" > ${newfile}
	mv ${newfile} ${file}
done

