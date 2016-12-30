#!/bin/sh

if [ -z "$1" -o -z "$2" ]
then
	echo "please input param, example: sh $0 \"2012-11-28 10:10:00\" \"2012-11-28 10:15:00\" "
	exit 1
fi

BEGIN_DAY=${1:0:10}
END_DAY=${2:0:10}

if [ "${BEGIN_DAY}" != "${END_DAY}" ]
then
	echo "only check the same day!"
	exit 1
fi
DAY="${BEGIN_DAY:0:4}${BEGIN_DAY:5:2}${BEGIN_DAY:8:2}"
#echo ${DAY}

BEGIN_TIME=`date -d"$1" +"%s"`
END_TIME=`date -d"$2" +"%s"`

#echo ${BEGIN_TIME} ${END_TIME}
BEGIN_TIME="$1"
END_TIME="$2"

awk 'BEGIN{FS=OFS="\t";}{if($8>="'"${BEGIN_TIME}"'" && $8<="'"${END_TIME}"'") print $4,$8;}' /home/work/var/bd_chg_log/${DAY}/bd_chg.*.log > temp

awk 'BEGIN{
	FS=OFS="\t";
	while(getline<"userlist">0)
	{
		dict[$1]=0;
	}
	count =0;
	total_count=0;
}
{
	if (($1 in dict))
	{
		count++;
	}
	total_count++;
}
END{
	print total_count,count,total_count-count;
}' temp
