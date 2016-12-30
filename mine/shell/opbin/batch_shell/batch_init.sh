#!/bin/sh

#exit 0

find /home/work/dashboard/add_status_* -name "initidx.sh" | while read line 
do 
	echo ${line}
	subpath=${line%/*}
	echo ${subpath}
	cd ${subpath}
	sh initidx.sh
done

