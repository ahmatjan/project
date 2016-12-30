#!/bin/sh

#exit 0

find /home/work/dashboard/add_status_* -name "load" | while read line 
do 
	subpath=${line%/*}
	filename=`ls ${subpath}/db_operator.py`
	md5sum $filename
	#cp add_status.py $filename
	#cp db_operator.py $filename
	#md5sum $filename
done

