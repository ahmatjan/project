#!/bin/bash
#
# Copyright (c) 2015 Baidu.com, Inc. All Rights Reserved
#
# Author: yangkai04@baidu.com
# Date: 2015/11/11
# Brief:
#   A frame for running applications.
# Globals:
#   none
# Arguments:
#   -c  set config file path
#   -h  print help message
#   -v  print the version
#   -t  set the run_time of program
# Returns:
#   succ:0
#   fail:1

#set -x # set -o xtrace
#set -e # set -o errexit
#set -u # set -o nounset
set -o pipefail 

PID=$$
SHELL_NAME="${0%.*}"
VERSION="${SHELL_NAME}_1.0.0.0"
CONF_PATH="../conf/conf_${SHELL_NAME}.sh"
FUNC_PATH="../common_func.sh"
DATA_DAY=`date -d"-1 day" +"%Y%m%d"`
TRACK="./track.log"
rm -f ${TRACK}

#######################################
# Brief:
#   打印帮助信息
# Globals:
#   none
# Arguments:
#   none
# Returns:
#   succ:0
#   fail:1
#######################################
function print_help() {
    echo -e "Usage: $0" >&2
    echo -e "    -c  config file path" >&2
    echo -e "    -h  print help message" >&2
    echo -e "    -v  print the version" >&2
    echo -e "    -t  set the run_time of program" >&2
    echo -e "        format is YYYYmmdd" >&2
    echo -e "        if it's null, default is current time" >&2
    return 0
}

#######################################
# Brief:
#   打印版本号
# Globals:
#   VERSION 
# Arguments:
#   none
# Returns:
#   succ:0
#   fail:1
#######################################
function print_version() {
    echo -e "${VERSION}" >&2
    return 0
}

