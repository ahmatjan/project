#!/bin/bash
#
# Copyright (c) 2015 Baidu.com, Inc. All Rights Reserved
#
# Author: yangkai04@baidu.com
# Date: 2015/11/11
# Brief:
#   常用函数
# Globals:
#   none
# Arguments:
#   none
# Returns:
#   succ:0
#   fail:1

#set -x # set -o xtrace
#set -e # set -o errexit
#set -u # set -o nounset
set -o pipefail 

# 保证write_log可以打印行号
shopt -s expand_aliases

#######################################
# Brief:
#   输出日志.如果目录存在，则输出到日志文件中.否则输出到控制台.
# Globals:
#   none
# Arguments:
#   $1,行号; 
#   $2,日志等级(DEBUG,TRACE,NOTICE,WARNING,FATAL); 
#   $3,要打印的信息;
# Returns:
#   succ:0
#   fail:1
#######################################
function write_log_() {
    local FN_DATE=`date +"%m-%d %H:%M:%S"`
    local FN_LINENO=$1
    local FN_LEVEL=$2
    local FN_MSG=$3
    if [[ ! -z "${LOG_FILE}" && -d "${LOG_FILE%/*}" ]]; then
        if [[ "${FN_LEVEL}" = "FATAL" || "${FN_LEVEL}" = "WARNING" ]]; then
            echo -e "${FN_LEVEL}: ${FN_DATE}:  ${SHELL_NAME} 
                [${0}:${FN_LINENO}] [${FN_MSG}]" >> ${LOG_FILE}.wf
        else
            echo -e "${FN_LEVEL}: ${FN_DATE}:  ${SHELL_NAME} 
                [${0}:${FN_LINENO}] [${FN_MSG}]" >> ${LOG_FILE}
        fi
    else
        echo -e "${FN_LEVEL}: ${FN_DATE}:  ${SHELL_NAME} [${0}:${FN_LINENO}] 
            [${FN_MSG}]" >&2
    fi
    return 0
}
alias write_log='write_log_ $LINENO'

#######################################
# Brief:
#   输出DEBUG日志
# Globals:
#   none
# Arguments:
#   $1,行号; 
#   $2,要打印的信息;
# Returns:
#   succ:0
#   fail:1
#######################################
function debug_log_() {
    local FN_LINENO=$1
    local FN_MSG=$2
    write_log_ "${FN_LINENO}" "DEBUG" "${FN_MSG}"
    return 0
}
alias debug_log='debug_log_ $LINENO'

#######################################
# Brief:
#   输出TRACE日志
# Globals:
#   none
# Arguments:
#   $1,行号; 
#   $2,要打印的信息;
# Returns:
#   succ:0
#   fail:1
#######################################
function trace_log_() {
    local FN_LINENO=$1
    local FN_MSG=$2
    write_log_ "${FN_LINENO}" "TRACE" "${FN_MSG}"
    return 0
}
alias trace_log='trace_log_ $LINENO'

#######################################
# Brief:
#   输出NOTICE日志
# Globals:
#   none
# Arguments:
#   $1,行号; 
#   $2,要打印的信息;
# Returns:
#   succ:0
#   fail:1
#######################################
function notice_log_() {
    local FN_LINENO=$1
    local FN_MSG=$2
    write_log_ "${FN_LINENO}" "NOTICE" "${FN_MSG}"
    return 0
}
alias notice_log='notice_log_ $LINENO'

#######################################
# Brief:
#   输出WARNING日志
# Globals:
#   none
# Arguments:
#   $1,行号; 
#   $2,要打印的信息;
# Returns:
#   succ:0
#   fail:1
#######################################
function warning_log_() {
    local FN_LINENO=$1
    local FN_MSG=$2
    write_log_ "${FN_LINENO}" "WARNING" "${FN_MSG}"
    return 0
}
alias warning_log='warning_log_ $LINENO'

#######################################
# Brief:
#   输出FATAL日志
# Globals:
#   none
# Arguments:
#   $1,行号; 
#   $2,要打印的信息;
# Returns:
#   succ:0
#   fail:1
#######################################
function fatal_log_() {
    local FN_LINENO=$1
    local FN_MSG=$2
    write_log_ "${FN_LINENO}" "FATAL" "${FN_MSG}"
    return 0
}
alias fatal_log='fatal_log_ $LINENO'

