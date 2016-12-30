#!/bin/bash
set -x

echo "" | awk 'BEGIN \
{
    FS=OFS="\t";
}
# l_cnt天以前的时间戳.格式为:2013-09-10
function days_ago(l_date, l_cnt)
{
    gsub("-", " ", l_date);
    l_time = mktime(l_date" "00" "00" 00");
    l_time = l_time - l_cnt * 86400;
    return strftime("%Y-%m-%d", l_time);
}
# l_cnt以后的时间戳.格式为:2013-09-10
function days_after(l_date, l_cnt)
{
    gsub("-", " ", l_date);
    l_time = mktime(l_date" "00" "00" 00");
    l_time = l_time + l_cnt * 86400;
    return strftime("%Y-%m-%d", l_time);
}
# 下一天的时间戳.格式为:2013-09-10
function next_day(l_date)
{
    gsub("-", " ", l_date);
    l_time = mktime(l_date" "00" "00" 00");
    l_time = l_time + 86400;
    return strftime("%Y-%m-%d", l_time);
}
# 获取日期的所在季度.春夏秋冬分别对应1、2、3、4
function get_season(l_date)
{
    l_mon_day = substr(l_date, 6, 5);
    if(l_mon_day <= "03-31")
    {
        return 1;
    }
    if(l_mon_day <= "06-30")
    {
        return 2;
    }
    if(l_mon_day <= "09-30")
    {
        return 3;
    }
    if(l_mon_day <= "12-31")
    {
        return 4;
    }
}
# 返回从l_date_begin到l_date_end的天数
function count_days(l_date_begin, l_date_end)
{
    gsub("-", " ", l_date_begin);
    l_time_begin = mktime(l_date_begin" "00" "00" 00");
    l_day_begin = (l_time_begin + 28800) / 86400;

    gsub("-", " ", l_date_end);
    l_time_end = mktime(l_date_end" "00" "00" 00");
    l_day_end = (l_time_end + 28800) / 86400;

    return l_day_end - l_day_begin;
}
# 返回季度的第几天
function days_of_season(l_date)
{
    l_year=substr(l_date,1,4);
    l_mon_day = substr(l_date,6,5);
    if(l_mon_day <= "03-31")
    {
        season_begin = l_year"-01-01";
    }
    else if(l_mon_day <= "06-30")
    {
        season_begin = l_year"-04-01";
    }
    else if(l_mon_day <= "09-30")
    {
        season_begin = l_year"-07-01";
    }
    else if(l_mon_day <= "12-31")
    {
        season_begin = l_year"-10-01";
    }
    l_days=count_days(season_begin, l_date);
    return l_days + 1;
}
# 返回年度的第几天
function days_of_year(l_date)
{
    l_year = substr(l_date, 1, 4);
    l_mon_day = substr(l_date, 6, 5);
    l_year_begin = l_year"-01-01";
    l_days = count_days(l_year_begin, l_date);
    return l_days + 1;
}
# 返回上个季度同天
function last_seasonday(l_date)
{
    l_year = substr(l_date, 1, 4);
    l_last_year = l_year - 1;
    l_mon_day = substr(l_date, 6, 5);
    if(l_mon_day <= "03-31")
    {
        l_season_begin = l_year"-01-01";
        last_season_begin = l_last_year"-10-01"
        last_season_end = l_last_year"-12-31"
    }
    else if(l_mon_day <= "06-30")
    {
        l_season_begin = l_year"-04-01";
        last_season_begin = l_year"-01-01"
        last_season_end = l_year"-03-31"
    }
    else if(l_mon_day <= "09-30")
    {
        l_season_begin = l_year"-07-01";
        last_season_begin = l_year"-04-01"
        last_season_end = l_year"-06-30"
    }
    else if(l_mon_day <= "12-31")
    {
        l_season_begin = l_year"-10-01";
        last_season_begin = l_year"-07-01"
        last_season_end = l_year"-09-30"
    }
    l_days = count_days(l_season_begin, l_date);
    l_date_season = days_after(last_season_begin, l_days);
    if (l_date_season >= l_season_begin)
    {
        l_date_season = last_season_end;
    }
    return l_date_season;
}
# 返回去年同天
function last_yearday(l_date)
{
    l_year = substr(l_date, 1, 4);
    l_last_year = l_year - 1;
    l_mon_day = substr(l_date, 6, 5);
    if (l_mon_day == "02-29")
    {
        l_mon_day = "02-28";
    }
    return l_last_year"-"l_mon_day;
}
# 2015-01-01 00:00:00时间样式，返回5分钟的key 2015-01-01 00:00
function time_period(l_date, l_cycle)
{
    gsub("-", " ", l_date);
    gsub(":", " ", l_date);
    l_time = mktime(l_date);
    l_time = int(l_time / l_cycle) * l_cycle;
    return strftime("%Y-%m-%d %H:%M", l_time);
}
# 20150101143029
# 123456789
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
{
}
END \
{
    day = "2014-12-30";
    printf("day[%s] 30 days ago is:\n", day);
    print days_ago(day, 30);
    printf("day[%s] 1 days after is:\n", day);
    print days_after(day, 1);
    printf("day[%s] next day is:\n", day);
    print next_day(day);
    printf("day[%s] season is:\n", day);
    print get_season(day);
    printf("days from [%s] to [%s] is:\n", day, days_ago(day, 30));
    print count_days(day, days_ago(day, 30));
    printf("days from [%s] to [%s] is:\n", days_ago(day, 30), day);
    print count_days(days_ago(day, 30), day);

    printf("day[%s] of season is:\n", day);
    print days_of_season(day);
    printf("day[%s] of season is:\n", "2014-01-01");
    print days_of_season("2014-01-01");
    printf("day[%s] of season is:\n", "2014-03-31");
    print days_of_season("2014-03-31");
    printf("day[%s] of season is:\n", "2014-04-01");
    print days_of_season("2014-04-01");
    printf("day[%s] of season is:\n", "2014-06-30");
    print days_of_season("2014-06-30");
    printf("day[%s] of season is:\n", "2014-07-01");
    print days_of_season("2014-07-01");
    printf("day[%s] of season is:\n", "2014-09-30");
    print days_of_season("2014-09-30");
    printf("day[%s] of season is:\n", "2014-10-01");
    print days_of_season("2014-10-01");
    printf("day[%s] of season is:\n", "2014-12-31");
    print days_of_season("2014-12-31");

    printf("day[%s] of year is:\n", day);
    print days_of_year(day);
    printf("day[%s] of year is:\n", "2014-01-01");
    print days_of_year("2014-01-01");
    printf("day[%s] of year is:\n", "2014-12-31");
    print days_of_year("2014-12-31");
    printf("day[%s] last season day is:\n", "2014-12-31");
    print last_seasonday("2014-12-31");
    printf("day[%s] last year day is:\n", "2014-12-31");
    print last_yearday("2014-12-31");
    print time_period("2014-12-31 12:01:01", 300);
    print get_seconds("20150101143029");
}'
