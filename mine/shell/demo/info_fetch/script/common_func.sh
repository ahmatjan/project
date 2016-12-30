#!/bin/bash

##! @TODO: ͨ�ú���
##! @VERSION: 1.0.0.0
##! @AUTHOR: yangkai04@baidu.com

# ��¼������Ϣ
#set -x
# ǿ�ƹܵ���������˳�
set -o pipefail
# ��֤write_log���Դ�ӡ�к�
shopt -s expand_aliases

##! @TODO: �����־.���Ŀ¼���ڣ����������־�ļ���.�������������̨.
##! @AUTHOR: yangkai04@baidu.com
##! @IN: $1,�к�; 
##! @IN: $2,��־�ȼ�(DEBUG,TRACE,NOTICE,WARNING,FATAL); 
##! @IN: $3,Ҫ��ӡ����Ϣ;
##! @OUT: 0 => success; other => failed
function write_log_() {
    local FN_DATE=`date +"%m-%d %H:%M:%S"`
    local FN_LINENO=$1
    local FN_LEVEL=$2
    local FN_MSG=$3
    if [ ! -z "${LOG_FILE}" -a -d "${LOG_FILE%/*}" ]
    then
        if [ "${FN_LEVEL}" = "FATAL" -o "${FN_LEVEL}" = "WARNING" ]
        then
            echo -e "${FN_LEVEL}: ${FN_DATE}:  ${SHELL_NAME} [${0}:${FN_LINENO}] [${FN_MSG}]" \
            >> ${LOG_FILE}.wf
        else
            echo -e "${FN_LEVEL}: ${FN_DATE}:  ${SHELL_NAME} [${0}:${FN_LINENO}] [${FN_MSG}]" \
            >> ${LOG_FILE}
        fi
    else
        echo -e "${FN_LEVEL}: ${FN_DATE}:  ${SHELL_NAME} [${0}:${FN_LINENO}] [${FN_MSG}]" >&2
    fi
    return 0
}
alias write_log='write_log_ $LINENO'

##! @TODO: ���DEBUG��־
##! @AUTHOR: yangkai04@baidu.com
##! @IN: $1,�к�; 
##! @IN: $2,Ҫ��ӡ����Ϣ;
##! @OUT: 0 => success; other => failed
function debug_log_() {
    local FN_LINENO=$1
    local FN_MSG=$2
    write_log_ "${FN_LINENO}" "DEBUG" "${FN_MSG}"
    return 0
}
alias debug_log='debug_log_ $LINENO'

##! @TODO: ���TRACE��־
##! @AUTHOR: yangkai04@baidu.com
##! @IN: $1,�к�; 
##! @IN: $2,Ҫ��ӡ����Ϣ;
##! @OUT: 0 => success; other => failed
function trace_log_() {
    local FN_LINENO=$1
    local FN_MSG=$2
    write_log_ "${FN_LINENO}" "TRACE" "${FN_MSG}"
    return 0
}
alias trace_log='trace_log_ $LINENO'

##! @TODO: ���NOTICE��־
##! @AUTHOR: yangkai04@baidu.com
##! @IN: $1,�к�; 
##! @IN: $2,Ҫ��ӡ����Ϣ;
##! @OUT: 0 => success; other => failed
function notice_log_() {
    local FN_LINENO=$1
    local FN_MSG=$2
    write_log_ "${FN_LINENO}" "NOTICE" "${FN_MSG}"
    return 0
}
alias notice_log='notice_log_ $LINENO'

##! @TODO: ���WARNING��־
##! @AUTHOR: yangkai04@baidu.com
##! @IN: $1,�к�; 
##! @IN: $2,Ҫ��ӡ����Ϣ;
##! @OUT: 0 => success; other => failed
function warning_log_() {
    local FN_LINENO=$1
    local FN_MSG=$2
    write_log_ "${FN_LINENO}" "WARNING" "${FN_MSG}"
    return 0
}
alias warning_log='warning_log_ $LINENO'

##! @TODO: ���FATAL��־
##! @AUTHOR: yangkai04@baidu.com
##! @IN: $1,�к�; 
##! @IN: $2,Ҫ��ӡ����Ϣ;
##! @OUT: 0 => success; other => failed
function fatal_log_() {
    local FN_LINENO=$1
    local FN_MSG=$2
    write_log_ "${FN_LINENO}" "FATAL" "${FN_MSG}"
    return 0
}
alias fatal_log='fatal_log_ $LINENO'