#######################################
# Brief:
#   处理输入参数
# Globals:
#   none
# Arguments:
#   none
# Returns:
#   succ:0
#   fail:1
#######################################
function get_option() {
    while getopts sohvc:t: OPTION; do
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

#######################################
# Brief:
#   检查要加载的文件是否存在，若存在则加载，不存在则异常退出.
# Globals:
#   none
# Arguments:
#   none
# Returns:
#   succ:0
#   fail:1
#######################################
function source_file() {
    local fn_TARGET=$1
    if [[ ! -f "${fn_TARGET}" ]]; then
        echo -e "file[${fn_TARGET}] not exist." >&2
        exit 1
    fi
    source "${fn_TARGET}" >&2
    if [[ $? -ne 0 ]]; then
        echo -e "source file[${fn_TARGET}] error." >&2
        exit 1
    fi
    return 0
}
source_file "${FUNC_PATH}"

#######################################
# Brief:
#   检查并创建track文件
# Globals:
#   none
# Arguments:
#   none
# Returns:
#   succ:0
#   fail:1
#######################################
function init_track() {
    TRACK="./track.log"
    if [[ ! -z "${TRACK}" ]]; then
        check_file_path "${TRACK}"
        touch ${TRACK}
    fi
    return 0
}

#######################################
# Brief:
#   检查track文件中是否存在
# Globals:
#   none
# Arguments:
#   none
# Returns:
#   no exist:0
#   other:1
#######################################
function check_track() {
    local FN_STR=$1
    if [[ ! -z "${TRACK}" && -f ${TRACK} ]]; then
        grep "${FN_STR}" ${TRACK}
        if [[ $? -eq 0 ]]; then
            return 1
        else
            return 0
        fi
    fi
    return 0
}

#######################################
# Brief:
#   加载配置文件并检查所需配置项，创建路径等.若异常则退出.
# Globals:
#   none
# Arguments:
#   none
# Returns:
#   succ:0
#   fail:1
#######################################
function init_conf() {
    source_file "${CONF_PATH}"
    check_conf_item "LOG_FILE"
    check_file_path ${LOG_FILE}
    check_conf_item "MAIL_LIST"
    check_conf_item "DATA_DIR"
    check_path "${DATA_DIR}"
    init_track
    notice_log "${FUNCNAME} finished."
    return 0
}

function get_step_info_() {
    local fn_FUNCNAME=$1
    local fn_FILE=$2
    STEP_END_TIME=`date +"%Y-%m-%d %H:%M:%S"`
    STEP_END_TIME_SEC=`date +"%s"`
    STEP_TIME_CONSUME=`expr ${STEP_END_TIME_SEC} - ${STEP_START_TIME_SEC}`
    local fn_FILE_WC=`wc -l ${fn_FILE} | awk '{print $1;}'`
    local fn_FILE_UV=`awk -F"\t" '{
        if (match($1, "_")!=0) {
            key=substr($1,1,match($1, "_") - 1);
        } else {
            key=$1
        } 
        dict[key]=0;
    } END {
        num=0;
        for(item in dict) {
            ++num;
        } 
        print num;}' ${fn_FILE}`
    local fn_FILE_PV=`awk -F"\t" '{
        dict[$1]=0;
    } END {
        num=0;
        for(item in dict) {
            ++num;
        } 
        print num;
    }' ${fn_FILE}`
    STEP_INFO="PID=${PID}"
    STEP_INFO="${STEP_INFO}\tSTEP_FUNCNAME=${fn_FUNCNAME}"
    STEP_INFO="${STEP_INFO}\tSTEP_START_TIME=${STEP_START_TIME}"
    STEP_INFO="${STEP_INFO}\tSTEP_END_TIME=${STEP_END_TIME}"
    STEP_INFO="${STEP_INFO}\tSTEP_TIME_CONSUME=${STEP_TIME_CONSUME}"
    STEP_INFO="${STEP_INFO}\tSTEP_FILE_NAME=${fn_FILE}"
    STEP_INFO="${STEP_INFO}\tSTEP_FILE_WC=${fn_FILE_WC}"
    STEP_INFO="${STEP_INFO}\tSTEP_FILE_UV=${fn_FILE_UV}"
    STEP_INFO="${STEP_INFO}\tSTEP_FILE_PV=${fn_FILE_PV}"
}
alias get_step_info='get_step_info_ ${FUNCNAME}'

##! @TODO: 处理函数
##! @AUTHOR: yangkai04@baidu.com
##! @OUT: 0 => success; other => failed

function step_get_login_result() {
    grep "param_0\[type\]=.&param_0\[loginappid\]=" ${MID_FILES_INPUT} > \
        "${MID_FILE_LOGIN_RESULT_ORG}"
    if [[ $? -ne 0 ]]; then
        fatal_log "${FUNCNAME} error."
        return 1
    fi

    get_step_info "${MID_FILE_LOGIN_RESULT_ORG}"
    notice_log "${FUNCNAME} step_info[${STEP_INFO}]"
    return 0
}

function step_login_result_2gbk() {
    utf8_to_gbk "${MID_FILE_LOGIN_RESULT_ORG}" "${MID_FILE_LOGIN_RESULT_GBK}"
    if [[ $? -ne 0 ]]; then
        fatal_log "${FUNCNAME} error."
        return 1
    fi

    get_step_info "${MID_FILE_LOGIN_RESULT_GBK}"
    notice_log "${FUNCNAME} step_info[${STEP_INFO}]"
    return 0
}

function step_login_result_format() {
    cat ${MID_FILE_LOGIN_RESULT_GBK} | awk 'BEGIN {
        FS = OFS = "\t";
        # fields = "type errcode entername enterpwd issafe devicecode time ip 
        # logintypeid loginappid clientid tgc castk ucid regappid utype ruleid 
        # machine logid log_time log_ip u";
        fields = "type errcode loginappid logintypeid clientid ucid entername \
            enterpwd log_time time log_ip ip tgc castk regappid utype ruleid \
            machine logid issafe devicecode rp u";
    } 
    function get_logid() {
        # -:1492343197505902592:8
        N = split($3, array, ":");
        return array[2];
    }
    function get_machine() {
        # /home/disk1/var/uc_login2/20160308/cq01-dr-uclogin100.cq01/
        # uc-login2/uclogin2.log.00:-
        N = split($1, array, "/");
        return array[7];
    }
    function parse_array() {
        # param_0[type]=2&param_0[loginappid]=3&param_0[logintypeid]=1&
        # param_0[entername]=bj-chinacir&param_0[enterpwd]=
        # 54eb423767ddab0549f5c6e996896513&param_0[ip]=114.249.134.59&
        # param_0[clientid]=0&param_0[devicecode]=&param_0[time]=1457366411&
        # param_0[errcode]=131&rp=2
        N = split($7, array, "&");
        for (term_idx = 1; term_idx <= N; term_idx++) {
            # param_0[type]=2
            term = array[term_idx];
            if (match(term, "param_0.*=.*") <=0 && match(term, "rp=.*") <=0) {
                continue;
            }
            gsub(/param_0\[/, "", term);
            gsub("]", "", term);
            M = split(term, term_array, "=");
            if (M < 2) {
                continue;
            }
            key = term_array[1];
            value = term_array[2];
            dict[key] = value;
            dict_keys[key] = 0;
        }
        str = "";
        for (key in dict) {
            term = key"="dict[key];
            if (str == "") {
                str = term;
            } else {
                str = str"\t"term;
            }
        }
        return str;
    }
    function fetch_item(key_name) {
        if (key_name in dict) {
            return dict[key_name];
        }
        return "no_exist";
    }
    function build_line() {
        N = split(fields, field_array, " ");
        str = "";
        for (field_idx = 1; field_idx <= N; ++field_idx) {
            if (str == "") {
                str = field_array[field_idx]"="
                    fetch_item(field_array[field_idx]);
                #str = fetch_item(field_array[field_idx]);
            } else {
                str = str"\t"field_array[field_idx]"="
                    fetch_item(field_array[field_idx]);
                #str = str"\t"fetch_item(field_array[field_idx]);
            }
        }
        return str;
    }
    {
        delete dict;
        dict["machine"] = get_machine();
        dict["logid"] = get_logid();
        dict["log_time"] = $4;
        dict["log_ip"] = $5;
        parse_array();
        print build_line();
    } END {
        N = split(fields, field_array, " ");
        str = "";
        for (field_idx = 1; field_idx <= N; ++field_idx) {
            dict_keys[field_array[field_idx]] = 1;
            if (str == "") {
                str = field_idx":"field_array[field_idx];
            } else {
                str = str"\n"field_idx":"field_array[field_idx];
            }
        }
        print str > "'${MID_FILE_LOGIN_RESULT_FORMAT}'.fields";
        print "" >> "'${MID_FILE_LOGIN_RESULT_FORMAT}'.fields";
        print "" >> "'${MID_FILE_LOGIN_RESULT_FORMAT}'.fields";
        for (key in dict_keys) {
            if (dict_keys[key] == 0) {
                print "no output key : "key >> \
                    "'${MID_FILE_LOGIN_RESULT_FORMAT}'.fields";
            }
        }
    }' > ${MID_FILE_LOGIN_RESULT_FORMAT}

    if [[ $? -ne 0 ]]; then
        fatal_log "${FUNCNAME} error."
        return 1
    fi

    awk 'BEGIN {
        FS = OFS = "\t";
    } 
    function get_value(kvpair) {
        N = split(kvpair, array, "=");
        return array[2];
    }
    {
        str = "";
        for (idx = 1; idx <= NF; idx++) {
            if (str == "") {
                str = get_value($idx);
            } else {
                str = str"\t"get_value($idx);
            }
        }
    } END {
    }' ${MID_FILE_LOGIN_RESULT_FORMAT} > ${MID_FILE_LOGIN_RESULT_FORMAT}.values
    if [[ $? -ne 0 ]]; then
        fatal_log "${FUNCNAME} error."
        return 1
    fi

    get_step_info "${MID_FILE_LOGIN_RESULT_FORMAT}"
    notice_log "${FUNCNAME} step_info[${STEP_INFO}]"
    return 0
}

