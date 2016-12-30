#!/bin/bash

# wildcard: $day=yyyymmdd $hour=hh $min=mm $half=00 30 $quarter=00 15 30 45

hour_passed=24	 # check hours past

MAIL_LIST="sf-op@baidu.com anti@baidu.com"
PHONE_LIST="g_is_anti,g_sf_op"

source log_touch.conf

function usage()
{
        local cmd=$1
        printf "Usage: %s [-camsvh] \n" $cmd;
	printf "\t-c\tcheck missing files\n";
	printf "\t-t\tauto touch missing files\n";
	printf "\t-m\tsend mail\n";
	printf "\t-s\tsend sms message\n";
	printf "\t-v\tprint version\n";
	printf "\t-h\tprint help message\n";
        return 0
}

function check_conf()
{
	file_count=${#log[@]}
	index=0
	while [ ${index} -lt ${file_count} ]
	do
		if [ -z "${log[$index]}" -o -z "${delay[${index}]}" ];then
			exit 1
		fi
		index=`expr $index + 1`
	done
}

check_conf

# main process

auto_touch=0
send_mail=0
send_sms=0

while getopts hvtmsd OPT 
do              
        case $OPT       
        in      
                h)      usage $0
                        exit 0
                        ;;
                v)      echo -e "Dorado auto-touch script v1.0 \nPowered by lizhaowen@baidu.com"
                        exit 0
                        ;;
		t)	auto_touch=1
			;;
		m)	send_mail=1
			;;
		s)	send_sms=1
			;;
                \?)     usage $0;
                        exit 0
                        ;;
        esac
done

sec_passed=`expr $hour_passed \* 60 \* 60`
sec_inc=`expr 15 \* 60 `

:>file.list
idx=0 
loop=${#log[*]}
file_miss_cnt=0
while [ $idx -lt $loop ]
do
	sec_end=`date -d "${delay[$idx]} minute ago" +%s`
	sec_start=`expr $sec_end - $sec_passed`
	sec=$sec_start
	while [ $sec -le $sec_end ]
	do
		day=`date -d "1970-01-01 UTC $sec seconds" +%Y%m%d`
		hour=`date -d "1970-01-01 UTC $sec seconds" +%H`	
		min=`date -d "1970-01-01 UTC $sec seconds" +%M`
		quarter=`expr $min / 15 \* 15`
		if [ $quarter -lt 10 ];then
			quarter="0"$quarter
		fi
		file=`eval echo ${log[$idx]}`
		md5file=`eval echo ${md5[$idx]}`
		if [ ! -e $file ];then
			echo $file >> file.list
			if [ $auto_touch -eq 1 ];then
				mkdir -p ${file%/*}
				touch $file
			fi
			file_miss_cnt=`expr $file_miss_cnt + 1`
		fi
		if [ -n "${md5[$idx]}" ];then
			if [ ! -e $md5file ];then
				echo $md5file >> file.list
				if [ $auto_touch -eq 1 ];then
					cd ${file%/*} && md5sum ${file##*/} > $md5file
					cd - &>/dev/null
				fi
				file_miss_cnt=`expr $file_miss_cnt + 1`
			fi
		fi
		
		sec=`expr $sec + $sec_inc`
	done
	idx=`expr $idx + 1`
done

if [ `cat file.list | wc -l` -ne 0 -a $send_mail -eq 1 ];then
	cat file.list | mail -s "[DR-DORADO]计费服务器`hostname`文件缺失，总数$file_miss_cnt个" "$MAIL_LIST"
fi

if [ `cat file.list | wc -l` -ne 0 -a $send_sms -eq 1 ];then
	gsmsend -s emp01.baidu.com:15003 -s emp02.baidu.com:15003 $PHONE_LIST@"[DR-DORADO]计费服务器`hostname`文件缺失，总数$file_miss_cnt个"
fi
	
cat file.list	