##! @TODO: ���running�ļ��Ƿ���ڣ����������쳣�˳�.�������ڣ��򴴽�����.
##! @AUTHOR: yangkai04@baidu.com
##! @IN: $1,�к�; 
##! @OUT: 0 => success; other => failed
function check_running_file_() {
    local FN_LINENO=$1
    local FN_RUNNING_FILE="./$0.running"
    local FN_DEL_FLAG=1
    if [ -f "${FN_RUNNING_FILE}" ]
    then
        fatal_log_ "${FN_LINENO}" "running file[${FN_RUNNING_FILE}] already exist. will not run." 
        err_exit_ "${FN_LINENO}" "${FN_DEL_FLAG}"
    fi
    touch ${FN_RUNNING_FILE}
    if [ $? -ne 0 ]
    then
        fatal_log_ "${FN_LINENO}" "running file[${FN_RUNNING_FILE}] touch failed." 
        err_exit_ "${FN_LINENO}"
    fi
    return 0
}
alias check_running_file='check_running_file_ $LINENO'

##! @TODO: ɾ��running�ļ�
##! @AUTHOR: yangkai04@baidu.com
##! @IN: $1,�к�; 
##! @OUT: 0 => success; other => failed
function delete_running_file_() {
    local FN_LINENO=$1
    local FN_RUNNING_FILE="./$0.running"
    if [ -f "${FN_RUNNING_FILE}" ]
    then
        rm -f ${FN_RUNNING_FILE}
        if [ $? -ne 0 ]
        then
            fatal_log_ "${FN_LINENO}" "running file[${FN_RUNNING_FILE}] rm failed." 
            err_exit_ "${FN_LINENO}"
        fi
    fi
    return 0
}
alias delete_running_file='delete_running_file_ $LINENO'

##! @TODO: ����������Ƿ�Ϊ��.�������쳣�˳�.
##! @AUTHOR: yangkai04@baidu.com
##! @IN: $1,�к�; 
##! @IN: $2,Ҫ������������;
##! @OUT: 0 => success; other => failed
function check_conf_item_() {
    local FN_LINENO=$1
    local FN_NAME=$2
    eval "FN_CONF=\${${FN_NAME}}"
    if [ -z "${FN_CONF}" ]
    then
        fatal_log_ "${FN_LINENO}" "conf item ${FN_NAME} is empty." 
        err_exit_ "${FN_LINENO}"
    fi
    return 0
}
alias check_conf_item='check_conf_item_ $LINENO'

##! @TODO: ��鱾���ļ��Ƿ����.�����������쳣�˳�.
##! @AUTHOR: yangkai04@baidu.com
##! @IN: $1,�к�; 
##! @IN: $2,Ҫ�����ļ�·��;
##! @OUT: 0 => success; other => failed
function check_file_() {
    local FN_LINENO=$1
    local FN_FILE=$2

    if [ ! -f "${FN_FILE}" ]
    then
        fatal_log_ "${FN_LINENO}" "file[${FN_FILE}] is not exist."
        err_exit_ "${FN_LINENO}"
    fi
    return 0
}
alias check_file='check_file_ $LINENO'

##! @TODO: ��鱾��BIN�ļ��Ƿ����.�����������쳣�˳�.���������ִ��Ȩ��.
##! @AUTHOR: yangkai04@baidu.com
##! @IN: $1,�к�; 
##! @IN: $2,Ҫ����BIN�ļ�·��;
##! @OUT: 0 => success; other => failed
function check_bin_() {
    local FN_LINENO=$1
    local FN_FILE=$2
    check_file_ "${FN_LINENO}" "${FN_FILE}"
    chmod a+x "${FN_FILE}" >&2
    return 0
}
alias check_bin='check_bin_ $LINENO'

