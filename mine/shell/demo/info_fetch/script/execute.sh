#!/bin/bash

##! @TODO: 运行框架
##! @VERSION: 1.0.0.0
##! @AUTHOR: yangkai04@baidu.com

source ~/.bash_profile
# 强制管道命令出错退出
set -o pipefail

TYPE="opt"
PID=$$
SHELL_NAME="${0%.*}"
VERSION="${SHELL_NAME}_1.0.0.0"
CONF_PATH="../conf/conf_${SHELL_NAME}.sh"
FUNC_PATH="./common_func.sh"
DATA_DAY=`date -d"-1 day" +"%Y%m%d"`
#TRACK="./track.log"
#rm -f ${TRACK}

##! @TODO: 打印帮助信息.
##! @AUTHOR: yangkai04@baidu.com
##! @OUT: 0 => success; other => failed
function print_help() {
    echo -e "Usage: $0" >&2
    echo -e "    -s  spam model" >&2
    echo -e "    -o  opt model" >&2
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
function print_version() {
    echo -e "${VERSION}" >&2
    return 0
}

##! @TODO: 处理输入参数.
##! @AUTHOR: yangkai04@baidu.com
##! @OUT: 0 => success; other => failed
function get_option() {
    while getopts sohvc:t: OPTION
    do
        case "${OPTION}" in
            s) TYPE="spam"
            ;;
            o) TYPE="opt"
            ;;
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
function source_file() {
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
function init_track() {
    TRACK="./track_${TYPE}.log"
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
function check_track() {
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
    local fn_FILE_UV=`awk -F"\t" '{dict[substr($1,1,match($1, "_") - 1)]=0;}END{num=0;for(item in dict){++num;} print num;}' ${fn_FILE}`
    local fn_FILE_PV=`awk -F"\t" '{dict[$1]=0;}END{num=0;for(item in dict){++num;} print num;}' ${fn_FILE}`
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

function step_fetch_amends() {
    user=${amends_user}
    pass=${amends_pass}
    dbname=${amends_dbname}
    host=${amends_host}
    port=${amends_port}
    eval_pat "${MYSQL_PATH_PAT}" "MYSQL_PATH"
    sql="\"select apply_ucid,apply_starttime,apply_endtime from apply_info;\""
    exe_sql="${MYSQL_PATH} -e${sql} > ${MID_FILE_AMENDS}"
    eval ${exe_sql}
    if [ $? -ne 0 ]
    then
        fatal_log "${line} run error."
    fi

    get_step_info "${MID_FILE_AMENDS}"
    notice_log "${FUNCNAME} step_info[${STEP_INFO}]"
    return 0
}

function step_get_optlog_begindate() {
    SUB_PROCESS_ID_LIST=""
    TEMP_FIFOFILE="/tmp/$$.fifo"
    rm -f "${TEMP_FIFOFILE}" 
    mkfifo "${TEMP_FIFOFILE}" 
    PROCESS_NUM=${#optlog_host[*]}
    exec 6<>"${TEMP_FIFOFILE}"
    for((i=0;i<${PROCESS_NUM};i++))
    do
        echo
    done >&6
    idx=0
    while [ $idx -lt ${PROCESS_NUM} ]
    do
        read -u 6
        { 
            sql="\"select LEFT(table_name,12) from information_schema.tables where table_name like 'optlog2%';\""
            user=${optlog_user}
            pass=${optlog_pass}
            dbname=${optlog_dbname}
	    host=${optlog_host[${idx}]}
	    port=${optlog_port[${idx}]}
	    eval_pat "${MYSQL_PATH_PAT}" "MYSQL_PATH"
	    exe_sql="${MYSQL_PATH} -e${sql} >> ${MID_FILE_OPTLOG_TABLES}.$!"
            echo "PROCESS[$!] run[${exe_sql}]"
            eval ${exe_sql}
            if [ 0 -ne $? ] 
            then
                echo "PROCESS[$!] run error!" 
                exit 1
            fi
            sleep 1
            echo >&6
        }&
        SUB_PROCESS_ID_LIST="${SUB_PROCESS_ID_LIST} $!"
        ((idx++))
    done
    
    wait                                                                                            
    exec 6>&-

    cat ${MID_FILE_OPTLOG_TABLES}.* | sort | uniq -c > ${MID_FILE_OPTLOG_TABLES}
    rm -f ${MID_FILE_OPTLOG_TABLES}.*
    OPTLOG_START=`head -n 1 ${MID_FILE_OPTLOG_TABLES} | awk '{print $2;}'`
    OPTLOG_STARTDATE="${OPTLOG_START:6:4}-${OPTLOG_START:10:2}-01"
    echo "OPTLOG_STARTDATE=${OPTLOG_STARTDATE}" > ${MID_FILE_OPTLOG_STARTDATE}

    get_step_info "${MID_FILE_OPTLOG_STARTDATE}"
    notice_log "${FUNCNAME} step_info[${STEP_INFO}]"
    return 0
}

function step_fetch_optlog() {
    DATA_TIME_YEAR=${DATA_DAY:0:4}
    DATA_TIME_MON=${DATA_DAY:4:2}
    DATA_TIME_DAY=${DATA_DAY:6:2}
    DATA_DAY_BEGIN="${DATA_TIME_YEAR}-${DATA_TIME_MON}-${DATA_TIME_DAY} 00:00:00"
    DATA_DAY_END="${DATA_TIME_YEAR}-${DATA_TIME_MON}-${DATA_TIME_DAY} 23:59:59"
    TIME_BEGIN=`date -d"${DATA_DAY_BEGIN}" +"%s"`
    TIME_END=`date -d"${DATA_DAY_END}" +"%s"`

    SUB_PROCESS_ID_LIST=""
    TEMP_FIFOFILE="/tmp/$$.fifo"
    rm -f "${TEMP_FIFOFILE}" 
    mkfifo "${TEMP_FIFOFILE}" 
    PROCESS_NUM=${#optlog_host[*]}
    exec 6<>"${TEMP_FIFOFILE}"
    for((i=0;i<${PROCESS_NUM};i++))
    do
        echo
    done >&6
    idx=0
    while [ $idx -lt ${PROCESS_NUM} ]
    do
        read -u 6
        { 
            tbid=0
            while [ ${tbid} -lt 512 ]
            do
                tbname="optlog${DATA_TIME_YEAR}${DATA_TIME_MON}_${tbid}"
                sql="\"select userid,opttime,newvalue from ${tbname} where optcontent=13 and opttime >= ${TIME_BEGIN} and opttime <= ${TIME_END};\""
                user=${optlog_user}
                pass=${optlog_pass}
                dbname=${optlog_dbname}
	        host=${optlog_host[${idx}]}
	        port=${optlog_port[${idx}]}
	        eval_pat "${MYSQL_PATH_PAT}" "MYSQL_PATH"
	        exe_sql="${MYSQL_PATH} -e${sql} >> ${MID_FILE_WORD}.$!"
                echo "PROCESS[$!] run[${exe_sql}]"
	        eval ${exe_sql}
                if [ 0 -ne $? ] 
                then
                    echo "PROCESS[$!] run error!" 
                    exit 1
                fi
                ((++tbid))
            done
            sleep 1
            echo >&6
        }&
        SUB_PROCESS_ID_LIST="${SUB_PROCESS_ID_LIST} $!"
        ((idx++))
    done
    
    wait                                                                                            
    exec 6>&-

    mkdir ./temp
    cat ${MID_FILE_WORD}.* | sort -T ./temp  > ${MID_FILE_WORD}
    rm -rf ./temp
    rm -f ${MID_FILE_WORD}.*

    get_step_info "${MID_FILE_WORD}"
    notice_log "${FUNCNAME} step_info[${STEP_INFO}]"
    return 0
}

function step_fetch_spamlog() {
    source ${MID_FILE_OPTLOG_STARTDATE}
    if [ $? -ne 0 ]
    then
        fatal_log "${FUNCNAME} error."
        return 1
    fi

    awk 'BEGIN {
        FS = OFS = "\t";
        optlog_starttime = get_time_int("'${OPTLOG_STARTDATE}' 00:00:00");
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
    # l_cnt天以前的时间戳.格式为:2013-09-10
    function days_ago(l_date, l_cnt) {
        gsub("-", " ", l_date);
        l_time = mktime(l_date" "00" "00" 00");
        l_time = l_time - l_cnt * 86400;
        return strftime("%Y-%m-%d", l_time);
    }
    # l_cnt以后的时间戳.格式为:2013-09-10
    function days_after(l_date, l_cnt) {
        gsub("-", " ", l_date);
        l_time = mktime(l_date" "00" "00" 00");
        l_time = l_time + l_cnt * 86400;
        return strftime("%Y-%m-%d", l_time);
    }
    {
        userid = $1;
        $2 = days_ago($2, 1);
        start = $2" 00:00:00";
        start_mon = substr($2, 6, 2);
        start_year = substr($2, 1, 4);
        start_time = get_time_int(start);
        if (start_time < optlog_starttime) {
            next;
        }
        $3 = days_after($3, 1);
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
        # optlog201512_75
        tbname = "optlog"start_year""start_mon"_"tbid;
	printf("%s\t%d\t\"select userid,opttime,newvalue from %s where userid=%s and optcontent=13 and opttime >= %s and opttime <= %s;\"\n", userid, dbid, tbname, userid, start_time, end_time);
    } END {
    }' ${MID_FILE_AMENDS} > ${MID_FILE_SPAMLOG_SQL}
    if [ $? -ne 0 ]
    then
        fatal_log "${FUNCNAME} error."
        return 1
    fi

    SUB_PROCESS_ID_LIST=""
    TEMP_FIFOFILE="/tmp/$$.fifo"
    rm -f "${TEMP_FIFOFILE}" 
    mkfifo "${TEMP_FIFOFILE}" 
    PROCESS_NUM=${#optlog_host[*]}
    exec 6<>"${TEMP_FIFOFILE}"
    for((i=0;i<${PROCESS_NUM};i++))
    do
        echo
    done >&6
    idx=0
    while [ $idx -lt ${PROCESS_NUM} ]
    do
        read -u 6
        { 
            cat ${MID_FILE_SPAMLOG_SQL} | while read -r line 
            do 
                userid=`echo "${line}" | cut -f 1` 
                dbid=`echo "${line}" | cut -f 2` 
                if [ ${dbid} -ne $idx ]
                then
                    continue
                fi
                sql=`echo "${line}" | cut -f 3` 
                user=${optlog_user}
                pass=${optlog_pass}
                dbname=${optlog_dbname}
	        host=${optlog_host[${idx}]}
	        port=${optlog_port[${idx}]}
	        eval_pat "${MYSQL_PATH_PAT}" "MYSQL_PATH"
	        exe_sql="${MYSQL_PATH} -e${sql} >> ${MID_FILE_WORD}.$!"
                echo "PROCESS[$!] run[${exe_sql}]"
	        eval ${exe_sql}
                if [ 0 -ne $? ] 
                then
                    echo "PROCESS[$!] run error!" 
                    exit 1
                fi
            done
            sleep 1
            echo >&6
        }&

        SUB_PROCESS_ID_LIST="${SUB_PROCESS_ID_LIST} $!"
        ((idx++))
    done
    
    wait                                                                                            
    exec 6>&-

    cat ${MID_FILE_WORD}.* | sort > ${MID_FILE_WORD}
    rm -f ${MID_FILE_WORD}.*

    get_step_info "${MID_FILE_WORD}"
    notice_log "${FUNCNAME} step_info[${STEP_INFO}]"
    return 0
}

function step_segment() {
    awk 'BEGIN {
        FS = OFS = "\t";
        opt_num_per_second='${THRESHOLD_OPT_NUM_PER_SECOND}' + 0;
    }
    {
        userid = $1;
        time = $2;
        key = userid"\t"time;
        dict[key]++;
    }
    END {
        for (key in dict) {
            if (dict[key] >= opt_num_per_second) {
                print key, dict[key];
            }
        }
    }' ${MID_FILE_WORD} | sort >  "${MID_FILE_WORD_FILTER}"
    if [ $? -ne 0 ]
    then
        fatal_log "${FUNCNAME} error."
        return 1
    fi

    awk 'BEGIN {
        FS = OFS = "\t";
        opt_interval='${THRESHOLD_OPT_INTERVAL}' + 0;
        last_userid = 0;
        last_time = 0;
        segmentid = 0;
        while (getline <"'${MID_FILE_WORD_FILTER}'"> 0) {
            key = $1"\t"$2;
            dict[key] = $3;
        }
    }
    {
        userid = $1 + 0;
        time = $2 + 0;
        if (userid != last_userid) {
            segmentid ++;
            last_time = time;
            last_userid = userid;
        } else {
            if (time - last_time > opt_interval) {
                segmentid ++;
            }
        }

        key = userid"\t"time;
        if (key in dict) {
            print $1"_"segmentid,$2,$3;
        }
        last_time = time;
    }
    END {
    }' "${MID_FILE_WORD}" > "${MID_FILE_WORD_SEGMENT}"
    if [ $? -ne 0 ]
    then
        fatal_log "${FUNCNAME} error."
        return 1
    fi
 
    get_step_info "${MID_FILE_WORD_SEGMENT}"
    notice_log "${FUNCNAME} step_info[${STEP_INFO}]"
    return 0
}

function step_segword() {
    cd ../../tools/segword/bin
    ./segword -f segword_${TYPE}.conf
    if [ $? -ne 0 ]
    then
        cd -
        fatal_log "${FUNCNAME} error."
        return 1
    fi
    cd -
    mkdir ./temp
    sort -T ./temp ${MID_FILE_WORD_SEGWORD} > ${MID_FILE_WORD_SEGWORD}.sort
    rm -rf ./temp
    mv ${MID_FILE_WORD_SEGWORD}.sort ${MID_FILE_WORD_SEGWORD}

    get_step_info "${MID_FILE_WORD_SEGWORD}"
    notice_log "${FUNCNAME} step_info[${STEP_INFO}]"
    return 0
}

function step_feature() {
    awk 'BEGIN {
        FS = OFS = "\t";
        userid = "0";
        totalcnt = 0;
    }
    {
        if ($1 != userid) {
            if (userid != "0") {
                for (item in dict) {
                    if (dict[item] > 0) {
                        optcnt = dict[item] + 0;
                        rate = optcnt / totalcnt;
                        printf("%s\t%s\t%s\t%s\t%0.4f\n", userid, item, dict[item], totalcnt, rate);
                    }
                }
                delete dict;
            }
            userid = $1;
            totalcnt = 0;
        }
        N = split($4, term_arr, " ");
        for (idx = 1; idx <= N; ++idx) {
            dict[term_arr[idx]]++;
            ++totalcnt;
        }
    }
    END {
        if (userid != "0") {
            for (item in dict) {
                if (dict[item] > 0) {
                    optcnt = dict[item] + 0;
                    rate = optcnt / totalcnt;
                    printf("%s\t%s\t%s\t%s\t%0.4f\n", userid, item, dict[item], totalcnt, rate);
                }
            }
            delete dict;
        }
    }' ${MID_FILE_WORD_SEGWORD} | sort -t'	' -k1,1 -k3,3nr > ${MID_FILE_FEATURE}

    if [ $? -ne 0 ]
    then
        fatal_log "${FUNCNAME} error."
        return 1
    fi

    get_step_info "${MID_FILE_FEATURE}"
    notice_log "${FUNCNAME} step_info[${STEP_INFO}]"
    return 0
}

function step_feature_filter() {
    awk 'BEGIN {
        FS = OFS = "\t";
        feature_no = 0;
        while (getline<"'${FEATURE_WORD_RATE}'">0) {
            dict[feature_no] = $0;
            feature_no++;
        }
        last_userid = "0";
    }
    {
        userid = $1;
        if (userid != last_userid) {
            disposal();
            last_userid = userid;
            delete dict_term;
        }
        rate = $5 + 0.0;
        term = $2;
        dict_term[term] = rate;
    }
    function disposal() {
       if (last_userid != "0") {
            for (i = 0; i < feature_no; ++i) {
                N = split(dict[i], array, "\t")
                j = 0;
                for (j = 1; j <= N; ++j) {
                    M = split(array[j], sub_array, "|")
                    term = sub_array[1]
                    rate = sub_array[2] + 0.0
                    if (!(term in dict_term)) {
                        break;
                    }
                    if (dict_term[term] < rate) {
                        break;
                    }
                }
                if (j >= N + 1) {
                    matched_terms = dict[i];
                    gsub(matched_terms, "\t", " ");
                    dict_user[last_userid] = matched_terms;
                    break;
                }
            }
        }
    }
    END {
        disposal();
        for (userid in dict_user) {
            print userid, dict_user[userid];
        }
    }' ${MID_FILE_FEATURE} > ${MID_FILE_FEATURE_FILTER}
    if [ $? -ne 0 ]
    then
        fatal_log "${FUNCNAME} error."
        return 1
    fi

    awk 'BEGIN {
        FS = OFS = "\t";
        while (getline <"'${MID_FILE_FEATURE_FILTER}'">0) {
            dict[$1] = $0"\t";
        }
    }
    {
        if (!($1 in dict)) {
            next;
        }
        rate = $5 + 0.0;
        if (rate < 0.01) {
            next;
        }
        dict[$1] = dict[$1]" "$2;
    }
    END {
        for (item in dict) {
            print dict[item];
        }
    }' ${MID_FILE_FEATURE} | sort > ${MID_FILE_FEATURE_FILTER}.words
    if [ $? -ne 0 ]
    then
        fatal_log "${FUNCNAME} error."
        return 1
    fi

    awk 'BEGIN {
        FS = OFS = "\t";
        while (getline <"'${MID_FILE_FEATURE_FILTER}'">0) {
            dict[$1] = 0;
        }
    }
    {
        if ($1 in dict) {
            print $0;
        }
    }
    END {
    }' ${MID_FILE_FEATURE} > ${MID_FILE_FEATURE_FILTERED}
    if [ $? -ne 0 ]
    then
        fatal_log "${FUNCNAME} error."
        return 1
    fi

    get_step_info "${MID_FILE_FEATURE}"
    notice_log "${FUNCNAME} step_info[${STEP_INFO}]"
    return 0
}

