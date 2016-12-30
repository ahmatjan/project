#!/bin/sh

data_day=$1
log_ts=$2

start=`date +"%Y-%m-%d %H:%M:%S"`
awk 'BEGIN{
	FS=OFS="\t";
}
{
	gsub(" ","",$1);
	gsub("}","",$1);
	gsub("]","",$1);
	split($1,array,",");
	finish_time = array[1] + 0;
	split(array[2], temp_array, "=");
	stat = temp_array[2];
        split(array[3], temp_array, "=");
        ip = "'\''"temp_array[2]"'\''";
	split(array[4], temp_array, "=");
	enter_time = temp_array[2] + 0;
        get_time = "'\''"$2"'\''";
        split($3, temp_array, ",")
	userid = temp_array[1];
        ua = "'\''"$4"'\''"
	if (userid == "")
	{
		next;
	}
	if (finish_time~/[^0-9]/)
	{
		next;
	}
	if (enter_time~/[^0-9]/)
	{
		next;
	}
	if (userid~/[^0-9]/)
	{
		next;
	}
	key = userid"\t"enter_time;
	
	interval = finish_time - enter_time;
	if (key in dict)
	{
		max_time = dict[key];
		if (max_time < interval)
		{
			dict[key] = interval;
			#dict_item[key] = FNR"\t"finish_time"\t"enter_time;
		}
	}
	else
	{
		dict[key] = interval;
	}
	if (stat=="general")
	{
		dict_time[key] = interval;
		dict_mark[key] = 0;
	}
        dict_info[key] = "olimbos\t"get_time"\t"ip
        dict_ua[key] = ua
}
END{
	for (item in dict)
	{
		if (item in dict_mark && dict[item] > 0)
		{
			#print item, dict[item], dict_time[item];
                         print dict_info[item],dict_time[item],dict[item],dict_ua[item]
		}
	}
}' /flash/olimbos/performance_monitor/result/${data_day}/tx.log > /flash/olimbos/performance_monitor/result/${data_day}/olimbos_home_page.${data_day}.bak

cat /flash/olimbos/performance_monitor/result/${data_day}/olimbos_home_page.${data_day}.bak|awk -F"\t" '{if($5<60000){print $0}}'>>/flash/olimbos/performance_monitor/result/${data_day}/olimbos_home_page.${data_day}

/usr/bin/python /flash/olimbos/performance_monitor/new_performance.py /flash/olimbos/performance_monitor/result/${data_day}/olimbos_home_page.${data_day}.bak ${data_day} ${log_ts} 

/usr/bin/python /flash/olimbos/performance_monitor/www2Stat.py /flash/olimbos/performance_monitor/result/${data_day}/www2_login_time.${data_day} ${data_day} ${log_ts}

end=`date +"%Y-%m-%d %H:%M:%S"`
echo "execute stat.sh from $start end at $end"