##! @TODO: ��������ļ���·���Ƿ����.���������򴴽�.�������ɹ����쳣�˳�.
##! @AUTHOR: yangkai04@baidu.com
##! @IN: $1,�к�; 
##! @IN: $2,Ҫ�����ļ�ȫ·��;
##! @OUT: 0 => success; other => failed
function check_file_path_() {
    local FN_LINENO=$1
    local FN_FILE=$2
    local FN_PATH="${FN_FILE%/*}"

    if [ ! -d "${FN_PATH}" ]
    then
        notice_log_ "${FN_LINENO}" "file[${FN_PATH}] is not exist, create it." 
    fi
    mkdir -p ${FN_PATH} >&2
    if [ $? -ne 0 ]
    then
        fatal_log_ "${FN_LINENO}" "mkdir -p ${FN_PATH} error."
        err_exit_ "${FN_LINENO}"
    fi
    return 0
}
alias check_file_path='check_file_path_ $LINENO'

##! @TODO: �ļ���utf8ת��Ϊgbk.��Դ�ļ������ڻ�Ŀ���ļ�·���������ɹ���ת���쳣���쳣�˳�.
##! @AUTHOR: yangkai04@baidu.com
##! @IN: $1,�к�; 
##! @IN: $2,Դ�ļ�·��; 
##! @IN: $3,Ŀ���ļ�·��;
##! @OUT: 0 => success; other => failed
function utf8_to_gbk_() {
    local FN_LINENO=$1
    local FN_SOURCE=$2
    local FN_TARGET=$3
    check_file_ "${FN_LINENO}" "${FN_SOURCE}"
    check_file_path_ "${FN_LINENO}" "${FN_TARGET}"
    iconv -f utf-8 -t gbk ${FN_SOURCE} > ${FN_TARGET}
    if [ $? -ne 0 ]
    then
        fatal_log_ "${FN_LINENO}" "iconv -f utf-8 -t gbk ${FN_SOURCE} > ${FN_TARGET} error."
        err_exit_ "${FN_LINENO}"
    fi
    return 0
}
alias utf8_to_gbk='utf8_to_gbk_ $LINENO'

##! @TODO: ���ļ�\t�ָ�ĵ�һ���дʺ�׷�ӵ����һ��.
##!        ��Դ�ļ������ڻ�Ŀ���ļ�·���������ɹ����д��쳣���쳣�˳�.
##! @AUTHOR: yangkai04@baidu.com
##! @IN: $1,�к�; 
##! @IN: $2,Դ�ļ�·��; 
##! @IN: $3,Ŀ���ļ�·��;
##! @OUT: 0 => success; other => failed
function query_segword_() {
    local FN_LINENO=$1
    local FN_SOURCE=$2
    local FN_TARGET=$3
    check_file_ "${FN_LINENO}" "${FN_SOURCE}"
    check_file_path_ "${FN_LINENO}" "${FN_TARGET}"
    cat ${FN_SOURCE} | sed "s/\t/ /g" | ${SEGWORD_BINPATH} > ${FN_TARGET}
    if [ $? -ne 0 ]
    then
        fatal_log_ "${FN_LINENO}" "cat ${FN_SOURCE} | ./${SEGWORD_BINPATH} > ${FN_TARGET} error."
        err_exit_ "${FN_LINENO}"
    fi
    return 0
}
alias query_segword='query_segword_ $LINENO'

##! @TODO: ���������·���Ƿ����.���������򴴽�.�������ɹ����쳣�˳�.
##! @AUTHOR: yangkai04@baidu.com
##! @IN: $1,�к�; 
##! @IN: $2,Ҫ����·��;
##! @OUT: 0 => success; other => failed
function check_path_() {
    local FN_LINENO=$1
    local FN_PATH=$2

    if [ ! -d "${FN_PATH}" ]
    then
        notice_log_ "${FN_LINENO}" "mkdir -p ${FN_PATH}."
        mkdir -p ${FN_PATH}
        if [ $? -ne 0 ]
        then
            fatal_log_ "${FN_LINENO}" "mkdir -p ${FN_PATH} error." 
            err_exit_ "${FN_LINENO}"
        fi
    fi
    return 0
}
alias check_path='check_path_ $LINENO'

