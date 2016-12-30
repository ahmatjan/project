#!/bin/sh

time_thresh=5
time_now=`date +"%s"`
time_now=$((time_now / 900 * 900))
day=`date -d"1970-01-01 UTC ${time_now} seconds" +"%Y%m%d"`
last_time=$((time_now - 900))
last_timestamp=`date -d"1970-01-01 UTC ${last_time} seconds" +"%Y%m%d-%H%M"`
last_two_time=$((time_now - 1800))
last_two_timestamp=`date -d"1970-01-01 UTC ${last_two_time} seconds" +"%Y%m%d-%H%M"`
echo ${last_two_timestamp}
echo ${last_timestamp}

type=8
key='$4'
value='$5'
type=40
key='$4","$5'
value='$7'

function stat()
{
mark=$1
awk 'BEGIN{
	FS=OFS="\t";
	in_dump=0;
}
{
	if ($1==9 && $4=="BM_BEGIN" && $5=='${type}')
	{
		in_dump = 1;
	}
	if ($1==9 && $4=="BM_END" && $5=='${type}')
	{
		in_dump = 0;
	}
	if ($1=='${type}')
	{
		key='${key}';
		if (0==in_dump)
		{
			dict[key]='${value}'"\t"strftime("%Y-%m-%d %H:%M:%S",$2);
		}
		else
		{
			dict[key]='${value}'"\t"strftime("%Y-%m-%d %H:%M:%S",'${last_two_time}');
		}
	}
}
END{
	for (item in dict)
	{
		print item,dict[item];
	}
}' /home/work/var/bcmain/${mark}01-fc-bgt0[01]/${day}/outputflow.{${last_two_timestamp},${last_timestamp}}.log | sort > result.${mark}
}

function check()
{
awk 'BEGIN{
	FS=OFS="\t";
	while (getline<"result.cq">0)
	{
		dict[$1]=$2;
		dict_time[$1]=$3;
	}
	begin_time='${last_two_time}'+'${time_thresh}'+0;
	end_time='${time_now}'-'${time_thresh}'+0;
}
{
	key=$1;
	value=$2;
	if (key in dict)
	{
		if(value != dict[key])
		{
			print "not match:",$0;
		}
		dict[key]="";
	}
	else
	{
		time_str = $3;
		gsub("-", " ", time_str);
                gsub(":", " ", time_str);
                datatime= mktime(time_str);
		#print datatime, begin_time, end_time;
		if (datatime >= begin_time && datatime <= end_time)
		{
			print "not exist:",$0;
		}
	}
}
END{
	for (item in dict)
	{
		if (dict[item]!="")
		{
			time_str = dict_time[item];
			gsub("-", " ", time_str);
	                gsub(":", " ", time_str);
	                datatime= mktime(time_str);
			#print datatime, begin_time, end_time;
			if (datatime >= begin_time && datatime <= end_time)
			{
				print "not exist:",item, dict[item], dict_time[item];
			}
		}
	}
}' result.st > result 
wc -l result
}

stat "cq"
stat "st"
check
