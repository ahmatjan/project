#!/bin/sh

# 【说明】
#  下载ftp文件
#############################################################################
# 【配置】
SHELL_NAME=$0
LOG_FILE="../log/${SHELL_NAME}.log"
OUTPUT_DIR="/home/work/var"

i=0
#秋实预算
TIME_FORMAT[$i]="%Y%m%d-%H"
TIME_CIRCLE[$i]=7200
TIME_OFFSET[$i]=0
SOURCE_FILE_PAT[$i]='ftp://db-das-zxblog00.db01/home/work/cdp-bgt-qiushi/bgt-qiushi/data/qiushi.info.${TIME_STAMP}'
TARGET_FILE_PAT[$i]='${OUTPUT_DIR}/bm_budget_qiushi/${TIME_STAMP:0:8}/qiushi.info.${TIME_STAMP}'
((i++))
TIME_FORMAT[$i]="%Y%m%d-%H"
TIME_CIRCLE[$i]=7200
TIME_OFFSET[$i]=0
SOURCE_FILE_PAT[$i]='ftp://db-das-zxblog00.db01/home/work/cdp-bgt-qiushi/bgt-qiushi/data/qiushi.info.n.${TIME_STAMP}'
TARGET_FILE_PAT[$i]='${OUTPUT_DIR}/bm_budget_qiushi/${TIME_STAMP:0:8}/qiushi.info.n.${TIME_STAMP}'
((i++))
#知心预算
TIME_FORMAT[$i]="%Y%m%d-%H"
TIME_CIRCLE[$i]=7200
TIME_OFFSET[$i]=0
SOURCE_FILE_PAT[$i]='ftp://10.36.114.61/home/work/cdp-bgt-game/bgt-game/data/zhixin.info.${TIME_STAMP}'
TARGET_FILE_PAT[$i]='${OUTPUT_DIR}/bm_budget_zhixin/${TIME_STAMP:0:8}/zhixin.info.${TIME_STAMP}'
((i++))
TIME_FORMAT[$i]="%Y%m%d-%H"
TIME_CIRCLE[$i]=7200
TIME_OFFSET[$i]=0
SOURCE_FILE_PAT[$i]='ftp://10.36.114.61/home/work/cdp-bgt-game/bgt-game/data/zhixin.info.n.${TIME_STAMP}'
TARGET_FILE_PAT[$i]='${OUTPUT_DIR}/bm_budget_zhixin/${TIME_STAMP:0:8}/zhixin.info.n.${TIME_STAMP}'
((i++))
#一站式余额
TIME_FORMAT[$i]="%Y%m%d-%H"
TIME_CIRCLE[$i]=3600
TIME_OFFSET[$i]=0
SOURCE_FILE_PAT[$i]='ftp://10.65.24.88/home/work/var/dr-finance/stat/balance/${TIME_STAMP:0:8}/userblns.${TIME_STAMP}.txt'
TARGET_FILE_PAT[$i]='${OUTPUT_DIR}/bm_finance_allinone/${TIME_STAMP:0:8}/allinone.finance.${TIME_STAMP}'
((i++))
#全能账户绑定关系
TIME_FORMAT[$i]="%Y%m%d-%H"
TIME_CIRCLE[$i]=7200
TIME_OFFSET[$i]=0
SOURCE_FILE_PAT[$i]='ftp://10.81.47.142/home/work/var/dr-finance/stat/universal/${TIME_STAMP:0:8}/master-map.${TIME_STAMP}.base.txt'
TARGET_FILE_PAT[$i]='${OUTPUT_DIR}/bm_bindrelation/${TIME_STAMP:0:8}/bindrelation.info.${TIME_STAMP}'
((i++))
TIME_FORMAT[$i]="%Y%m%d-%H"
TIME_CIRCLE[$i]=7200
TIME_OFFSET[$i]=0
SOURCE_FILE_PAT[$i]='ftp://10.81.47.142/home/work/var/dr-finance/stat/universal/${TIME_STAMP:0:8}/master-map.${TIME_STAMP}.msgid.txt'
TARGET_FILE_PAT[$i]='${OUTPUT_DIR}/bm_bindrelation/${TIME_STAMP:0:8}/bindrelation.info.n.${TIME_STAMP}'
((i++))
#SIVA
TIME_FORMAT[$i]="%Y%m%d-%H"
TIME_CIRCLE[$i]=7200
TIME_OFFSET[$i]=0
SOURCE_FILE_PAT[$i]='ftp://m1-ma-cron00.m1/home/work/dataio/mfsdata/adcharge/budget/budget.${TIME_STAMP}.log'
TARGET_FILE_PAT[$i]='${OUTPUT_DIR}/bm_budget_siva/${TIME_STAMP:0:8}/siva.info.${TIME_STAMP}'
((i++))
TIME_FORMAT[$i]="%Y%m%d-%H"
TIME_CIRCLE[$i]=7200
TIME_OFFSET[$i]=0
SOURCE_FILE_PAT[$i]='ftp://m1-ma-cron00.m1/home/work/dataio/mfsdata/adcharge/budget/budget.${TIME_STAMP}.idx'
TARGET_FILE_PAT[$i]='${OUTPUT_DIR}/bm_budget_siva/${TIME_STAMP:0:8}/siva.info.n.${TIME_STAMP}'
((i++))
#凤巢
TIME_FORMAT[$i]="%Y%m%d-%H"
TIME_CIRCLE[$i]=7200
TIME_OFFSET[$i]=0
SOURCE_FILE_PAT[$i]='ftp://dbl-das-mer21.dbl01/home/work/merger-fcbgt/bm-merger/data/fc.info.${TIME_STAMP}'
TARGET_FILE_PAT[$i]='${OUTPUT_DIR}/bm_budget_fc/${TIME_STAMP:0:8}/fc.info.${TIME_STAMP}'
((i++))
TIME_FORMAT[$i]="%Y%m%d-%H"
TIME_CIRCLE[$i]=7200
TIME_OFFSET[$i]=0
SOURCE_FILE_PAT[$i]='ftp://dbl-das-mer21.dbl01/home/work/merger-fcbgt/bm-merger/data/fc.info.n.${TIME_STAMP}'
TARGET_FILE_PAT[$i]='${OUTPUT_DIR}/bm_budget_fc/${TIME_STAMP:0:8}/fc.info.n.${TIME_STAMP}'
((i++))
#共享预算组
TIME_FORMAT[$i]="%Y%m%d-%H"
TIME_CIRCLE[$i]=7200
TIME_OFFSET[$i]=0
SOURCE_FILE_PAT[$i]='ftp://10.26.17.12/home/work/cdp-delta-budget1/delta-budget1/data/budget.info.${TIME_STAMP}'
TARGET_FILE_PAT[$i]='${OUTPUT_DIR}/bm_budget_deltagroup/${TIME_STAMP:0:8}/deltagroup.info.${TIME_STAMP}'
((i++))
TIME_FORMAT[$i]="%Y%m%d-%H"
TIME_CIRCLE[$i]=7200
TIME_OFFSET[$i]=0
SOURCE_FILE_PAT[$i]='ftp://10.26.17.12/home/work/cdp-delta-budget1/delta-budget1/data/budget.info.n.${TIME_STAMP}'
TARGET_FILE_PAT[$i]='${OUTPUT_DIR}/bm_budget_deltagroup/${TIME_STAMP:0:8}/deltagroup.info.n.${TIME_STAMP}'
((i++))
#共享预算计划
TIME_FORMAT[$i]="%Y%m%d-%H"
TIME_CIRCLE[$i]=7200
TIME_OFFSET[$i]=0
SOURCE_FILE_PAT[$i]='ftp://10.81.31.177/home/work/cdp-delta-budget2/delta-budget2/data/plan.info.${TIME_STAMP}'
TARGET_FILE_PAT[$i]='${OUTPUT_DIR}/bm_budget_deltaplan/${TIME_STAMP:0:8}/deltaplan.info.${TIME_STAMP}'
((i++))
TIME_FORMAT[$i]="%Y%m%d-%H"
TIME_CIRCLE[$i]=7200
TIME_OFFSET[$i]=0
SOURCE_FILE_PAT[$i]='ftp://10.81.31.177/home/work/cdp-delta-budget2/delta-budget2/data/plan.info.n.${TIME_STAMP}'
TARGET_FILE_PAT[$i]='${OUTPUT_DIR}/bm_budget_deltaplan/${TIME_STAMP:0:8}/deltaplan.info.n.${TIME_STAMP}'