function step_identity() {
    python feature_match.py -s ${MID_FILE_FEATURE_FILTERED} -i ${MID_FILE_FEATURE_FILTERED} -o ${MID_FILE_FEATURE_MATCHED}
    if [ $? -ne 0 ]
    then
        fatal_log "${FUNCNAME} error."
        return 1
    fi

    awk 'BEGIN {
        FS = OFS = "\t";
        while (getline <"'${MID_FILE_FEATURE_MATCHED}'">0) {
            dict[$1] = $1"\t";
        }
    }
    {
        if (!($1 in dict)) {
            next;
        }
        rate = $5 + 0.0;
        if (rate < 0.01) {
            next;
        }
        dict[$1] = dict[$1]" "$2;
    }
    END {
        for (item in dict) {
            print dict[item];
        }
    }' ${MID_FILE_FEATURE} | sort > ${MID_FILE_FEATURE_MATCHED}.words

    if [ $? -ne 0 ]
    then
        fatal_log "${FUNCNAME} error."
        return 1
    fi

    get_step_info "${MID_FILE_FEATURE_MATCHED}"
    notice_log "${FUNCNAME} step_info[${STEP_INFO}]"
    return 0
}

function step_match() {
    python feature_match.py
    if [ $? -ne 0 ]
    then
        fatal_log "${FUNCNAME} error."
        return 1
    fi

    awk 'BEGIN {
        FS = OFS = "\t";
        while (getline <"'${MID_FILE_FEATURE_MATCHED}'">0) {
            dict[$1] = substr($1,1,match($1, "_") - 1)"\t";
        }
        while (getline <"'${MID_FILE_WORD_SEGMENT}'">0) {
            if (!($1 in dict_time)) {
                dict_time[$1] = strftime("%Y-%m-%d %H:%M:%S",$2);
            }
        }
    }
    {
        if (!($1 in dict)) {
            next;
        }
        rate = $5 + 0.0;
        if (rate < 0.01) {
            next;
        }
        dict[$1] = dict[$1]" "$2;
    }
    END {
        for (item in dict) {
            print dict[item], dict_time[item], 0;
        }
    }' ${MID_FILE_FEATURE} | sort > ${MID_FILE_FEATURE_MATCHED}.info

    if [ $? -ne 0 ]
    then
        fatal_log "${FUNCNAME} error."
        return 1
    fi

    get_step_info "${MID_FILE_FEATURE_MATCHED}"
    notice_log "${FUNCNAME} step_info[${STEP_INFO}]"
    return 0
}