#######################################
# Brief:
#   检查running文件是否存在，若存在则异常退出.若不存在，则创建继续.
# Globals:
#   none
# Arguments:
#   $1,行号; 
# Returns:
#   succ:0
#   fail:1
#######################################
function check_running_file_() {
    local FN_LINENO=$1
    local FN_RUNNING_FILE="./$0.running"
    local FN_DEL_FLAG=1
    if [[ -f "${FN_RUNNING_FILE}" ]]; then
        fatal_log_ "${FN_LINENO}" "running file[${FN_RUNNING_FILE}] 
            already exist. will not run." 
        err_exit_ "${FN_LINENO}" "${FN_DEL_FLAG}"
    fi
    touch ${FN_RUNNING_FILE}
    if [[ $? -ne 0 ]]; then
        fatal_log_ "${FN_LINENO}" "running file[${FN_RUNNING_FILE}] 
            touch failed." 
        err_exit_ "${FN_LINENO}"
    fi
    return 0
}
alias check_running_file='check_running_file_ $LINENO'

#######################################
# Brief:
#   删除running文件
# Globals:
#   none
# Arguments:
#   $1,行号; 
# Returns:
#   succ:0
#   fail:1
#######################################
function delete_running_file_() {
    local FN_LINENO=$1
    local FN_RUNNING_FILE="./$0.running"
    if [[ -f "${FN_RUNNING_FILE}" ]]; then
        rm -f ${FN_RUNNING_FILE}
        if [[ $? -ne 0 ]]; then
            fatal_log_ "${FN_LINENO}" "running file[${FN_RUNNING_FILE}] 
                rm failed." 
            err_exit_ "${FN_LINENO}"
        fi
    fi
    return 0
}
alias delete_running_file='delete_running_file_ $LINENO'

#######################################
# Brief:
#   检查配置项是否为空.若空则异常退出.
# Globals:
#   none
# Arguments:
#   $1,行号; 
#   $2,要检查的配置项名;
# Returns:
#   succ:0
#   fail:1
#######################################
function check_conf_item_() {
    local FN_LINENO=$1
    local FN_NAME=$2
    eval "FN_CONF=\${${FN_NAME}}"
    if [[ -z "${FN_CONF}" ]]; then
        fatal_log_ "${FN_LINENO}" "conf item ${FN_NAME} is empty." 
        err_exit_ "${FN_LINENO}"
    fi
    return 0
}
alias check_conf_item='check_conf_item_ $LINENO'

#######################################
# Brief:
#   检查本地文件是否存在.若不存在则异常退出.
# Globals:
#   none
# Arguments:
#   $1,行号; 
#   $2,要检查的文件路径;
# Returns:
#   succ:0
#   fail:1
#######################################
function check_file_() {
    local FN_LINENO=$1
    local FN_FILE=$2

    if [[ ! -f "${FN_FILE}" ]]; then
        fatal_log_ "${FN_LINENO}" "file[${FN_FILE}] is not exist."
        err_exit_ "${FN_LINENO}"
    fi
    return 0
}
alias check_file='check_file_ $LINENO'

#######################################
# Brief:
#   检查本地BIN文件是否存在.若不存在则异常退出.若存在则加执行权限.
# Globals:
#   none
# Arguments:
#   $1,行号; 
#   $2,要检查的BIN文件路径;
# Returns:
#   succ:0
#   fail:1
#######################################
function check_bin_() {
    local FN_LINENO=$1
    local FN_FILE=$2
    check_file_ "${FN_LINENO}" "${FN_FILE}"
    chmod a+x "${FN_FILE}" >&2
    return 0
}
alias check_bin='check_bin_ $LINENO'

#######################################
# Brief:
#   检查所给文件的路径是否存在.若不存在则创建.创建不成功则异常退出.
# Globals:
#   none
# Arguments:
#   $1,行号; 
#   $2,要检查的文件全路径;
# Returns:
#   succ:0
#   fail:1
#######################################
function check_file_path_() {
    local FN_LINENO=$1
    local FN_FILE=$2
    local FN_PATH="${FN_FILE%/*}"
    if [[ ! -d "${FN_PATH}" ]]; then
        notice_log_ "${FN_LINENO}" "file[${FN_PATH}] is not exist, create it." 
    fi
    mkdir -p ${FN_PATH} >&2
    if [[ $? -ne 0 ]]; then
        fatal_log_ "${FN_LINENO}" "mkdir -p ${FN_PATH} error."
        err_exit_ "${FN_LINENO}"
    fi
    return 0
}
alias check_file_path='check_file_path_ $LINENO'

