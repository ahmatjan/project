#!/bin/bash

##! @TODO: 运行框架
##! @VERSION: 1.0.0.0
##! @AUTHOR: yangkai04@baidu.com

# 强制管道命令出错退出
set -o pipefail

PID=$$
SHELL_NAME="${0%.*}"
VERSION="${SHELL_NAME}_1.0.0.0"
CONF_PATH="../conf/conf_${SHELL_NAME}.sh"
FUNC_PATH="./common_func.sh"
DATA_DAY=`date +"%Y%m%d"`
TRACK="./track.log"

##! @TODO: 打印帮助信息.
##! @AUTHOR: yangkai04@baidu.com
##! @OUT: 0 => success; other => failed
function print_help()
{
    echo -e "Usage: $0" >&2
    echo -e "    -c  config file path" >&2
    echo -e "    -h  print help message" >&2
    echo -e "    -v  print the version" >&2
    echo -e "    -t  set the run_time of program" >&2
    echo -e "        format is YYYYmmdd" >&2
    echo -e "        if it's null, default is current time" >&2
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
    while getopts hvc:t: OPTION
    do
        case "${OPTION}" in
            h) print_help
            exit 0
            ;;
            v) print_version
            exit 0
            ;;
            # 设置程序运行配置文件
            c) CONF_PATH="${OPTARG}"
            ;;
            # 设置程序运行时间戳。格式为 : 20120321
            t) DATA_DAY="${OPTARG}"
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

##! @TODO: 检查并创建track文件
##! @AUTHOR: yangkai04@baidu.com
##! @OUT: 0 => success; other => failed
function init_track()
{
    if [ ! -z "${TRACK}" ]
    then
        check_file_path "${TRACK}"
        touch ${TRACK}
    fi
    return 0
}

##! @TODO: 检查track文件中是否存在
##! @AUTHOR: yangkai04@baidu.com
##! @OUT: 0 => not exist; other => exist
function check_track()
{
    local FN_STR=$1
    if [ ! -z "${TRACK}" -a -f ${TRACK} ]
    then
        grep "${FN_STR}" ${TRACK}
        if [ $? -eq 0 ]
        then
            return 1
        else
            return 0
        fi
    fi
    return 0
}

##! @TODO: 加载配置文件并检查所需配置项，创建路径等.若异常则退出.
##! @AUTHOR: yangkai04@baidu.com
##! @OUT: 0 => success; other => failed
function init_conf()
{
    source_file "${CONF_PATH}"
    check_conf_item "LOG_FILE"
    check_file_path ${LOG_FILE}
    check_conf_item "MAIL_LIST"
    init_track
    notice_log "${FUNCNAME} finished."
    return 0
}

##! @TODO: 处理函数
##! @AUTHOR: yangkai04@baidu.com
##! @OUT: 0 => success; other => failed
function step1()
{
    notice_log "${FUNCNAME} start."
    notice_log "${FUNCNAME} finished."
    return 0
}

function step2()
{
    notice_log "${FUNCNAME} start."
    notice_log "${FUNCNAME} finished."
    return 0
}

##! @TODO: 运行所有处理函数
##! @AUTHOR: yangkai04@baidu.com
##! @OUT: 0 => success; other => failed
function run_all_step()
{
    notice_log "start to ${FUNCNAME}."
    local FN_ALL_STEP="step1 step2"
    for step in ${FN_ALL_STEP}
    do
        local FN_TRACK_MSG="${step}_${DATA_DAY}"
        check_track "${FN_TRACK_MSG}"
        if [ $? -ne 0 ]
        then
            notice_log "${FN_TRACK_MSG} already run, not to run again."
            continue
        fi
        ${step}
        if [ $? -ne 0 ]
        then
            fatal_log "${FN_TRACK_MSG} run error."
            err_exit
        else
            echo -e "${FN_TRACK_MSG}" >> ${TRACK}
        fi
    done
    notice_log "succ to ${FUNCNAME}."
    return 0
}

##! @TODO: 程序入口.
##! @AUTHOR: yangkai04@baidu.com
##! @OUT: 0 => success; other => failed
function frame_main()
{
    get_option "$@"
    echo ${DATA_DAY}
    init_conf
    notice_log "PROGRAM BEGIN."
    check_running_file
    run_all_step
    delete_running_file
    notice_log "PROGRAM END."
    return 0
}

frame_main "$@"
exit $?

