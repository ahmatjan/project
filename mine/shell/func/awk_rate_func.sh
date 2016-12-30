#!/bin/bash
set -x

echo "" | awk 'BEGIN {
    init_rand();
} 

function init_rand()
{
    l_str = \
        "37, 39, 20, 88, 5, 84, 17, 34, 11, 47,  \
         44, 66, 49, 25, 9, 68, 55, 1, 30, 96,  \
         38, 79, 2, 65, 51, 97, 43, 4, 48, 77,  \
         89, 35, 59, 29, 33, 64, 76, 92, 42, 53,  \
         67, 95, 75, 70, 72, 74, 18, 60, 78, 6,  \
         40, 63, 8, 82, 94, 87, 91, 27, 71, 62,  \
         86, 90, 56, 13, 26, 52, 31, 73, 12, 81,  \
         57, 83, 36, 80, 98, 24, 14, 54, 10, 0,  \
         23, 16, 22, 93, 7, 19, 61, 46, 41, 85,  \
         28, 58, 69, 3, 99, 32, 21, 50, 15, 45"; \
    split(l_str, s_rand_array, ",");
}

function get_daynum(l_date)
{
    # 20141230
    if (match(l_date, /[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]/) > 0)
    {
        l_time = mktime(substr(l_date, 1, 4)" "substr(l_date, 5, 2)" "substr(l_date, 7, 2)" " \
                00" "00" 00");
    }
    # 2014-12-30 00:00:15
    if (match(l_date, \
                /[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]:[0-9][0-9]/) > 0)
    {
        gsub("-", " ", l_date);
        gsub(":", " ", l_date);
        l_time = mktime(l_date);
    }
    return int((l_time + 28800) / 86400);
}

function get_rand(l_date, l_id)
{
    l_daynum = get_daynum(l_date);
    return s_rand_array[(l_daynum + l_id) % 100 + 1];
}

function get_rand_rate(l_rand, l_upper_limit, l_lower_limit)
{
    return l_upper_limit - int(l_rand / 100.0 * (l_upper_limit - l_lower_limit + 1));
}

# 20141230  1024  1.12  1.0
function get_rate(l_date, l_id, l_upper_limit, l_lower_limit)
{
    if (l_upper_limit == "" || l_lower_limit == "")
    {
        l_upper_limit = 1.12;
        l_lower_limit = 1.0;
    }
    l_daynum = get_daynum(l_date);
    l_rand = s_rand_array[(l_daynum + l_id) % 100 + 1];
    l_upper_limit = int(l_upper_limit * 100 + 0.5);
    l_lower_limit = int(l_lower_limit * 100 + 0.5);
    return (l_upper_limit - int(l_rand / 100.0 * (l_upper_limit - l_lower_limit + 1))) / 100;
}

{
    id = 1024;
    day = "20141230"
    #day = "2014-12-30 00:00:15"
    upper_limit = 1.12
    lower_limit = 1.0

    print "daynum : "get_daynum(day);
    print "id : "id;
    printf("rand : %d\n", get_rand(day, id));
    printf("rate : %0.2f\n", get_rand_rate(get_rand(day, id), 
                int(upper_limit * 100 + 0.5), int(lower_limit * 100 + 0.5)) / 100);

    printf("rate : %0.2f\n", get_rate(day, id));
}
END {
}'