#######################################
# Brief:
#   文件由utf8转码为gbk.
#   若源文件不存在或目的文件路径创建不成功或转码异常则异常退出.
# Globals:
#   none
# Arguments:
#   $1,行号; 
#   $2,源文件路径; 
#   $3,目的文件路径;
# Returns:
#   succ:0
#   fail:1
#######################################
function utf8_to_gbk_() {
    local FN_LINENO=$1
    local FN_SOURCE=$2
    local FN_TARGET=$3
    check_file_ "${FN_LINENO}" "${FN_SOURCE}"
    check_file_path_ "${FN_LINENO}" "${FN_TARGET}"
    iconv -f utf-8 -t gbk -c ${FN_SOURCE} > ${FN_TARGET}
    #if [[ $? -ne 0 ]]; then
    #    fatal_log_ "${FN_LINENO}" "iconv -f utf-8 -t gbk ${FN_SOURCE} 
    #     > ${FN_TARGET} error."
    #    err_exit_ "${FN_LINENO}"
    #fi
    return 0
}
alias utf8_to_gbk='utf8_to_gbk_ $LINENO'

#######################################
# Brief:
#   将文件\t分割的第一列切词后追加到最后一列.
#   若源文件不存在或目的文件路径创建不成功或切词异常则异常退出.
# Globals:
#   none
# Arguments:
#   $1,行号; 
#   $2,源文件路径; 
#   $3,目的文件路径;
# Returns:
#   succ:0
#   fail:1
#######################################
function query_segword_() {
    local FN_LINENO=$1
    local FN_SOURCE=$2
    local FN_TARGET=$3
    check_file_ "${FN_LINENO}" "${FN_SOURCE}"
    check_file_path_ "${FN_LINENO}" "${FN_TARGET}"
    cat ${FN_SOURCE} | sed "s/\t/ /g" | ${SEGWORD_BINPATH} > ${FN_TARGET}
    if [[ $? -ne 0 ]]; then
        fatal_log_ "${FN_LINENO}" "cat ${FN_SOURCE} | ./${SEGWORD_BINPATH} > 
            ${FN_TARGET} error."
        err_exit_ "${FN_LINENO}"
    fi
    return 0
}
alias query_segword='query_segword_ $LINENO'

#######################################
# Brief:
#   检查所给的路径是否存在.若不存在则创建.创建不成功则异常退出.
# Globals:
#   none
# Arguments:
#   $1,行号; 
#   $2,要检查的路径;
# Returns:
#   succ:0
#   fail:1
#######################################
function check_path_() {
    local FN_LINENO=$1
    local FN_PATH=$2

    if [[ ! -d "${FN_PATH}" ]]; then
        notice_log_ "${FN_LINENO}" "mkdir -p ${FN_PATH}."
        mkdir -p ${FN_PATH}
        if [[ $? -ne 0 ]]; then
            fatal_log_ "${FN_LINENO}" "mkdir -p ${FN_PATH} error." 
            err_exit_ "${FN_LINENO}"
        fi
    fi
    return 0
}
alias check_path='check_path_ $LINENO'

#######################################
# Brief:
#   将字符串eval转换为pattern所指定的字符串.若命令异常则异常退出.
# Globals:
#   none
# Arguments:
#   $1,行号; 
#   $2,模式串; 
#   $3,目的变量名;
# Returns:
#   succ:0
#   fail:1
#######################################
function eval_pat_() {
    local FN_LINENO=$1
    local FN_TARGET_PAT=$2
    local FN_TARGET=$3

    eval "${FN_TARGET}=${FN_TARGET_PAT}" >&2

    if [[ $? -ne 0 ]]; then
        fatal_log_ "${FN_LINENO}" "eval \"${FN_TARGET}=${FN_TARGET_PAT}\" 
            error." 
        err_exit_ "${FN_LINENO}"
    fi
    notice_log_ "${FN_LINENO}" "eval \"${FN_TARGET}=${FN_TARGET_PAT}\" succ. \
        ${FN_TARGET}=[${!FN_TARGET}]."
    return 0
}
alias eval_pat='eval_pat_ $LINENO'

