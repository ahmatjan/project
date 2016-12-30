#!/bin/sh -x

limit=$(($1 + 0))

line_num=0
df | while read LINE
do
	(( line_num = $line_num + 1 ))
	if [ $line_num -gt 1 ]
	then
		LINE=$(echo $LINE)
		LINE=${LINE#* }
		LINE=${LINE#* }
		LINE=${LINE#* }
		LINE=${LINE#* }
		LINE=${LINE%\%*}
		if [ ${LINE} -gt $limit ]
		then
			echo $(hostname)": dist used ${LINE}" | mail -s $(hostname)" dist too full" yangkai04@baidu.com
			gsmsend -s 10.23.199.131:15003 13341075368@$(hostname)": dist used "${LINE}
		fi
	fi
done