#############################################################################
# 【函数】
# 输出日志
function WriteLog_()
{
    local fn_DATE=`date`
    local fn_LINENO=$1
    local fn_TYPE=$2
    local fn_MSG=$3
    if [ -d "${LOG_FILE%/*}" ]
    then
        echo "time[$fn_DATE] shell[${SHELL_NAME}] line[${fn_LINENO}] [${fn_TYPE}] $fn_MSG" >> ${LOG_FILE}
    else
        echo "time[$fn_DATE] shell[${SHELL_NAME}] line[${fn_LINENO}] [${fn_TYPE}] $fn_MSG"
    fi
}
shopt -s expand_aliases
alias WriteLog='WriteLog_ $LINENO'

# 检查参数是否为空
function IsConfEmpty()
{
    local fn_NAME=$1
    eval "fn_CONF=\${${fn_NAME}}"
    if [ -z "${fn_CONF}" ]
    then
        WriteLog "FATAL" "conf item ${fn_NAME} is empty!" 
        error_exit
    fi
}

# 检查文件是否存在
function IsFileExist()
{
    local fn_FILE=$1

    if [ ! -f "${fn_FILE}" ]
    then
        WriteLog "FATAL" "file[${fn_FILE}] is not exist!"
        error_exit
    fi
}

# 创建文件路径
function CheckFilePath()
{
    local fn_FILE=$1
    fn_PATH="${fn_FILE%/*}"

    if [ ! -d "${fn_PATH}" ]
    then
        WriteLog "NOTICE" "file[${fn_PATH}] is not exist, create it." 
    fi
    mkdir -p ${fn_PATH}
}