#######################################
# Brief:
#   检查要加载的文件是否存在，若存在则加载，不存在则异常退出.
# Globals:
#   none
# Arguments:
#   $1,行号; 
#   $2,需要加载的文件;
# Returns:
#   succ:0
#   fail:1
#######################################
function source_file_() {
    local FN_LINENO=$1
    local FN_TARGET=$2
    if [[ ! -f "${FN_TARGET}" ]]; then
        fatal_log_ "${FN_LINENO}" "file[${FN_TARGET}] not exist."
        err_exit_ "${FN_LINENO}"
    fi
    source "${FN_TARGET}"
    if [[ $? -ne 0 ]]; then
        fatal_log_ "${FN_LINENO}" "source file[${FN_TARGET}] error."
        err_exit_ "${FN_LINENO}"
    fi
    return 0
}
alias source_file='source_file_ $LINENO'

#######################################
# Brief:
#   ftp抓取文件到指定路径名.若异常则退出.
# Globals:
#   none
# Arguments:
#   $1,行号; 
#   $2,源文件路径; 
#   $3,目的文件名;
# Returns:
#   succ:0
#   fail:1
#######################################
function wget_file_() {
    local FN_LINENO=$1
    local FN_SOURCE=$2
    local FN_TARGET=$3
    check_file_path_ "${FN_LINENO}" "${FN_TARGET}"
    if [[ -f "${FN_TARGET}" ]]; then
        rm -f ${FN_TARGET} >&2
        if [[ $? -ne 0 ]]; then
            fatal_log_ "${FN_LINENO}" "rm -f ${FN_TARGET} error."
            err_exit_ "${FN_LINENO}"
        fi
    fi
    wget ${FN_SOURCE} -O ${FN_TARGET} >>${LOG_FILE} 2>&1
    if [[ $? -ne 0 ]]; then
        fatal_log_ "${FN_LINENO}" "wget ${FN_SOURCE} -O ${FN_TARGET} error."
        err_exit_ "${FN_LINENO}"
    fi
    return 0
}
alias wget_file='wget_file_ $LINENO'

function wget_file_withretry_() {
    local FN_LINENO=$1
    local FN_SOURCE=$2
    local FN_TARGET=$3
    local FN_ALERT_HOUR=10
    local FN_QUIT_HOUR=16
    local FN_SLEEP_SECONDS=1800
    local FN_RETRY_TIMES=0
    while [[ 1 -eq 1 ]]; do
        wget ${FN_SOURCE} -O ${FN_TARGET}
        if [[ $? -ne 0 ]]; then
            notice_log_ "${FN_LINENO}" "ftp file[${FN_SOURCE}] no exist error."
        else
            notice_log_ "${FN_LINENO}" "ftp file[${FN_SOURCE}] get succ."
            break
        fi
        local FN_HOUR=`date +"%H"`
        if [[ ${FN_HOUR} -gt ${FN_ALERT_HOUR} ]]; then
            alert_ "${FN_LINENO}" "file[${FN_SOURCE}] still not already."
        fi
        if [[ ${FN_HOUR} -gt ${FN_QUIT_HOUR} ]]; then
            alert_ "${FN_LINENO}" "file[${FN_SOURCE}] exit."
            err_exit_ "${FN_LINENO}"
        fi
        ((FN_RETRY_TIMES++))
        sleep ${FN_SLEEP_SECONDS}
    done
}
alias wget_file_withretry='wget_file_withretry_ $LINENO'

