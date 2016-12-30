#!/bin/sh

outfile=$0.txt

MAIL_LIST="yangkai04@baidu.com"

:> ${outfile}
(
find /home/work/dashboard/add_status_* -name "initidx.sh" | while read line 
do 
	subpath=${line%/*}
	echo ${subpath} 
	cat ${subpath}/idx/add.idx
done

) >> ${outfile}
cat ${outfile} | mail -s "[���¼��]`hostname`/$0 idx ���" "$MAIL_LIST"

