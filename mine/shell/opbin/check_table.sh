#!/bin/sh

MAIL_LIST="yangkai04@baidu.com"

OUTPUT_PATH="${0%.*}"
mkdir -p ${OUTPUT_PATH}

DATABASES="fcdashboard bgtserver_dashboard budget_dashboard"
CHECK_DAY=1

all_tables_file="${OUTPUT_PATH}/$0.1.alltables"
:>${all_tables_file}
day_table_file="${OUTPUT_PATH}/$0.2.daytable"
:>${day_table_file}
one_table_file="${OUTPUT_PATH}/$0.3.onetable"
:>${one_table_file}
check_result_file="${OUTPUT_PATH}/$0.4.result"
:>${check_result_file}

for database in ${DATABASES}
do
	/home/work/local/mysql/bin/mysql -h10.50.77.12 -P6606 -ufcwrite -p123456 -N -e"use ${database};show tables;" | while read line
	do
		echo -e "${database}\t${line}" >> ${all_tables_file}
	done
done
	
DAY=`date -d "${CHECK_DAY} days ago" +%Y%m%d`
DAY2=`date -d "${CHECK_DAY} days ago" +%Y-%m-%d`

awk 'BEGIN{
	FS=OFS="\t";
	datecheck='${DAY}'
}
{
	table_name=$2;
	N=split(table_name,array,"_");
	#如果是按天分表zx_budget_action_20140324
	if (array[N]~/^([0-9])+$/)
	{
		table_name_prefix=substr(table_name, 1, length(table_name) - length(array[N]) - 1);
		day_table[table_name_prefix]=$1;
	}
	#如果是一个表
	else
	{
		one_table[table_name]=$1;
	}
}
END{
	for (item in day_table)
	{
		print day_table[item],item"_"datecheck >> "'${day_table_file}'";
	}
	for (item in one_table)
	{
		print one_table[item],item >> "'${one_table_file}'";
	}
}' ${all_tables_file}

cat ${day_table_file} | sort > ${day_table_file}.sort
cat ${one_table_file} | sort > ${one_table_file}.sort

awk 'BEGIN{
	FS=OFS="\t";
	while(getline<"'${all_tables_file}'">0)
	{
		dict[$0]=0;
	}
}
{
	if (!($0 in dict))
	{
		print "db["$1"]    lost    table["$2"]";
	}
}
END{
}' ${day_table_file} > ${check_result_file}

#去掉基准表
cat ${one_table_file} | grep -v "bm" | while read line 
do 
	VAR=(`echo ${line} | sed "s/	/ /g"`) 
	#echo ${VAR[0]},${VAR[1]}
	VALUE=`/home/work/local/mysql/bin/mysql -h10.50.77.12 -P6606 -ufcwrite -p123456 -N -e"use ${VAR[0]};select * from ${VAR[1]} where date = '${DAY2}';"`
	if [ -z "${VALUE}" ]
	then
		echo "db[${VAR[0]}]    table[${VAR[1]}]    lost item where date = ${DAY2}" >> ${check_result_file}
	fi
done

if [ `cat ${check_result_file} | wc -l` -ne 0 ];then
	head -n 100 ${check_result_file} | mail -s "[线下监控]`hostname`:`pwd`/$0 database and tables 监控" "$MAIL_LIST"
fi