#######################################
# Brief:
#   ftp抓取文件到指定路径名,并进行md5校验.若异常则退出.
# Globals:
#   none
# Arguments:
#   $1,行号; 
#   $2,源文件路径; 
#   $3,目的文件名;
# Returns:
#   succ:0
#   fail:1
#######################################
function wget_file_withmd5_() {
    local FN_LINENO=$1
    local FN_SOURCE=$2
    local FN_TARGET=$3
    wget_file_ "${FN_LINENO}" "${FN_SOURCE}" "${FN_TARGET}"
    wget_file_ "${FN_LINENO}" "${FN_SOURCE}.md5" "${FN_TARGET}.md5"
    local FN_MD5ADD=`md5sum ${FN_TARGET} | awk '{print $1}'`
    local FN_MD5OLD=`head -n 1 ${FN_TARGET}.md5 | awk '{print $1}'`
    if [[ "${FN_MD5ADD}" != "${FN_MD5OLD}" ]]; then
        fatal_log_ "${FN_LINENO}" "${FN_MD5ADD} != ${FN_MD5OLD} error."
        err_exit_ "${FN_LINENO}"
    fi
    return 0
}
alias wget_file_withmd5='wget_file_withmd5_ $LINENO'

function wget_file_withmd5_withretry_() {
    local FN_LINENO=$1
    local FN_SOURCE=$2
    local FN_TARGET=$3
    local FN_ALERT_HOUR=10
    local FN_QUIT_HOUR=16
    local FN_SLEEP_SECONDS=1800
    local FN_RETRY_TIMES=0
    while [[ 1 -eq 1 ]]; do
        wget ${FN_SOURCE} -O ${FN_TARGET}
        if [[ $? -ne 0 ]]; then
            notice_log_ "${FN_LINENO}" "ftp file[${FN_SOURCE}] no exist error."
        else
            notice_log_ "${FN_LINENO}" "ftp file[${FN_SOURCE}] get succ."
            wget ${FN_SOURCE}.md5 -O ${FN_TARGET}.md5
            if [[ $? -ne 0 ]]; then
                notice_log_ "${FN_LINENO}" "ftp file[${FN_SOURCE}.md5] 
                    no exist error."
            else
                notice_log_ "${FN_LINENO}" "ftp file[${FN_SOURCE}.md5] 
                    get succ."
                local FN_FILE_MD5=`md5sum ${FN_TARGET} | awk '{print $1;}'`
                local FN_MD5_VALUE=`cat ${FN_TARGET}.md5 | awk '{print $1;}'`
                if [[ "${FN_FILE_MD5}" == "${FN_MD5_VALUE}" ]]; then
                    notice_log_ "${FN_LINENO}" "file md5[${FN_FILE_MD5}] == 
                        md5 value[${FN_MD5_VALUE}] succ."
                    break
                else
                    fatal_log_ "${FN_LINENO}" "file md5[${FN_FILE_MD5}] != md5 
                        value[${FN_MD5_VALUE}] error."
                fi
            fi
        fi
        local FN_HOUR=`date +"%H"`
        if [[ ${FN_HOUR} -gt ${FN_ALERT_HOUR} ]]; then
            alert_ "${FN_LINENO}" "file[${FN_SOURCE}] still not already."
        fi
        if [[ ${FN_HOUR} -gt ${FN_QUIT_HOUR} ]]; then
            alert_ "${FN_LINENO}" "file[${FN_SOURCE}] exit."
            err_exit_ "${FN_LINENO}"
        fi
        ((FN_RETRY_TIMES++))
        sleep ${FN_SLEEP_SECONDS}
    done
}
alias wget_file_withmd5_withretry='wget_file_withmd5_withretry_ $LINENO'

#######################################
# Brief:
#   ftp抓取批量文件到指定路径下.若异常则退出.
# Globals:
#   none
# Arguments:
#   $1,行号; 
#   $2,源文件路径; 
#   $3,目的路径;
# Returns:
#   succ:0
#   fail:1
#######################################
function wget_files_() {
    local FN_LINENO=$1
    local FN_SOURCE=$2
    local FN_TARGET=$3
    if [[ -z "${FN_TARGET}" ]]; then
        fatal_log_ "${FN_LINENO}" "FN_TARGET be null error."
        err_exit_ "${FN_LINENO}"
    fi
    check_path_ "${FN_LINENO}" "${FN_TARGET}"
    wget ${FN_SOURCE} -c -P ${FN_TARGET}/ >>${LOG_FILE} 2>&1
    if [[ $? -ne 0 ]]; then
        fatal_log_ "${FN_LINENO}" "wget ${FN_SOURCE} -P ${FN_TARGET} error."
        err_exit_ "${FN_LINENO}"
    fi
    return 0
}
alias wget_files='wget_files_ $LINENO'

