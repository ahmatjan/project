#!/bin/bash

# 日志路径
LOG_FILE="../log/execute.log"
# 报警邮件收件人,如果配置为空则不发报警邮件
MAIL_LIST="yangkai04@baidu.com"
PHONE_LIST="13341075368"
DATA_DIR="../result/"

#MID_FILES_INPUT="/home/disk1/var/uc_login2/${DATA_DAY}/*/uc-login2/uclogin2.log.??"
MID_FILES_INPUT="../data/uclogin.logs"
MID_FILE_LOGIN_RESULT_ORG="${DATA_DIR}/01.login_result_org.log"
MID_FILE_LOGIN_RESULT_GBK="${DATA_DIR}/02.login_result_gbk.log"
MID_FILE_LOGIN_RESULT_FORMAT="${DATA_DIR}/03.login_result_format.log"
MID_FILE_LOGIN_SUCC_FAIL_STAT="${DATA_DIR}/04.login_succ_fail_stat.log"
MID_FILE_LOGIN_FROM_WWW2="${DATA_DIR}/05.login_from_www2.log"
MID_FILE_LOGIN_SHENNONG="${DATA_DIR}/06.login_shennong"
