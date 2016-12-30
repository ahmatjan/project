#!/bin/bash

# 日志路径
LOG_FILE="../log/execute.log"
# 报警邮件收件人,如果配置为空则不发报警邮件
MAIL_LIST="yangkai04@baidu.com"
PHONE_LIST="13341075368"
DATA_DIR="../data/${TYPE}"

MYSQL_PATH_PAT='"/home/work/local/mysql/bin/mysql -h${host} -P${port} -u${user} -p${pass} -D${dbname} -N "'

secure_user="uSI1o856172"
secure_pass="PyD1tjcXZfKomQqcC"
secure_dbname="Dr_Secure"
secure_host="10.36.253.127"
secure_port="6172"

amends_user="yangkai04"
amends_pass="TDTL0Dw5kA"
amends_dbname="Dr_Secure"
amends_host="db-dba-dbbk-011.db01" 
amends_port="7501"

optlog_user="fc59_proxy_r"
optlog_pass="Qi3T9K0I3N6ww4LP8g"
optlog_dbname="FC_Log"
i=0
optlog_host[$i]=10.26.3.25
optlog_port[$i]=5900
((++i))
optlog_host[$i]=10.26.3.80
optlog_port[$i]=5901
((++i))
optlog_host[$i]=10.26.3.91
optlog_port[$i]=5902
((++i))
optlog_host[$i]=10.26.3.103
optlog_port[$i]=5903
((++i))
optlog_host[$i]=10.26.3.198
optlog_port[$i]=5904
((++i))
optlog_host[$i]=10.26.3.205
optlog_port[$i]=5905
((++i))
optlog_host[$i]=10.26.3.225
optlog_port[$i]=5906
((++i))
optlog_host[$i]=10.26.3.244
optlog_port[$i]=5907
((++i))
optlog_host[$i]=10.26.7.13
optlog_port[$i]=5908
((++i))
optlog_host[$i]=10.26.7.20
optlog_port[$i]=5909
((++i))
optlog_host[$i]=10.26.7.32
optlog_port[$i]=5910
((++i))
optlog_host[$i]=10.26.7.60
optlog_port[$i]=5911
((++i))
optlog_host[$i]=10.26.7.61
optlog_port[$i]=5912
((++i))
optlog_host[$i]=10.26.7.68
optlog_port[$i]=5913
((++i))
optlog_host[$i]=10.26.7.69
optlog_port[$i]=5914
((++i))
optlog_host[$i]=10.26.7.82
optlog_port[$i]=5915

MID_FILE_AMENDS="${DATA_DIR}/01.amends"
MID_FILE_OPTLOG_TABLES="${DATA_DIR}/02.optlog_tables"
MID_FILE_OPTLOG_STARTDATE="${DATA_DIR}/03.optlog_startdate"
MID_FILE_SPAMLOG_SQL="${DATA_DIR}/04.spamlog_sql"
MID_FILE_WORD="${DATA_DIR}/05.optlog_word"
MID_FILE_WORD_FILTER="${DATA_DIR}/06.optlog_filter"
MID_FILE_WORD_SEGMENT="${DATA_DIR}/07.optlog_segment"
MID_FILE_WORD_SEGWORD="${DATA_DIR}/08.optlog_segword"
MID_FILE_FEATURE="${DATA_DIR}/09.optlog_feature"
MID_FILE_FEATURE_FILTER="${DATA_DIR}/10.feature_filter"
MID_FILE_FEATURE_FILTERED="${DATA_DIR}/11.feature_filtered"
MID_FILE_FEATURE_MATCHED="${DATA_DIR}/12.feature_matched"

THRESHOLD_OPT_NUM_PER_SECOND=100
THRESHOLD_OPT_INTERVAL=120

FEATURE_WORD_RATE="../conf/feature_word_rate"

