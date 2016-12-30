#!/bin/bash

##! @TODO: 运行框架
##! @VERSION: 1.0.0.0
##! @AUTHOR: yangkai04@baidu.com

source ~/.bash_profile
# 强制管道命令出错退出
set -o pipefail

PID=$$
SHELL_NAME="${0%.*}"
VERSION="${SHELL_NAME}_1.0.0.0"
CONF_PATH="../conf/conf_${SHELL_NAME}.sh"
FUNC_PATH="./common_func.sh"
DATA_DAY=`date +"%Y%m%d"`
TRACK="./track.log"
rm -f ${TRACK}

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
    check_conf_item "INPUT_FILE"
    check_file_path "${INPUT_FILE}"
    check_conf_item "OUTPUT_DIR"
    init_track
    notice_log "${FUNCNAME} finished."
    return 0
}

##! @TODO: 处理函数
##! @AUTHOR: yangkai04@baidu.com
##! @OUT: 0 => success; other => failed

function step_genlist()
{
    notice_log "${FUNCNAME} start."
    if [ $? -ne 0 ]
    then
        fatal_log "${FUNCNAME} error."
        return 1
    fi

    awk 'BEGIN {
        FS = OFS = "\t";
    } 
    function get_dbid_5858(l_userid) {
        l_userid1 = l_userid;
        l_userid2 = l_userid;
        return or(rshift(and(l_userid1,768),6),and(l_userid2,3));
    }
    function get_dbid_5959(l_userid) {
        return and(rshift(l_userid, 10), 15);
    }
    function get_tbid(l_userid) {
        return l_userid % 512;
    }
    # 2015-09-10 00:00:00
    function get_time_int(l_date) {
        gsub("-", " ", l_date);
        gsub(":", " ", l_date);
        l_time = mktime(l_date);
        return l_time;
    }
    {
        userid = $1;
        start = $2" 00:00:00";
        start_mon = substr($2, 6, 2);
        start_year = substr($2, 1, 4);
        start_time = get_time_int(start);
        end = $3" 23:59:59";
        end_mon = substr($3, 6, 2);
        end_year = substr($3, 1, 4);
        end_time = get_time_int(end);
        if (start_mon != end_mon) {
            next;
        }
        if (start_year != end_year) {
            next;
        }
        dbid = get_dbid_5959(userid);
        tbid = get_tbid(userid);
	if (start_mon < "05") {
            next;
	}
        # optlog201512_75
        tbname = "optlog"start_year""start_mon"_"tbid;
	printf("%s\t%d\t\"select userid,optcontext,oldvalue,newvalue from %s where userid=%s and opttime >= %s and opttime <= %s;\"\n", userid, dbid, tbname, userid, start_time, end_time);
    } END {
    }' ${INPUT_FILE} > ${MID_FILE_LIST}
    step_info=""
    notice_log "${FUNCNAME} step_info[${step_info}]"
    notice_log "${FUNCNAME} finished."
    return 0
}

function step_gensql()
{
    notice_log "${FUNCNAME} start."
    if [ $? -ne 0 ]
    then
        fatal_log "${FUNCNAME} error."
        return 1
    fi
    :>${MID_FILE_SQL}
    cat ${MID_FILE_LIST} | while read -r line 
    do 
        userid=`echo "${line}" | cut -f 1` 
        dbid=`echo "${line}" | cut -f 2` 
        sql=`echo "${line}" | cut -f 3` 
	host=${host[${dbid}]}
	port=${port[${dbid}]}
	eval_pat "${MYSQL_PATH_PAT}" "MYSQL_PATH"
	exe_sql="${MYSQL_PATH} -e${sql}"
	echo ${exe_sql} >> ${MID_FILE_SQL}
    done
    step_info=""
    notice_log "${FUNCNAME} step_info[${step_info}]"
    notice_log "${FUNCNAME} finished."
    return 0
}

function step_runsql()
{
    notice_log "${FUNCNAME} start."
    if [ $? -ne 0 ]
    then
        fatal_log "${FUNCNAME} error."
        return 1
    fi
    rm -rf "${OUTPUT_DIR}"
    check_path "${OUTPUT_DIR}"
    num=0
    cat ${MID_FILE_SQL} | while read -r line 
    do 
        ((++num))
	fname="${OUTPUT_DIR}/${num}"
	line="${line} >> ${fname}"
	echo ${line} 
    	eval ${line}
        if [ $? -ne 0 ]
        then
            fatal_log "${line} run error."
        fi
    done
    step_info=""
    notice_log "${FUNCNAME} step_info[${step_info}]"
    notice_log "${FUNCNAME} finished."
    return 0
}

##! @TODO: 运行所有处理函数
##! @AUTHOR: yangkai04@baidu.com
##! @OUT: 0 => success; other => failed
function run_all_step()
{
    notice_log "start to ${FUNCNAME}."
    local FN_ALL_STEPS="
	step_genlist 
        step_gensql 
	step_runsql" 
    for step in ${FN_ALL_STEPS}
    do
        local FN_START_TIME=`date +"%s"`
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
        local FN_END_TIME=`date +"%s"`
        local FN_RUN_TIME=`expr ${FN_END_TIME} - ${FN_START_TIME}`
    done
    notice_log "succ to ${FUNCNAME}. run time[${FN_RUN_TIME}]"
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