##! @TODO: ���ַ���evalת��Ϊpattern��ָ�����ַ���.�������쳣���쳣�˳�.
##! @AUTHOR: yangkai04@baidu.com
##! @IN: $1,�к�; 
##! @IN: $2,ģʽ��; 
##! @IN: $3,Ŀ�ı�����;
##! @OUT: 0 => success; other => failed
function eval_pat_() {
    local FN_LINENO=$1
    local FN_TARGET_PAT=$2
    local FN_TARGET=$3

    eval "${FN_TARGET}=${FN_TARGET_PAT}" >&2

    if [ $? -ne 0 ]
    then
        fatal_log_ "${FN_LINENO}" "eval \"${FN_TARGET}=${FN_TARGET_PAT}\" error." 
        err_exit_ "${FN_LINENO}"
    fi
    notice_log_ "${FN_LINENO}" "eval \"${FN_TARGET}=${FN_TARGET_PAT}\" succ. \
        ${FN_TARGET}=[${!FN_TARGET}]."
    return 0
}
alias eval_pat='eval_pat_ $LINENO'

##! @TODO: ���Ҫ���ص��ļ��Ƿ���ڣ�����������أ����������쳣�˳�.
##! @AUTHOR: yangkai04@baidu.com
##! @IN: $1,�к�; 
##! @IN: $2,��Ҫ���ص��ļ�;
##! @OUT: 0 => success; other => failed
function source_file_() {
    local FN_LINENO=$1
    local FN_TARGET=$2
    if [ ! -f "${FN_TARGET}" ]
    then
        fatal_log_ "${FN_LINENO}" "file[${FN_TARGET}] not exist."
        err_exit_ "${FN_LINENO}"
    fi
    source "${FN_TARGET}"
    if [ $? -ne 0 ]
    then
        fatal_log_ "${FN_LINENO}" "source file[${FN_TARGET}] error."
        err_exit_ "${FN_LINENO}"
    fi
    return 0
}
alias source_file='source_file_ $LINENO'

##! @TODO: ftpץȡ�ļ���ָ��·����.���쳣���˳�.
##! @AUTHOR: yangkai04@baidu.com
##! @IN: $1,�к�; 
##! @IN: $2,Դ�ļ�·��; 
##! @IN: $3,Ŀ���ļ���;
##! @OUT: 0 => success; other => failed
function wget_file_() {
    local FN_LINENO=$1
    local FN_SOURCE=$2
    local FN_TARGET=$3
    check_file_path_ "${FN_LINENO}" "${FN_TARGET}"
    if [ -f "${FN_TARGET}" ]
    then
        rm -f ${FN_TARGET} >&2
        if [ $? -ne 0 ]
        then
            fatal_log_ "${FN_LINENO}" "rm -f ${FN_TARGET} error."
            err_exit_ "${FN_LINENO}"
        fi
    fi
    wget ${FN_SOURCE} -O ${FN_TARGET} >>${LOG_FILE} 2>&1
    if [ $? -ne 0 ]
    then
        fatal_log_ "${FN_LINENO}" "wget ${FN_SOURCE} -O ${FN_TARGET} error."
        err_exit_ "${FN_LINENO}"
    fi
    return 0
}
alias wget_file='wget_file_ $LINENO'

##! @TODO: ftpץȡ�ļ���ָ��·����,������md5У��.���쳣���˳�.
##! @AUTHOR: yangkai04@baidu.com
##! @IN: $1,�к�; 
##! @IN: $2,Դ�ļ�·��; 
##! @IN: $3,Ŀ���ļ���;
##! @OUT: 0 => success; other => failed
function wget_file_withmd5_() {
    local FN_LINENO=$1
    local FN_SOURCE=$2
    local FN_TARGET=$3
    wget_file_ "${FN_LINENO}" "${FN_SOURCE}" "${FN_TARGET}"
    wget_file_ "${FN_LINENO}" "${FN_SOURCE}.md5" "${FN_TARGET}.md5"
    local FN_MD5ADD=`md5sum ${FN_TARGET} | awk '{print $1}'`
    local FN_MD5OLD=`head -n 1 ${FN_TARGET}.md5 | awk '{print $1}'`
    if [ "${FN_MD5ADD}" != "${FN_MD5OLD}" ]
    then
        fatal_log_ "${FN_LINENO}" "${FN_MD5ADD} != ${FN_MD5OLD} error."
        err_exit_ "${FN_LINENO}"
    fi
    return 0
}
alias wget_file_withmd5='wget_file_withmd5_ $LINENO'