function step_login_succ_fail_stat() {
    awk 'BEGIN {
        FS = OFS = "\t";
    } 
    function get_value(kvpair) {
        N = split(kvpair, array, "=");
        return array[2];
    }
    {
	    # type=2  errcode=131     loginappid=3    logintypeid=1   clientid=0     
        # ucid=no_exist   entername=hz品逸荣轩    i
        # enterpwd=1f10129909e83f18dd8e7f2d3b29a56f       
        # log_time=2016-03-28 00:00:00    time=1459094400 log_ip=60.186.28.40 
        # ip=60.186.28.40 tgc=no_exist    castk=no_exist  regappid=no_exist   
        # utype=no_exist  ruleid=no_exist machine=cq01-dr-uclogin100.cq01 
        # logid=1494112665968434688  issafe=no_exist devicecode= rp=2 u=no_exist
        type = get_value($1);
        errcode = get_value($2);
        appid = get_value($3);
        if (type == 1) {
            dict_succ[0] ++;
            dict_succ[appid] ++;
        }
        dict_total[0] ++;
        dict_total[appid] ++;
    } END {
        for (appid in dict_total) {
            succ = 0;
            if (appid in dict_succ) {
                succ = dict_succ[appid];
            }
            printf("%d\t%d\t%d\t%0.2f\n", appid, dict_total[appid], succ, 
                    100 * succ / dict_total[appid]);
        }
    }' ${MID_FILE_LOGIN_RESULT_FORMAT} | sort -n > \
        ${MID_FILE_LOGIN_SUCC_FAIL_STAT}
    if [[ $? -ne 0 ]]; then
        fatal_log "${FUNCNAME} error."
        return 1
    fi

    get_step_info "${MID_FILE_LOGIN_SUCC_FAIL_STAT}"
    notice_log "${FUNCNAME} step_info[${STEP_INFO}]"
    return 0
}

