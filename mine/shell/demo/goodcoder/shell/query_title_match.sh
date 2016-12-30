#!/bin/bash

##! @TODO: query-title匹配
##! @VERSION: 1.0.0.0
##! @AUTHOR: yangkai04@baidu.com

# 强制管道命令出错退出
set -o pipefail

PID=$$
SHELL_NAME="${0%%.*}"
VERSION="${SHELL_NAME}_1.0.0.0"
CONF_PATH="../conf/conf_${SHELL_NAME}.sh"
FUNC_PATH="./common_func.sh"
# 单测开关，0或不配表示正常模式；非0表示单测模式
UNITTEST=0

##! @TODO: 打印帮助信息.
##! @AUTHOR: yangkai04@baidu.com
##! @OUT: 0 => success; other => failed
function print_help()
{
    echo -e "Usage: $0" >&2
    echo -e "    -c  config file path" >&2
    echo -e "    -h  print help message" >&2
    echo -e "    -v  print the version" >&2
    echo -e "    -t  unittest the map reduce" >&2
    return 0
}

##! @TODO: 打印版本号.
##! @AUTHOR: yangkai04@baidu.com
##! @OUT: 0 => success; other => failed
function print_version()
{
    echo -e "${VERSION}" >&2
    return 0
}

##! @TODO: 处理输入参数.
##! @AUTHOR: yangkai04@baidu.com
##! @OUT: 0 => success; other => failed
function get_option()
{
    while getopts c:hvt option
    do
        case "${option}" in
            c) export CONF_PATH="${optarg}"
            ;;
            h) print_help
            exit 0
            ;;
            v) print_version
            exit 0
            ;;
            t) export UNITTEST=1
            ;;
            *) print_help
            exit 1
            ;;
        esac
    done
    return 0
}

##! @TODO: 检查要加载的文件是否存在，若存在则加载，不存在则异常退出.
##! @AUTHOR: yangkai04@baidu.com
##! @IN: $1,需要加载的文件;
##! @OUT: 0 => success; other => failed
function source_file()
{
    local fn_TARGET=$1
    if [ ! -f "${fn_TARGET}" ]
    then
        echo -e "file[${fn_TARGET}] not exist." >&2
        exit 1
    fi
    source "${fn_TARGET}" >&2
    if [ $? -ne 0 ]
    then
        echo -e "source file[${fn_TARGET}] error." >&2
        exit 1
    fi
    return 0
}
source_file "${FUNC_PATH}"

##! @TODO: 加载配置文件并检查所需配置项，创建路径等.若异常则退出.
##! @AUTHOR: yangkai04@baidu.com
##! @OUT: 0 => success; other => failed
function init_conf()
{
    source_file "${CONF_PATH}"
    check_conf_item "LOG_FILE"
    check_file_path ${LOG_FILE}
    check_conf_item "MAIL_LIST"
    check_conf_item "LOCAL_ROOT"
    check_conf_item "HADOOP_ROOT"
    notice_log "start to ${FUNCNAME}..."
    check_conf_item "HADOOP_BINPATH"
    check_bin "${HADOOP_BINPATH}" 
    check_conf_item "SEGWORD_BINPATH"
    check_bin "${SEGWORD_BINPATH}" 
    check_conf_item "PUNCWORDS_PATH"
    check_file "${PUNCWORDS_PATH}"
    check_conf_item "WORDDICT_PATH"
    check_file "${WORDDICT_PATH}"
    check_conf_item "HADOOP_WORDDICT_PATH"
    
    check_conf_item "URL_TITLE_PATH"
    check_conf_item "LOCAL_URL_TITLE_PATH"
    check_conf_item "HADOOP_URL_TITLE_PATH"
    check_conf_item "QUERY_LIST_PATH"
    check_conf_item "QUERY_LIST_NAME"
    check_conf_item "QUERY_LIST_MD5"
    check_conf_item "LOCAL_QUERY_LIST_PATHNAME"
    check_conf_item "LOCAL_QUERY_LIST_PATHNAME_GBK"
    check_conf_item "LOCAL_QUERY_LIST_PATHNAME_SEG"
    check_conf_item "OUTPUT_DATA_PATH"
    check_file_path "${OUTPUT_DATA_PATH}"
    check_conf_item "HADOOP_OUTPUT_DATA_PATH"
    check_conf_item "MAP_CAPCITY"
    check_conf_item "REDUCE_CAPCITY"
    check_conf_item "JOB_PRIORITY"
    check_conf_item "JOB_GROUPS"
    notice_log "succ to ${FUNCNAME}."
    return 0
}

##! @TODO: 获取远程url_title和query_list文件到本地.若异常则退出.
##! @AUTHOR: yangkai04@baidu.com
##! @OUT: 0 => success; other => failed
function prepare_files()
{
    notice_log "start to ${FUNCNAME}..."
    wget_files "${URL_TITLE_PATH}" "${LOCAL_URL_TITLE_PATH}"
    
    local QUERY_LIST_PATHNAME="${QUERY_LIST_PATH}/${QUERY_LIST_NAME}"
    wget_file_withmd5 "${QUERY_LIST_PATHNAME}" "${LOCAL_QUERY_LIST_PATHNAME}"
    utf8_to_gbk "${LOCAL_QUERY_LIST_PATHNAME}" "${LOCAL_QUERY_LIST_PATHNAME_GBK}"
    query_segword "${LOCAL_QUERY_LIST_PATHNAME_GBK}" "${LOCAL_QUERY_LIST_PATHNAME_SEG}"
    notice_log "succ to ${FUNCNAME}."
    return 0
}