##! @TODO: ftpץȡ�����ļ���ָ��·����.���쳣���˳�.
##! @AUTHOR: yangkai04@baidu.com
##! @IN: $1,�к�; 
##! @IN: $2,Դ�ļ�·��; 
##! @IN: $3,Ŀ��·��;
##! @OUT: 0 => success; other => failed
function wget_files_() {
    local FN_LINENO=$1
    local FN_SOURCE=$2
    local FN_TARGET=$3
    if [ -z "${FN_TARGET}" ]
    then
        fatal_log_ "${FN_LINENO}" "FN_TARGET be null error."
        err_exit_ "${FN_LINENO}"
    fi
    check_path_ "${FN_LINENO}" "${FN_TARGET}"
    wget ${FN_SOURCE} -c -P ${FN_TARGET}/ >>${LOG_FILE} 2>&1
    if [ $? -ne 0 ]
    then
        fatal_log_ "${FN_LINENO}" "wget ${FN_SOURCE} -P ${FN_TARGET} error."
        err_exit_ "${FN_LINENO}"
    fi
    return 0
}
alias wget_files='wget_files_ $LINENO'

##! @TODO: ���ͱ����ʼ�
##! @AUTHOR: yangkai04@baidu.com
##! @IN: $1,�ʼ�����; 
##! @OUT: 0 => success; other => failed
function mail_() {
    local FN_MSG=$1
    if [ ! -z "${MAIL_LIST}" ]
    then
        echo "RT" | mail -s "[${FN_MSG}]`hostname`:`pwd`/$0 " "${MAIL_LIST}"
    fi
    return 0
}

##! @TODO: ���ͱ�������
##! @AUTHOR: yangkai04@baidu.com
##! @IN: $1,��������; 
##! @OUT: 0 => success; other => failed
function alert_() {
    local FN_MSG=$1
    if [ ! -z "${PHONE_LIST}" ]
    then
        local FN_GSMSEND_CONF="-s emp01.baidu.com:15003 -s emp02.baidu.com:15003"
        gsmsend ${FN_GSMSEND_CONF} ${PHONE_LIST}@"[${FN_MSG}]`hostname`:`pwd`/$0"
    fi
    return 0
}

##! @TODO: �쳣�˳�����log.
##! @AUTHOR: yangkai04@baidu.com
##! @IN: $1,�к�; 
##! @IN: $2,�Ƿ�ɾ��running�ļ����������1���ʾɾ��
##! @OUT: 0 => success; other => failed
function err_exit_() {
    local FN_LINENO=$1
    local FN_DEL_FLAG=$2
    if [ -z "${FN_DEL_FLAG}" -o "${FN_DEL_FLAG}" != "1" ]
    then
        delete_running_file_ "${FN_LINENO}"
    fi
    notice_log_ "${FN_LINENO}" "PROGRAM ERROR EXIT."
    mail_ "PROGRAM ERROR EXIT"
    alert_ "PROGRAM ERROR EXIT"
    exit 1
}
alias err_exit='err_exit_ $LINENO'

##! @TODO: ���hdfs�ļ��Ƿ����.�����������쳣�˳�.
##! @AUTHOR: yangkai04@baidu.com
##! @IN: $1,�к�; 
##! @IN: $2,Ҫ�����ļ�·��;
##! @OUT: 0 => success; other => failed
function check_hdfs_file_() {
    local FN_LINENO=$1
    local FN_FILE=$2
    `${HADOOP_BINPATH} fs -test -e ${FN_FILE} >> "${LOG_FILE}" 2>&1`
    if [ $? -ne 0 ]
    then
        fatal_log_ "${FN_LINENO}" "file[${FN_FILE}] is not exist."
        err_exit_ "${FN_LINENO}"
    fi
    return 0
}
alias check_hdfs_file='check_hdfs_file_ $LINENO'

##! @TODO: ���hdfs�ļ��Ƿ����.���������򷵻�0.��������ɾ��.
##! @AUTHOR: yangkai04@baidu.com
##! @IN: $1,�к�; 
##! @IN: $2,Ҫ�����ļ�·��;
##! @OUT: 0 => success; other => failed
function del_hdfs_file_() {
    local FN_LINENO=$1
    local FN_FILE=$2
    `${HADOOP_BINPATH} fs -test -e ${FN_FILE} >> "${LOG_FILE}" 2>&1`
    if [ $? -eq 0 ]
    then
        notice_log_ "${FN_LINENO}" "file[${FN_FILE}] exist. delete it."
        `${HADOOP_BINPATH} fs -rmr ${FN_FILE} >> "${LOG_FILE}" 2>&1`
        if [ $? -ne 0 ]
        then
            fatal_log_ "${FN_LINENO}" "${HADOOP_BINPATH} fs -rmr ${FN_FILE} error."
            err_exit_ "${FN_LINENO}"
        fi
    fi
    return 0
}
alias del_hdfs_file='del_hdfs_file_ $LINENO'