function step_setresult() {
    awk 'BEGIN {
        FS = OFS = "\t";
    }
    {
	printf("insert into abnormal_word(ucid, reason, opt_time, sec_score) values (%s,\x27%s\x27,\x27%s\x27,%s);\n", $1, $2, $3, $4);
    }' ${MID_FILE_FEATURE_MATCHED}.info > ${MID_FILE_FEATURE_MATCHED}.info.sql
    cat ${MID_FILE_FEATURE_MATCHED}.info.sql | while read sql
    do
        user=${secure_user}
        pass=${secure_pass}
        dbname=${secure_dbname}
        host=${secure_host}
        port=${secure_port}
        eval_pat "${MYSQL_PATH_PAT}" "MYSQL_PATH"
        exe_sql="${MYSQL_PATH} -e\"${sql}\""
        echo "PROCESS[$!] run[${exe_sql}]"
        eval ${exe_sql}
        if [ 0 -ne $? ] 
        then
            echo "PROCESS[$!] run error!" 
            return 1
        fi
    done

    get_step_info "${MID_FILE_FEATURE_MATCHED}.info.sql"
    notice_log "${FUNCNAME} step_info[${STEP_INFO}]"
    return 0
}

function step_report() {
    grep "PID=${PID}" ${LOG_FILE} | sed 's/.* step_info\[\(.*\)\]\]/\1/g' > ${FUNCNAME}.temp
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

    sendmail "${TYPE}" "${FUNCNAME}.contant" "${fn_COLNAMES}" "${DATA_DAY}"
    rm ${FUNCNAME}.*
 
    return 0
}
##! @TODO: 运行所有处理函数
##! @AUTHOR: yangkai04@baidu.com
##! @OUT: 0 => success; other => failed
function run_all_step() {
    notice_log "${FUNCNAME} start."
    if [ "${TYPE}" == "spam" ]
    then
        ALL_STEPS="step_fetch_amends step_get_optlog_begindate step_fetch_spamlog step_segment step_segword step_feature step_feature_filter step_identity"
    else
        ALL_STEPS="step_fetch_optlog step_segment step_segword step_feature step_match step_setresult"
        ALL_STEPS="step_fetch_optlog step_segment step_segword step_feature step_match"
    fi

    local FN_ALL_STEPS=${ALL_STEPS}
    for step in ${FN_ALL_STEPS}
    do
        STEP_START_TIME=`date +"%Y-%m-%d %H:%M:%S"`
        STEP_START_TIME_SEC=`date +"%s"`
        local FN_TRACK_MSG="${step}_${DATA_DAY}"
        check_track "${FN_TRACK_MSG}"
        if [ $? -ne 0 ]
        then
            notice_log "${FN_TRACK_MSG} already run, not to run again."
            continue
        fi
        notice_log "${step} start."
        ${step}
        if [ $? -ne 0 ]
        then
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

