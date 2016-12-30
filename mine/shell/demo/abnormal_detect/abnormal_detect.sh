#!/bin/bash

# conf
INPUT_FILE="input"
OUTPUT_FILE="result"
TIME_COL='$2'
VALUE_COL='$3'

MAIL_LIST="yangkai04@baidu.com"

# script
function abnormal_detect()
{
    awk 'BEGIN \
    {
        FS = OFS = "\t";
        data_idx = 0;
        avg_data = 0;
    }
    function exceed_limit(l_value)
    {
        if (l_value < 0)
        {
            l_value = 0 - l_value;
        }
        if (l_value > 400)
        {
            return 1;
        }
        return 0;
    }
    function get_seconds(l_datetime)
    {
        l_year = substr(l_datetime, 1, 4);
        l_month = substr(l_datetime, 5, 2);
        l_day = substr(l_datetime, 7, 2);
        l_hour = substr(l_datetime, 9, 2);
        l_minute = substr(l_datetime, 11, 2);
        l_second = substr(l_datetime, 13, 2);
        l_time = mktime(l_year" "l_month" "l_day" "l_hour" "l_minute" "l_second" ");
        return l_time;
    }
    function time_format(l_datetime)
    {
        l_year = substr(l_datetime, 1, 4);
        l_month = substr(l_datetime, 5, 2);
        l_day = substr(l_datetime, 7, 2);
        l_hour = substr(l_datetime, 9, 2);
        l_minute = substr(l_datetime, 11, 2);
        l_second = substr(l_datetime, 13, 2);
        l_time = l_year"-"l_month"-"l_day" "l_hour":"l_minute":"l_second;
        return l_time;
    }
    {
        dict_time1[data_idx] = '${TIME_COL}';
        time = get_seconds('${TIME_COL}');
        value = '${VALUE_COL}' * 1000;
        dict_time[data_idx] = time;
        dict_value[data_idx++] = value;
        avg_data = avg_data + value;
    }
    END \
    {
        if (data_idx != 0)
        {
            avg_data = avg_data / data_idx;
        }
        else 
        {
            exit;
        }
        for (idx = 1; idx < data_idx; ++idx)
        {
            last_idx = idx - 1;
            #dict_rate1[idx] = (dict_value[idx] - dict_value[last_idx]) / \
            #    (dict_time[idx] - dict_time[last_idx]);
            #dict_rate1[idx] = (dict_value[idx] - dict_value[last_idx]);
            dict_diff[idx] = (dict_value[idx] - avg_data) / avg_data;
            printf("%d\t%s\t%s\t%0.2f\n", idx, dict_time1[idx], dict_value[idx], dict_diff[idx]);
            if (exceed_limit(dict_diff[idx]))
            {
#printf("%s\n", time_format(dict_time1[idx]));
            }
        }
    }' ${INPUT_FILE} > ${OUTPUT_FILE}
}

function mail_send()
{
    if [ `cat ${OUTPUT_FILE} | wc -l` -ne 0 ]
    then 
        head -n 100 ${OUTPUT_FILE} | mail -s "[“Ï≥£ºÏ≤‚] test" "$MAIL_LIST"
    fi
}

abnormal_detect

mail_send