# 检测目录是否存在，不存在则创建
function IsPathExist()
{
    local fn_PATH=$1

    if [ ! -d "${fn_PATH}" ]
    then
        WriteLog "NOTICE" "mkdir -p ${fn_PATH}."
        mkdir -p ${fn_PATH}
        if [ $? -ne 0 ]
        then
            WriteLog "FATAL" "mkdir -p ${fn_PATH} failed!" 
            error_exit
        fi
    fi
}

#字符串转义
function EvalPat()
{
    local fn_TARGET=$1
    local fn_TARGET_PAT=$2

    eval "${fn_TARGET}=${fn_TARGET_PAT}"

    if [ 0 -ne $? ]
    then
        WriteLog "FATAL" "eval \"${fn_TARGET}=${fn_TARGET_PAT}\" error!" 
        error_exit
    else
        WriteLog "NOTICE" "eval \"${fn_TARGET}=${fn_TARGET_PAT}\" succ! \
            ${fn_TARGET}=[${!fn_TARGET}]."
    fi
}

#异常退出
function error_exit()
{
    WriteLog "NOTICE" "program ERROR EXIT"
    WriteLog "NOTICE" "########################################"
    exit 1
}

#############################################################################
# 【流程】
# 处理命令行参数
VERSION_ID="1.0.0"
USAGE="Usage: \
\n\tsh -x $0 -v \tmeans output version 
\n\tsh -x $0 -h \tmeans output help"

while getopts :vh OPTION
do
  case ${OPTION} in
  v)echo ${VERSION_ID}
   exit 0
   ;;
  h)echo -e ${USAGE}
   exit 0
   ;;
  ?)echo -e "USE IN INCORRECT WAY \n"${USAGE}
   exit 1
   ;;
  esac
done

CheckFilePath ${LOG_FILE}
WriteLog "NOTICE" "########################################"
WriteLog "NOTICE" "program BEGIN"

# 检查配置
IsConfEmpty "SHELL_NAME"
IsConfEmpty "LOG_FILE"
IsConfEmpty "OUTPUT_DIR"
IsPathExist "${OUTPUT_DIR}"

NOW_TIMESTAMP=`date -d"1 hour ago" +"%Y-%m-%d %H:%M:%S"`
NOW_SECONDS=`date -d"${NOW_TIMESTAMP}" +"%s"`
#echo ${NOW_TIMESTAMP}
#echo ${NOW_SECONDS}

idx=0
loop=${#SOURCE_FILE_PAT[*]}
while [ $idx -lt ${loop} ]
do
    TIME_FORMAT=${TIME_FORMAT[$idx]}
    SOURCE_FILE_PAT=${SOURCE_FILE_PAT[$idx]}
    TIME_CIRCLE=${TIME_CIRCLE[$idx]}
    TIME_OFFSET=${TIME_OFFSET[$idx]}
    TARGET_FILE_PAT=${TARGET_FILE_PAT[$idx]}

    IsConfEmpty "TIME_FORMAT"
    IsConfEmpty "SOURCE_FILE_PAT"
    IsConfEmpty "TIME_CIRCLE"
    IsConfEmpty "TIME_OFFSET"
    IsConfEmpty "TARGET_FILE_PAT"

    START_SECONDS=`expr \( ${NOW_SECONDS} \/ ${TIME_CIRCLE} \) \* ${TIME_CIRCLE} + ${TIME_OFFSET}`
    TIME_STAMP=`date -d"1970-01-01 UTC ${START_SECONDS} seconds" +"${TIME_FORMAT}"`

    EvalPat "SOURCE_FILE" "${SOURCE_FILE_PAT}"
    EvalPat "TARGET_FILE" "${TARGET_FILE_PAT}"
    CheckFilePath ${TARGET_FILE}
    rm -f "${TARGET_FILE}"

    wget ${SOURCE_FILE} -O ${TARGET_FILE} >> ${LOG_FILE} 2>&1
    # 获取失败则打FATAL
    if [ 0 -ne $? ]
    then
        WriteLog "FATAL" "get SOURCE_FILE[${SOURCE_FILE}] error!"
    fi

    ((idx++))
done

WriteLog "NOTICE" "program END"
WriteLog "NOTICE" "########################################"
#############################################################################

