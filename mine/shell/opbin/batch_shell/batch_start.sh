#!/bin/sh

#exit 0

find /home/work/dashboard/add_status_* -name "load" | while read line 
do 
	echo ${line}
	subpath=${line%/*}
	echo ${subpath}
	cd ${subpath}
	sh load
done