#######################################
# Brief:
#   发送报警邮件
# Globals:
#   none
# Arguments:
#   $1,邮件标题; 
# Returns:
#   succ:0
#   fail:1
#######################################
function mail_() {
    local FN_MSG=$1
    if [[ ! -z "${MAIL_LIST}" ]]; then
        echo "RT" | mail -s "[${FN_MSG}]`hostname`:`pwd`/$0 " "${MAIL_LIST}"
    fi
    return 0
}

#######################################
# Brief:
#   发送报警短信
# Globals:
#   none
# Arguments:
#   $1,短信内容; 
# Returns:
#   succ:0
#   fail:1
#######################################
function alert_() {
    local FN_MSG=$1
    if [[ ! -z "${PHONE_LIST}" ]]; then
        local FN_GSMSEND_CONF="-s emp01.baidu.com:15003 -s 
            emp02.baidu.com:15003"
        gsmsend ${FN_GSMSEND_CONF} ${PHONE_LIST}@"[${FN_MSG}]
            `hostname`:`pwd`/$0"
    fi
    return 0
}

#######################################
# Brief:
#   异常退出并打log.
# Globals:
#   none
# Arguments:
#   $1,行号; 
#   $2,是否删除running文件，不传或非1则表示删除
# Returns:
#   succ:0
#   fail:1
#######################################
function err_exit_() {
    local FN_LINENO=$1
    local FN_DEL_FLAG=$2
    if [[ -z "${FN_DEL_FLAG}" || "${FN_DEL_FLAG}" != "1" ]]; then
        delete_running_file_ "${FN_LINENO}"
    fi
    notice_log_ "${FN_LINENO}" "PROGRAM ERROR EXIT."
    mail_ "PROGRAM ERROR EXIT"
    alert_ "PROGRAM ERROR EXIT"
    exit 1
}
alias err_exit='err_exit_ $LINENO'

#######################################
# Brief:
#   检查hdfs文件是否存在.若不存在则异常退出.
# Globals:
#   none
# Arguments:
#   $1,行号; 
#   $2,要检查的文件路径;
# Returns:
#   succ:0
#   fail:1
#######################################
function check_hdfs_file_() {
    local FN_LINENO=$1
    local FN_FILE=$2
    `${HADOOP_BINPATH} fs -test -e ${FN_FILE} >> "${LOG_FILE}" 2>&1`
    if [[ $? -ne 0 ]]; then
        fatal_log_ "${FN_LINENO}" "file[${FN_FILE}] is not exist."
        err_exit_ "${FN_LINENO}"
    fi
    return 0
}
alias check_hdfs_file='check_hdfs_file_ $LINENO'

#######################################
# Brief:
#   检查hdfs文件是否存在.若不存在则返回0.若存在则删除.
# Globals:
#   none
# Arguments:
#   $1,行号; 
#   $2,要检查的文件路径;
# Returns:
#   succ:0
#   fail:1
#######################################
function del_hdfs_file_() {
    local FN_LINENO=$1
    local FN_FILE=$2
    `${HADOOP_BINPATH} fs -test -e ${FN_FILE} >> "${LOG_FILE}" 2>&1`
    if [[ $? -eq 0 ]]; then
        notice_log_ "${FN_LINENO}" "file[${FN_FILE}] exist. delete it."
        `${HADOOP_BINPATH} fs -rmr ${FN_FILE} >> "${LOG_FILE}" 2>&1`
        if [[ $? -ne 0 ]]; then
            fatal_log_ "${FN_LINENO}" "${HADOOP_BINPATH} fs -rmr ${FN_FILE} 
                error."
            err_exit_ "${FN_LINENO}"
        fi
    fi
    return 0
}
alias del_hdfs_file='del_hdfs_file_ $LINENO'

#######################################
# Brief:
#   检查hdfs路径是否存在.若不存在则返回0.若存在则删除.
# Globals:
#   none
# Arguments:
#   $1,行号; 
#   $2,要检查的文件路径;
# Returns:
#   succ:0
#   fail:1
#######################################
alias del_hdfs_path='del_hdfs_file_ $LINENO'