##! @TODO: ���hdfs·���Ƿ����.���������򷵻�0.��������ɾ��.
##! @AUTHOR: yangkai04@baidu.com
##! @IN: $1,�к�; 
##! @IN: $2,Ҫ����·��;
##! @OUT: 0 => success; other => failed
alias del_hdfs_path='del_hdfs_file_ $LINENO'

##! @TODO: ���hdfs·���Ƿ����.���������򴴽�.���쳣���˳�.
##! @AUTHOR: yangkai04@baidu.com
##! @IN: $1,�к�; 
##! @IN: $2,Ҫ����·��;
##! @OUT: 0 => success; other => failed
function check_hdfs_path_() {
    local FN_LINENO=$1
    local FN_PATH=$2

    `${HADOOP_BINPATH} fs -test -d ${FN_PATH} >> "${LOG_FILE}" 2>&1`
    if [ $? -ne 0 ]
    then
        notice_log_ "${FN_LINENO}" "${HADOOP_BINPATH} fs -mkdir ${FN_PATH}"
        `${HADOOP_BINPATH} fs -mkdir ${FN_PATH} >> "${LOG_FILE}" 2>&1`
        if [ $? -ne 0 ]
        then
            fatal_log_ "${FN_LINENO}" "${HADOOP_BINPATH} fs -mkdir ${FN_PATH} error." 
            err_exit_ "${FN_LINENO}"
        fi
    fi
    return 0
}
alias check_hdfs_path='check_hdfs_path_ $LINENO'

##! @TODO: ��һ���ļ�put��hdfs��,��֮ǰ����ͬ���ļ���ɾ��֮ǰ��.���쳣���˳�.
##! @AUTHOR: yangkai04@baidu.com
##! @IN: $1,�к�; 
##! @IN: $2,����Դ�ļ�·��; 
##! @IN: $3,hdfsĿ���ļ���;
##! @OUT: 0 => success; other => failed
function put_file_to_hdfs_() {
    local FN_LINENO=$1
    local FN_SOURCE=$2
    local FN_TARGET=$3
    local FN_PATH="${FN_TARGET%/*}"
    check_hdfs_path_ "${FN_LINENO}" "${FN_PATH}"
    del_hdfs_file_ "${FN_LINENO}" "${FN_TARGET}"
    `${HADOOP_BINPATH} fs -put ${FN_SOURCE} ${FN_TARGET} >> "${LOG_FILE}" 2>&1`
    if [ $? -ne 0 ]
    then
        fatal_log_ "${FN_LINENO}" "${HADOOP_BINPATH} fs -put ${FN_SOURCE} ${FN_TARGET}."
        err_exit_ "${FN_LINENO}"
    fi
    return 0
}
alias put_file_to_hdfs='put_file_to_hdfs_ $LINENO'

##! @TODO: ������ļ�put��hdfs��,��֮ǰ����ͬ���ļ���ɾ��֮ǰ��.���쳣���˳�.
##! @AUTHOR: yangkai04@baidu.com
##! @IN: $1,�к�; 
##! @IN: $2,����Դ�ļ�·��; 
##! @IN: $3,hdfsĿ��·��;
##! @OUT: 0 => success; other => failed
function put_files_to_hdfs_() {
    local FN_LINENO=$1
    local FN_SOURCE=$2
    local FN_TARGET=$3
    for file in `ls ${FN_SOURCE}`
    do
        local FN_TARGETPATH="${FN_TARGET}/${file##*/}"
        put_file_to_hdfs_ "${FN_LINENO}" "${file}" "${FN_TARGETPATH}"
    done 
    return 0
}
alias put_files_to_hdfs='put_files_to_hdfs_ $LINENO'

