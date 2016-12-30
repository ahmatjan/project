#!/bin/bash

LOCAL_ROOT="/home/yangkai04/project/work.olimbos/app/ecom/olimbos/ol-personal/yangkai/shell"
HADOOP_ROOT="/app/ecom/dashboard/chg/"

# 日志路径
LOG_FILE="${LOCAL_ROOT}/log/query_title_match.log"
# 报警邮件收件人,如果配置为空则不发报警邮件
MAIL_LIST="yangkai04@baidu.com"

# 工具路径
HADOOP_BINPATH="/home/yangkai04/local/hadoop-client/hadoop/bin/hadoop"
SEGWORD_BINPATH="./seg_basic"
PUNCWORDS_PATH="./puncwords_dict.txt"
WORDDICT_PATH="./worddict.tar.gz"
HADOOP_WORDDICT_PATH="${HADOOP_ROOT}/tools/worddict.tar.gz"

# 测试数据url-title文件位置
URL_TITLE_PATH="ftp://cp01-qa-junheng2-qa160.cp01.baidu.com/home/work/maj/cm-shell/test-data/url-title/part-*"
# url-title拉取到本地位置
LOCAL_URL_TITLE_PATH="${LOCAL_ROOT}/data/url_title"
# url-title放到hadoop位置
HADOOP_URL_TITLE_PATH="${HADOOP_ROOT}/input"

# querylist文件位置
QUERY_LIST_PATH="ftp://cp01-qa-junheng2-qa160.cp01.baidu.com/home/work/maj/cm-shell/test-data/query-set/"
QUERY_LIST_NAME="query_set_s1_25000.txt"
QUERY_LIST_MD5="query_set_s1_25000.txt.md5"
# querylist文件拉取到本地位置
LOCAL_QUERY_LIST_PATHNAME="${LOCAL_ROOT}/data/query_set.txt"
LOCAL_QUERY_LIST_PATHNAME_GBK="${LOCAL_QUERY_LIST_PATHNAME}.gbk"
LOCAL_QUERY_LIST_PATHNAME_SEG="./query_set.txt"

# 输出数据文件位置
HADOOP_OUTPUT_DATA_PATH="${HADOOP_ROOT}/output"
OUTPUT_DATA_PATH="${LOCAL_ROOT}/result/top100_site"

# HADOOP配置
MAP_CAPCITY=20
REDUCE_CAPCITY=10
JOB_PRIORITY="HIGH"
JOB_GROUPS="default"