##! @TODO: 将url_title文件和词典上传到hadoop.若异常则退出.
##! @AUTHOR: yangkai04@baidu.com
##! @OUT: 0 => success; other => failed
function init_hadoop()
{
    notice_log "start to ${FUNCNAME}..."
    put_files_to_hdfs "${LOCAL_URL_TITLE_PATH}/*" "${HADOOP_URL_TITLE_PATH}"
    put_file_to_hdfs "${WORDDICT_PATH}" "${HADOOP_WORDDICT_PATH}" 
    del_hdfs_path "${HADOOP_OUTPUT_DATA_PATH}"
    notice_log "succ to ${FUNCNAME}."
    return 0
}

##! @TODO: 启动并执行hadoop任务.若异常则退出.
##! @AUTHOR: yangkai04@baidu.com
##! @OUT: 0 => success; other => failed
function run_hadoop()
{
    notice_log "start to ${FUNCNAME}..."
    `${HADOOP_BINPATH} streaming \
    -jobconf mapred.job.name="${SHELL_NAME}" \
    -jobconf mapred.job.priority=${JOB_PRIORITY} \
    -jobconf mapred.job.groups=${JOB_GROUPS} \
    -jobconf mapred.job.map.capacity=${MAP_CAPCITY} \
    -jobconf mapred.job.reduce.capacity=${REDUCE_CAPCITY} \
    -partitioner org.apache.hadoop.mapred.lib.KeyFieldBasedPartitioner \
    -jobconf num.key.fields.for.partition=1 \
    -jobconf stream.num.map.output.key.fields=1 \
    -input "${HADOOP_URL_TITLE_PATH}/*" \
    -output "${HADOOP_OUTPUT_DATA_PATH}" \
    -mapper "./mapper.sh" \
    -reducer "./reducer.sh" \
    -file "./mapper.sh" \
    -file "./reducer.sh" \
    -file "${SEGWORD_BINPATH}" \
    -file "${PUNCWORDS_PATH}" \
    -file "${LOCAL_QUERY_LIST_PATHNAME_SEG}" \
    -cacheArchive "${HADOOP_WORDDICT_PATH}#worddict" >> "${LOG_FILE}" 2>&1`
    if [ $? -ne 0 ]
    then
        fatal_log "${FUNCNAME} error."
        err_exit
    fi
    notice_log "succ to ${FUNCNAME}."
    return 0
}

##! @TODO: 获取最终的结果到本地.若异常则退出.
##! @AUTHOR: yangkai04@baidu.com
##! @OUT: 0 => success; other => failed
function get_result()
{
    notice_log "start to ${FUNCNAME}..."
    cat_hdfs_files_to_localfile "${HADOOP_OUTPUT_DATA_PATH}/*" "${OUTPUT_DATA_PATH}.temp"
    cat ${OUTPUT_DATA_PATH}.temp | sort -T ../tmp.${PID} -k2,2 -nr | \
        head -n 100 > ${OUTPUT_DATA_PATH}
    if [ $? -ne 0 -a $? -ne 141 ]
    then
        fatal_log "${FUNCNAME} error."
        err_exit
    fi
    notice_log "succ to ${FUNCNAME}."
    return 0
}

##! @TODO: 测试hadoop任务.
##! @AUTHOR: yangkai04@baidu.com
##! @OUT: 0 => success; other => failed
function unittest_hadoop()
{
    notice_log "start to ${FUNCNAME}..."
    cat ${LOCAL_URL_TITLE_PATH}/* | head -n 10000 | sh ./mapper.sh | sort -T ../tmp.${PID} | \
        sh ./reducer.sh > ${OUTPUT_DATA_PATH}.temp
    if [ $? -ne 0 -a $? -ne 141 ]
    then
        fatal_log "${FUNCNAME} error."
        err_exit
    fi
    cat ${OUTPUT_DATA_PATH}.temp | sort -T ../tmp.${PID} -k2,2 -nr | \
        head -n 100 > ${OUTPUT_DATA_PATH}
    if [ $? -ne 0 -a $? -ne 141 ]
    then
        fatal_log "${FUNCNAME} error."
        err_exit
    fi
    notice_log "succ to ${FUNCNAME}."
    return 0
}

##! @TODO: 程序入口.
##! @AUTHOR: yangkai04@baidu.com
##! @OUT: 0 => success; other => failed
function query_match_main()
{
    get_option "$@"
    init_conf
    notice_log "PROGRAM BEGIN."
    prepare_files
    if [ -z "${UNITTEST}" -o ${UNITTEST} -eq 0 ]
    then
        init_hadoop
        run_hadoop
        get_result
    else
        unittest_hadoop
    fi
    notice_log "PROGRAM END."
    return 0
}

query_match_main "$@"
exit $?