##! @TODO: �����hdfs�ļ�cat�������ļ���.���쳣���˳�.
##! @AUTHOR: yangkai04@baidu.com
##! @IN: $1,�к�; 
##! @IN: $2,hdfsԴ�ļ�·��; 
##! @IN: $3,����Ŀ��·��;
##! @OUT: 0 => success; other => failed
function cat_hdfs_files_to_localfile_() {
    local FN_LINENO=$1
    local FN_SOURCE=$2
    local FN_TARGET=$3
    check_file_path_ "${FN_LINENO}" "${FN_TARGET}"
    `${HADOOP_BINPATH} fs -cat ${FN_SOURCE} > ${FN_TARGET}`
    if [ $? -ne 0 ]
    then
        fatal_log_ "${FN_LINENO}" "${HADOOP_BINPATH} fs -put ${FN_SOURCE} ${FN_TARGET}."
        err_exit_ "${FN_LINENO}"
    fi
    return 0
}
alias cat_hdfs_files_to_localfile='cat_hdfs_files_to_localfile_ $LINENO'

function sendmail() {
    if [ -z "${MAIL_LIST}" ]
    then
        return 0
    fi
    local fn_SUBJECT=$1
    local fn_FILE=$2
    local fn_COLNAMES=$3
    local fn_DATE=$4
    local fn_TO="${MAIL_LIST}"
    local fn_FROM="yangkai04@baidu.com"
    local fn_CC=""
    local fn_COLNUM=0
    local fn_COLNAME_CONTENT=""
    for COLNAME in ${fn_COLNAMES}
    do
        ((++fn_COLNUM))
        fn_COLNAME_CONTENT="${fn_COLNAME_CONTENT}<th>${COLNAME}</th>"
    done

    :>${FUNCNAME}.temp
    cat ${fn_FILE} | while read -r line
    do
        local fn_TR=""
        local fn_COLIDX=1
        while [ ${fn_COLIDX} -le ${fn_COLNUM} ]
        do
            local fn_TD=`echo "${line}" | cut -f ${fn_COLIDX}`
            fn_TR="${fn_TR}<td class=bold>${fn_TD}</td>"
            ((++fn_COLIDX))
        done
        fn_TR="<tr>${fn_TR}</tr>"
        echo "${fn_TR}" >> ${FUNCNAME}.temp
    done

    local fn_MAIL_CONTENT=`cat ${FUNCNAME}.temp`
    rm -f ${FUNCNAME}.temp
    fn_SUBJECT="${fn_SUBJECT}��${fn_DATE}��"
    local fn_MESSAGE="
    <html>
        <head>
            <meta http-equiv='Content-Type' content='text/html; charset=gb2312'/>
            <title>${fn_SUBJECT}</title>
            <style>
                body {
                    font-family: '����','Arial';
                    font-size: 12px;
                    text-align: center
                }
                table{
                    border-collapse: collapse;
                    border: 1px solid #000000;
                }
                td,th{
                <!--    width: 50%;-->
                    border-collapse: collapse;
                    border: 1px solid #000000;
                }
                th {
                    font-family:Microsoft YaHei;
                    font-size:11pt;
                    padding:0px;
                    background: blue;
                }
                td {
                    font-family:Microsoft YaHei;
                    font-size:11pt;
                    padding:0px;
                    background: lightcyan;
                }
                .red {
                    color: red;
                }
                .blue {
                    color: blue;
                }
                .bold {
                    font-weight: bold;
                }
                .gray {
                    color: '#999';
                }
            </style>
        </head>
        <body>
        <div id='name' align='center'><strong><SPAN lang='EN-US'><font face='΢���ź�, ����' size='4'>${fn_SUBJECT}</font></SPAN></strong></div>
            <table width='90%'>
                <thead>
                    <tr>
                    ${fn_COLNAME_CONTENT}
                    </tr>
                </thead>
                <tbody>
                ${fn_MAIL_CONTENT}
                </tbody>
            </table>

            <br />
            <hr />
            �����ʼ���������������ֱ�ӻظ��ʼ�
            <br />
            <span class='gray'>From: һվʽ�Ʒ��Ŷ� ${fn_FROM}</span>
        </body>
    </html>"
    echo "${fn_MESSAGE}" | mail -c "${fn_CC}" -s"$(echo -e "${fn_SUBJECT}\nContent-Type:text/html")" "${fn_TO}" -- -f "${fn_FROM}"
    echo "${FUNCNAME} ok."
}