function step_login_from_www2() {
    awk 'BEGIN {
        FS = OFS = "\t";
    } 
    function get_value(kvpair) {
        N = split(kvpair, array, "=");
        return array[2];
    }
    {
	    # type=2  errcode=131     loginappid=3    logintypeid=1   clientid=0 
        # ucid=no_exist   entername=hz品逸荣轩    
        # enterpwd=1f10129909e83f18dd8e7f2d3b29a56f       
        # log_time=2016-03-28 00:00:00    time=1459094400 log_ip=60.186.28.40 
        # ip=60.186.28.40 tgc=no_exist    castk=no_exist  regappid=no_exist   
        # utype=no_exist  ruleid=no_exist machine=cq01-dr-uclogin100.cq01 
        # logid=1494112665968434688 issafe=no_exist devicecode= rp=2 u=no_exist
        type = get_value($1);
        if (type != 1) {
		next;
	}
	loginappid=get_value($3);
	if (loginappid!=3) {
		next;
	}

	ucid = get_value($6);
        u = get_value($23);
	print ucid,u;
    } END {
    }' ${MID_FILE_LOGIN_RESULT_FORMAT} | sort -n > ${MID_FILE_LOGIN_FROM_WWW2}
    if [[ $? -ne 0 ]]; then
        fatal_log "${FUNCNAME} error."
        return 1
    fi

    get_step_info "${MID_FILE_LOGIN_FROM_WWW2}"
    notice_log "${FUNCNAME} step_info[${STEP_INFO}]"
    return 0
}
function step_login_shennong() {
    date_str=`date -d "1 day ago" "+%Y%m%d"`
    awk 'BEGIN {
        FS = OFS = "\t";
        fields = "type errcode loginappid logintypeid clientid ucid entername \
                  enterpwd log_time ip tgc castk regappid utype ruleid machine \
                  logid issafe devicecode rp u";
    } 
    function get_value(kvpair) {
        N = split(kvpair, array, "=");
        return array[2];
    }
    function get_key(kvpair) {
        N = split(kvpair, array, "=");        return array[1];    }
    {
        # type=2  errcode=131     loginappid=3    logintypeid=1   clientid=0   
        # ucid=no_exist   entername=hz品逸荣轩    
        # enterpwd=1f10129909e83f18dd8e7f2d3b29a56f       log_time=2016-03-:00
        # time=1459094400 log_ip=60.186.28.40     ip=60.186.28.40 tgc=no_exist 
        # castk=no_exist  regappid=no_exist       utype=no_exist  
        # ruleid=no_exist machine=cq01-dr-uclogin100.cq01 
        # logid=1494112665968434688 issafe=no_exist devicecode= rp=2 u=no_exist
        N = split(fields, field_array, " ");
        idx = 1;
        for ( i = 1; i <= NF; i++) {
                key = get_key($i);
                if (key == "time" || key == "log_ip") { 
                        continue;
                }
         #       print i"key:    "key"  "idx"   filed_array"field_array[idx];
                if (key == field_array[idx++]) {
                    type = get_value($i);
                } else {
                    type="no_exist";
                } 
                if (type == "") {
                    type="no_exist";
                }
                if (i == 1) {
                      str=type;
                } else {
                      str=str"\t"type;
                }
        }
        #print $0;
        print str;
     } END {
     }' ${MID_FILE_LOGIN_RESULT_FORMAT}  > \
        ${MID_FILE_LOGIN_SHENNONG}.$date_str.log
     md5sum ${MID_FILE_LOGIN_SHENNONG}.$date_str.log > \
        ${MID_FILE_LOGIN_SHENNONG}.$date_str.log.md5

}

