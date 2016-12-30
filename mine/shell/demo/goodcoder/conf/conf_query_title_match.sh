#!/bin/bash

LOCAL_ROOT="/home/yangkai04/project/work.olimbos/app/ecom/olimbos/ol-personal/yangkai/shell"
HADOOP_ROOT="/app/ecom/dashboard/chg/"

# ��־·��
LOG_FILE="${LOCAL_ROOT}/log/query_title_match.log"
# �����ʼ��ռ���,�������Ϊ���򲻷������ʼ�
MAIL_LIST="yangkai04@baidu.com"

# ����·��
HADOOP_BINPATH="/home/yangkai04/local/hadoop-client/hadoop/bin/hadoop"
SEGWORD_BINPATH="./seg_basic"
PUNCWORDS_PATH="./puncwords_dict.txt"
WORDDICT_PATH="./worddict.tar.gz"
HADOOP_WORDDICT_PATH="${HADOOP_ROOT}/tools/worddict.tar.gz"

# ��������url-title�ļ�λ��
URL_TITLE_PATH="ftp://cp01-qa-junheng2-qa160.cp01.baidu.com/home/work/maj/cm-shell/test-data/url-title/part-*"
# url-title��ȡ������λ��
LOCAL_URL_TITLE_PATH="${LOCAL_ROOT}/data/url_title"
# url-title�ŵ�hadoopλ��
HADOOP_URL_TITLE_PATH="${HADOOP_ROOT}/input"

# querylist�ļ�λ��
QUERY_LIST_PATH="ftp://cp01-qa-junheng2-qa160.cp01.baidu.com/home/work/maj/cm-shell/test-data/query-set/"
QUERY_LIST_NAME="query_set_s1_25000.txt"
QUERY_LIST_MD5="query_set_s1_25000.txt.md5"
# querylist�ļ���ȡ������λ��
LOCAL_QUERY_LIST_PATHNAME="${LOCAL_ROOT}/data/query_set.txt"
LOCAL_QUERY_LIST_PATHNAME_GBK="${LOCAL_QUERY_LIST_PATHNAME}.gbk"
LOCAL_QUERY_LIST_PATHNAME_SEG="./query_set.txt"

# ��������ļ�λ��
HADOOP_OUTPUT_DATA_PATH="${HADOOP_ROOT}/output"
OUTPUT_DATA_PATH="${LOCAL_ROOT}/result/top100_site"

# HADOOP����
MAP_CAPCITY=20
REDUCE_CAPCITY=10
JOB_PRIORITY="HIGH"
JOB_GROUPS="default"