#######################################
# Brief:
#   检查hdfs路径是否存在.若不存在则创建.若异常则退出.
# Globals:
#   none
# Arguments:
#   $1,行号; 
#   $2,要检查的路径;
# Returns:
#   succ:0
#   fail:1
#######################################
function check_hdfs_path_() {
    local FN_LINENO=$1
    local FN_PATH=$2
    `${HADOOP_BINPATH} fs -test -d ${FN_PATH} >> "${LOG_FILE}" 2>&1`
    if [[ $? -ne 0 ]]; then
        notice_log_ "${FN_LINENO}" "${HADOOP_BINPATH} fs -mkdir ${FN_PATH}"
        `${HADOOP_BINPATH} fs -mkdir ${FN_PATH} >> "${LOG_FILE}" 2>&1`
        if [[ $? -ne 0 ]]; then
            fatal_log_ "${FN_LINENO}" "${HADOOP_BINPATH} fs -mkdir ${FN_PATH} 
                error." 
            err_exit_ "${FN_LINENO}"
        fi
    fi
    return 0
}
alias check_hdfs_path='check_hdfs_path_ $LINENO'

#######################################
# Brief:
#   将一个文件put到hdfs上,若之前存在同名文件则删除之前的.若异常则退出.
# Globals:
#   none
# Arguments:
#   $1,行号; 
#   $2,本地源文件路径; 
#   $3,hdfs目的文件名;
# Returns:
#   succ:0
#   fail:1
#######################################
function put_file_to_hdfs_() {
    local FN_LINENO=$1
    local FN_SOURCE=$2
    local FN_TARGET=$3
    local FN_PATH="${FN_TARGET%/*}"
    check_hdfs_path_ "${FN_LINENO}" "${FN_PATH}"
    del_hdfs_file_ "${FN_LINENO}" "${FN_TARGET}"
    `${HADOOP_BINPATH} fs -put ${FN_SOURCE} ${FN_TARGET} >> "${LOG_FILE}" 2>&1`
    if [[ $? -ne 0 ]]; then
        fatal_log_ "${FN_LINENO}" "${HADOOP_BINPATH} fs -put ${FN_SOURCE} 
            ${FN_TARGET}."
        err_exit_ "${FN_LINENO}"
    fi
    return 0
}
alias put_file_to_hdfs='put_file_to_hdfs_ $LINENO'

#######################################
# Brief:
#   将多个文件put到hdfs上,若之前存在同名文件则删除之前的.若异常则退出.
# Globals:
#   none
# Arguments:
#   $1,行号; 
#   $2,本地源文件路径; 
#   $3,hdfs目的文件名;
# Returns:
#   succ:0
#   fail:1
#######################################
function put_files_to_hdfs_() {
    local FN_LINENO=$1
    local FN_SOURCE=$2
    local FN_TARGET=$3
    for file in `ls ${FN_SOURCE}`; do
        local FN_TARGETPATH="${FN_TARGET}/${file##*/}"
        put_file_to_hdfs_ "${FN_LINENO}" "${file}" "${FN_TARGETPATH}"
    done 
    return 0
}
alias put_files_to_hdfs='put_files_to_hdfs_ $LINENO'

#######################################
# Brief:
#   将多个hdfs文件cat到本地文件中.若异常则退出.
# Globals:
#   none
# Arguments:
#   $1,行号; 
#   $2,hdfs源文件路径; 
#   $3,本地目的路径;
# Returns:
#   succ:0
#   fail:1
#######################################
function cat_hdfs_files_to_localfile_() {
    local FN_LINENO=$1
    local FN_SOURCE=$2
    local FN_TARGET=$3
    check_file_path_ "${FN_LINENO}" "${FN_TARGET}"
    `${HADOOP_BINPATH} fs -cat ${FN_SOURCE} > ${FN_TARGET}`
    if [[ $? -ne 0 ]]; then
        fatal_log_ "${FN_LINENO}" "${HADOOP_BINPATH} fs -put ${FN_SOURCE} 
            ${FN_TARGET}."
        err_exit_ "${FN_LINENO}"
    fi
    return 0
}
alias cat_hdfs_files_to_localfile='cat_hdfs_files_to_localfile_ $LINENO'