function step_report() {
    grep "PID=${PID}" ${LOG_FILE} | sed 's/.* step_info\[\(.*\)\]\]/\1/g' > \
        ${FUNCNAME}.temp
    awk 'BEGIN {
        FS="\t";
        OFS=" ";
    }
    {
        for (i = 1; i <= NF; ++i) {
            split($i, arr, "=");
            $i = arr[1];
        }
        print $0;
    }' ${FUNCNAME}.temp > ${FUNCNAME}.colnames
    local fn_COLNAMES=`head -n 1 ${FUNCNAME}.colnames`
    awk 'BEGIN {
        FS=OFS="\t";
    }
    {
        for (i = 1; i <= NF; ++i) {
            split($i, arr, "=");
            $i = arr[2];
        }
        print $0;
    }' ${FUNCNAME}.temp > ${FUNCNAME}.contant
    local fn_CONTANT=`cat ${FUNCNAME}.contant`

    rm ${FUNCNAME}.*
 
    return 0
}

##! @TODO: 运行所有处理函数
##! @AUTHOR: yangkai04@baidu.com
##! @OUT: 0 => success; other => failed
function run_all_step() {
    notice_log "${FUNCNAME} start."
    ALL_STEPS="
        step_get_login_result
        step_login_result_2gbk
        step_login_result_format
        step_login_succ_fail_stat
        step_login_from_www2
        step_login_shennong
        step_report"

    local FN_ALL_STEPS=${ALL_STEPS}
    for step in ${FN_ALL_STEPS}; do
        STEP_START_TIME=`date +"%Y-%m-%d %H:%M:%S"`
        STEP_START_TIME_SEC=`date +"%s"`
        local FN_TRACK_MSG="${step}_${DATA_DAY}"
        check_track "${FN_TRACK_MSG}"
        if [[ $? -ne 0 ]]; then
            notice_log "${FN_TRACK_MSG} already run, not to run again."
            continue
        fi
        notice_log "${step} start."
        ${step}
        if [[ $? -ne 0 ]]; then
            fatal_log "${FN_TRACK_MSG} run error."
            err_exit
        else
            echo -e "${FN_TRACK_MSG}" >> ${TRACK}
        fi
        local FN_END_TIME_SEC=`date +"%s"`
        local FN_RUN_TIME=`expr ${FN_END_TIME_SEC} - ${STEP_START_TIME_SEC}`
        notice_log "${step} finished. run time[${FN_RUN_TIME}]"
    done
    notice_log "${FUNCNAME} finished."
    return 0
}

##! @TODO: 程序入口.
##! @AUTHOR: yangkai04@baidu.com
##! @OUT: 0 => success; other => failed
function frame_main() {
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

