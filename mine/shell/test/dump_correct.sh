#!/bin/sh

# 【说明】
# 本tools根据bcmain的dump文件与预算基准文件，共同生成新的dump文件，以应对changehistory增量缺失情况
# 输入文件为：bcmain的dump文件、预算基准文件
# 输出文件为：bcmain的dump文件
# 流程为：
# 1、确定bcmain的近两天增量文件存在，确定bcmain基准文件存在；
# 2、抓取最近的基准文件(BM_FILE_HOUR_BEGIN,BM_FILE_HOUR_END之间)，如果抓取不到，则返回失败
# 3、到bin目录，停止bcmain
# 4、根据抓取的基准文件与增量文件，根据相应业务逻辑生成相应dump文件
# 5、mv 新dump 到 bcmain的data目录
# 6、启动bcmain

# 当前支持的业务有：秋实、知心、siva
# 秋实：将基准文件+原dump文件中不存在于基准文件中的部分=新基准文件（为避免抓取的基准文件不全，所以
#       加上原dump中的其余数据
# 知心：有realstatus、offtime两个字段，以userid+tradeid+planid为key，如果key存在于原dump文件，则该
#       两个字段保留原值（增量预算需要）
# siva：将基准文件+原dump文件中不存在于基准文件中的部分=新基准文件（siva有用户数据，所以必须加原
#       dump中的其余数据
#############################################################################
# 【配置】
#DEBUG=1
SHELL_NAME=$0
LOG_FILE="../log/${SHELL_NAME}.log"
OUTPUT_DIR="../output/"
MACHINE_NAME=$(hostname)
MOD_NUM=1
MOD_VAL=0

i=0
APP_NAME[$i]="qs"
SOURCE_DUMP_FILE[$i]="../data/qs_budget"
SOURCE_IM_FILE_PAT[$i]='/home/work/var/zep-qsbudget-new/${DATA_DAY}/qs_budget.${DATA_DAY}-*.log'
SOURCE_BM_FILE_PAT[$i]='ftp://db-das-zxblog00.db01/home/work/cdp-bgt-qiushi/bgt-qiushi/data/qiushi.info.${TIME_STAMP}'
SOURCE_IDX_FILE_PAT[$i]='ftp://db-das-zxblog00.db01/home/work/cdp-bgt-qiushi/bgt-qiushi/data/qiushi.info.n.${TIME_STAMP}'
BM_FILE_HOUR_BEGIN[$i]="1"
BM_FILE_HOUR_END[$i]="4"
TARGET_BM_FILE[$i]="../output/qiushi.info"
TARGET_IDX_FILE[$i]="../output/qiushi.info.n"
TARGET_DUMP_FILE[$i]="../output/qs_budget"
BIN_PATH[$i]="/home/work/fc-shark/bcmain-qs/bin"
CTRL_NAME[$i]="bcmain-qs_ctrl.sh"
if [ ! -z "${DEBUG}" ]
then
    SOURCE_IM_FILE_PAT[$i]='../data/qs_im/${DATA_DAY}/qs_budget.${DATA_DAY}-*.log'
    BIN_PATH[$i]="../data"
    CTRL_NAME[$i]="test.sh"
fi

((i++))
APP_NAME[$i]="zx"
SOURCE_DUMP_FILE[$i]="../data/zx_budget_status"
SOURCE_IM_FILE_PAT[$i]='/home/work/var/zep-zx-budget/${DATA_DAY}/zxbudget.${DATA_DAY}-*.log'
SOURCE_BM_FILE_PAT[$i]='ftp://10.36.114.61//home/work/cdp-bgt-game/bgt-game/data/zhixin.info.${TIME_STAMP}'
SOURCE_IDX_FILE_PAT[$i]='ftp://10.36.114.61//home/work/cdp-bgt-game/bgt-game/data/zhixin.info.n.${TIME_STAMP}'
BM_FILE_HOUR_BEGIN[$i]="1"
BM_FILE_HOUR_END[$i]="4"
TARGET_BM_FILE[$i]="../output/zhixin.info"
TARGET_IDX_FILE[$i]="../output/zhixin.info.n"
TARGET_DUMP_FILE[$i]="../output/zx_budget_status"
BIN_PATH[$i]="/home/work/fc-shark/bcmain/bin"
CTRL_NAME[$i]="bcmain_ctrl.sh"
if [ ! -z "${DEBUG}" ]
then
    SOURCE_IM_FILE_PAT[$i]='../data/zx_im/${DATA_DAY}/zxbudget.${DATA_DAY}-*.log'
    BIN_PATH[$i]="../data"
    CTRL_NAME[$i]="test.sh"
fi

((i++))
APP_NAME[$i]="siva"
SOURCE_DUMP_FILE[$i]="../data/siva_budget_status"
SOURCE_IM_FILE_PAT[$i]='/home/work/var/zep-sivabudget/${DATA_DAY}/sivabudget.${DATA_DAY}-*.log'
SOURCE_BM_FILE_PAT[$i]='ftp://m1-ma-cron00.m1.baidu.com/home/work/dataio/mfsdata/adcharge/budget/budget.${TIME_STAMP}.log'
SOURCE_IDX_FILE_PAT[$i]='ftp://m1-ma-cron00.m1.baidu.com/home/work/dataio/mfsdata/adcharge/budget/budget.${TIME_STAMP}.idx'
BM_FILE_HOUR_BEGIN[$i]="1"
BM_FILE_HOUR_END[$i]="4"
TARGET_BM_FILE[$i]="../output/siva.info"
TARGET_IDX_FILE[$i]="../output/siva.info.n"
TARGET_DUMP_FILE[$i]="../output/siva_budget_status"
BIN_PATH[$i]="/home/work/fc-shark/bcmain-siva/bin"
CTRL_NAME[$i]="bcmain-siva_ctrl.sh"
if [ ! -z "${DEBUG}" ]
then
    SOURCE_IM_FILE_PAT[$i]='../data/siva_im/${DATA_DAY}/sivabudget.${DATA_DAY}-*.log'
    BIN_PATH[$i]="../data"
    CTRL_NAME[$i]="test.sh"
fi

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

function dump_budget_rebuild()
{
    local fn_app=$1
    if [ "${fn_app}" == "qs" ]
    then
        dump_budget_rebuild_qs "$2" "$3" "$4" "$5" "$6"
    elif [ "${fn_app}" == "zx" ]
    then
        dump_budget_rebuild_zx "$2" "$3" "$4" "$5" "$6"
    elif [ "${fn_app}" == "siva" ]
    then
        dump_budget_rebuild_siva "$2" "$3" "$4" "$5" "$6"
    fi
}

function dump_budget_rebuild_qs()
{
    local fn_dumpfile=$1
    local fn_imfiles=$2
    local fn_bmfile=$3
    local fn_idx=$4
    local fn_resultfile=$5
    local fn_bmfile_combine="${fn_bmfile}_combine"

    IsFileExist "${fn_dumpfile}"
    IsFileExist "${fn_bmfile}"
    CheckFilePath "${fn_bmfile_combine}"
    CheckFilePath "${fn_resultfile}"
    awk 'BEGIN {
        bm_id='${fn_idx}'+0;
        FS=OFS="\t";
        while(getline<"'${fn_bmfile}'">0)
        {
            if ($9==0)
            {
                key=$6"\t"$7;
                dict_budget[key]=$8;
            }
        }
    }
    {
        if (NF < 8 || $8!=0)
        {
            next;
        }
        im_id=$3+0;
        if (im_id < bm_id)
        {
            next;
        }

        key=$5"\t"$6;
        dict_budget[key]=$7;
    }
    END{
        for (key in dict_budget)
        {
            print key,dict_budget[key];
        }
    }' ${fn_imfiles} > ${fn_bmfile_combine}

    head -n 1 ${fn_dumpfile} > ${fn_resultfile}
    awk 'BEGIN{
        mod_num='${MOD_NUM}'+0;
        mod_val='${MOD_VAL}'+0;
        FS=OFS="\t";
        while(getline<"'${fn_dumpfile}'">0)
        {
            if (NF >= 3)
            {
                key=$1"\t"$2;
                dict[key]=$0;
            }
        }
    }
    {
        if (NF < 3)
        {
            next;
        }
        key=$1"\t"$2;
        dict[key]="";
        userid=$1+0;
        if (userid % mod_num == mod_val) 
        {
            print $1,$2,$3;
        }
    }
    END{
        for (item in dict)
        {
            if (dict[item]!="")
            {
                split(item, key_array, "\t");
                userid=key_array[1] + 0;
                if (userid % mod_num == mod_val) 
                {
                    print dict[item];
                }
            }
        }
    }' ${fn_bmfile_combine} >> ${fn_resultfile}
    tail -n 1 ${fn_dumpfile} >> ${fn_resultfile}
}

function dump_budget_rebuild_zx()
{
    local fn_dumpfile=$1
    local fn_imfiles=$2
    local fn_bmfile=$3
    local fn_idx=$4
    local fn_resultfile=$5
    local fn_bmfile_combine="${fn_bmfile}_combine"

    IsFileExist "${fn_dumpfile}"
    IsFileExist "${fn_bmfile}"
    CheckFilePath "${fn_bmfile_combine}"
    CheckFilePath "${fn_resultfile}"
    awk 'BEGIN {
        bm_id='${fn_idx}'+0;
        FS=OFS="\t";
        while(getline<"'${fn_bmfile}'">0)
        {
            if (NF >= 10 && $10==0)
            {
                budget = $9;
                if (budget=="0")
                {
                    budget="18446744073709551615";
                }

                key=$6"\t"$7"\t"$8;
                dict_budget[key]=budget;
            }
        }
    }
    {
        if (NF < 9 || $9!=0)
        {
            next;
        }
        im_id=$3+0;
        if (im_id < bm_id)
        {
            next;
        }

        key=$5"\t"$6"\t"$7;
        budget = $8;
        if (budget=="0")
        {
            budget="18446744073709551615";
        }
        dict_budget[key]=budget;

    } END {
        for (key in dict_budget)
        {
            print key,dict_budget[key];
        }
    }' ${fn_imfiles} > ${fn_bmfile_combine}

    head -n 2 ${fn_dumpfile} > ${fn_resultfile}
    awk 'BEGIN{
        mod_num='${MOD_NUM}'+0;
        mod_val='${MOD_VAL}'+0;
        FS=OFS="\t";
        while(getline<"'${fn_dumpfile}'">0)
        {
            if (NF >= 3)
            {
                key=$1"\t"$2"\t"$3;
                dict[key]=$0;
                dict_realstat[key]=$6+0;
                dict_offtime[key]=$7+0;
            }
        }
    }
    {
        if (NF < 4)
        {
            next;
        }
        key=$1"\t"$2"\t"$3;
        realstat=0;
        if (key in dict_realstat)
        {
            realstat=dict_realstat[key];
        }
        offtime=86400;
        if (key in dict_offtime)
        {
            offtime=dict_offtime[key];
        }
        budget = $4;
        if (budget=="0")
        {
            budget="18446744073709551615";
        }
        dict[key]="";
        userid=$1+0;
        if (userid % mod_num == mod_val) 
        {
            printf("%s\t0\t%s\t%d\t%d\n",key,budget,realstat,offtime);
        }
    }
    END{
        for (item in dict)
        {
            if (dict[item]!="")
            {
                split(item, key_array, "\t");
                userid=key_array[1] + 0;
                if (userid % mod_num == mod_val) 
                {
                    print dict[item];
                }
            }
        }
    }' ${fn_bmfile_combine} >> ${fn_resultfile}
    tail -n 1 ${fn_dumpfile} >> ${fn_resultfile}
}

function dump_budget_rebuild_siva()
{
    local fn_dumpfile=$1
    local fn_imfiles=$2
    local fn_bmfile=$3
    local fn_idx=$4
    local fn_resultfile=$5
    local fn_bmfile_combine="${fn_bmfile}_combine"

    IsFileExist "${fn_dumpfile}"
    IsFileExist "${fn_bmfile}"
    CheckFilePath "${fn_bmfile_combine}"
    CheckFilePath "${fn_resultfile}"
    awk 'BEGIN {
        bm_id='${fn_idx}'+0;
        FS=OFS="\t";
        while(getline<"'${fn_bmfile}'">0)
        {
            if (NF >= 3)
            {
                key=$1"\t"$2"\t"$3;
                dict_budget[key]=$4;
            }
        }
    }
    {
        if (NF < 9 || $9 != 0)
        {
            next;
        }
 
        im_id=$3+0;
        if (im_id < bm_id)
        {
            next;
        }

        key=$5"\t"$6"\t"$7;
        dict_budget[key]=$8;
    }
    END{
        for (key in dict_budget)
        {
            print key,dict_budget[key];
        }
    }' ${fn_imfiles} > ${fn_bmfile_combine}

    head -n 1 ${fn_dumpfile} > ${fn_resultfile}
    awk 'BEGIN{
        mod_num='${MOD_NUM}'+0;
        mod_val='${MOD_VAL}'+0;
        FS=OFS="\t";
        while(getline<"'${fn_dumpfile}'">0)
        {
            if (NF >= 3)
            {
                key=$1"\t"$2"\t"$3;
                dict[key]=$0;
            }
        }
    }
    {
        key=$1"\t"$2"\t"$3;
        if (NF < 4)
        {
            next;
        }
        dict[key]="";
        userid=$1+0;
        if (userid % mod_num == mod_val) 
        {
            print $1,$2,$3,0,$4;
        }
    }
    END{
        for (item in dict)
        {
            if (dict[item]!="")
            {
                split(item, key_array, "\t");
                userid=key_array[1] + 0;
                if (userid % mod_num == mod_val) 
                {
                    print dict[item];
                }
            }
        }
    }' ${fn_bmfile_combine} >> ${fn_resultfile}
    tail -n 1 ${fn_dumpfile} >> ${fn_resultfile}
}

#############################################################################
# 【流程】
# 处理命令行参数
VERSION_ID="1.0.0"
USAGE="Usage: \
\n\tsh -x $0 -v \tmeans output version 
\n\tsh -x $0 -h \tmeans output help
\n\tsh -x $0 qs \tmeans rebuild qiushi budget dump file
\n\tsh -x $0 zx modnum(eg:2) modval(eg:0) \tmeans rebuild zx budget dump file
\n\tsh -x $0 siva \tmeans rebuild siva budget dump file"
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

APP=$1
if [ -z "${APP}" ]
then
    echo -e ${USAGE}
    exit 0
fi

if [ "${APP}" == "zx" ]
then
    if [ "$#" != "3" ]
    then
        echo -e ${USAGE}
        exit 0
    else
        MOD_NUM=$2
        MOD_VAL=$3
    fi
fi

CheckFilePath ${LOG_FILE}
WriteLog "NOTICE" "########################################"
WriteLog "NOTICE" "program BEGIN"

# 检查配置
IsConfEmpty "SHELL_NAME"
IsConfEmpty "LOG_FILE"
IsConfEmpty "OUTPUT_DIR"
IsPathExist "${OUTPUT_DIR}"
IsConfEmpty "MOD_NUM"
IsConfEmpty "MOD_VAL"

# 确定APP
idx=0
loop=${#APP_NAME[*]}
while [ $idx -lt ${loop} ]
do
    if [ "${APP_NAME[$idx]}" == "${APP}" ]
    then
        SOURCE_DUMP_FILE=${SOURCE_DUMP_FILE[$idx]}
        SOURCE_IM_FILE_PAT=${SOURCE_IM_FILE_PAT[$idx]}
        SOURCE_BM_FILE_PAT=${SOURCE_BM_FILE_PAT[$idx]}
        SOURCE_IDX_FILE_PAT=${SOURCE_IDX_FILE_PAT[$idx]}
        BM_FILE_HOUR_BEGIN=${BM_FILE_HOUR_BEGIN[$idx]}
        BM_FILE_HOUR_END=${BM_FILE_HOUR_END[$idx]}
        TARGET_BM_FILE=${TARGET_BM_FILE[$idx]}
        TARGET_IDX_FILE=${TARGET_IDX_FILE[$idx]}
        TARGET_DUMP_FILE=${TARGET_DUMP_FILE[$idx]}
        BIN_PATH=${BIN_PATH[$idx]}
        CTRL_NAME=${CTRL_NAME[$idx]}
        break
    fi
    ((idx++))
done

if [ ${idx} -eq ${loop} ]
then
    WriteLog "FATAL" "param[$APP] no support!"
    error_exit
fi

IsConfEmpty "SOURCE_DUMP_FILE"
IsConfEmpty "SOURCE_IM_FILE_PAT"
IsConfEmpty "SOURCE_BM_FILE_PAT"
IsConfEmpty "SOURCE_IDX_FILE_PAT"
IsConfEmpty "BM_FILE_HOUR_BEGIN"
IsConfEmpty "BM_FILE_HOUR_END"
IsConfEmpty "TARGET_BM_FILE"
IsConfEmpty "TARGET_IDX_FILE"
IsConfEmpty "TARGET_DUMP_FILE"
IsConfEmpty "BIN_PATH"
IsConfEmpty "CTRL_NAME"

IsFileExist "${SOURCE_DUMP_FILE}"
CheckFilePath "${TARGET_BM_FILE}"
CheckFilePath "${TARGET_DUMP_FILE}" 
IsFileExist "${BIN_PATH}/${CTRL_NAME}"

BEGIN=`date -d "${BM_FILE_HOUR_BEGIN} hour ago" +"%Y-%m-%d %H:00:00"`
END=`date -d "${BM_FILE_HOUR_END} hour ago" +"%Y-%m-%d %H:00:00"`
if [ ! -z "${DEBUG}" ]
then
    BEGIN="2014-02-26 15:00:00"
    END="2014-02-26 11:00:00"
fi
STEP="$((3600))"
FORMAT="%Y%m%d-%H"
                                                                                                    
cur_s=$(date -d" ${BEGIN}" +"%s")
end_s=$(date -d" ${END}" +"%s")

# 拼装IM文件路径
SOURCE_IM_FILES=""
DATA_DAY=`date -d"1 day ago" +"%Y%m%d"`
if [ ! -z "${DEBUG}" ]
then
    DATA_DAY="20140225"
fi
EvalPat "SOURCE_IM_FILE" "${SOURCE_IM_FILE_PAT}"
SOURCE_IM_FILES="${SOURCE_IM_FILES} ${SOURCE_IM_FILE}"
DATA_DAY=`date +"%Y%m%d"`
if [ ! -z "${DEBUG}" ]
then
    DATA_DAY="20140226"
fi
EvalPat "SOURCE_IM_FILE" "${SOURCE_IM_FILE_PAT}"
SOURCE_IM_FILES="${SOURCE_IM_FILES} ${SOURCE_IM_FILE}"

if [ `ls ${SOURCE_IM_FILES} | wc -l` -le 0 ]
then
    WriteLog "FATAL" "there is no file in path[${SOURCE_IM_FILES}]!"
    error_exit
fi

# 获取最近的BM文件
if [ ! -z "${DEBUG}" ]
then
    DEBUG_FILE="../data/${TARGET_BM_FILE##*/}"
    WriteLog "NOTICE" "dump file[${DEBUG_FILE}]"
    if [ -f "${DEBUG_FILE}" ]
    then
        cp "${DEBUG_FILE}" "${TARGET_BM_FILE}"
    else
        WriteLog "FATAL" "dump file[${DEBUG_FILE}] not exist error!"
        error_exit
    fi
else
    while [ "${cur_s}" -gt "${end_s}" ]
    do
        TIME_STAMP=$(date -d" 00:00:00 1970-01-01 UTC +${cur_s} sec " +"${FORMAT}")
        EvalPat "SOURCE_BM_FILE" "${SOURCE_BM_FILE_PAT}"
        rm -f "${TARGET_BM_FILE}"
        wget ${SOURCE_BM_FILE} -O ${TARGET_BM_FILE} >> ${LOG_FILE} 2>&1
        # 有一个获取成功，则退出while循环并继续
        if [ 0 -eq $? ]
        then
            WriteLog "NOTICE" "get SOURCE_BM_FILE[${SOURCE_BM_FILE}] succ."
            break
        fi
        WriteLog "WARNNING" "get SOURCE_BM_FILE[${SOURCE_BM_FILE}] error!"
        cur_s=$((cur_s - STEP))
        # 所有指定的小时内的BM文件都获取失败，则打FATAL退出
        if [ "${cur_s}" -le "${end_s}" ]
        then
            WriteLog "FATAL" "get SOURCE_BM_FILE[${SOURCE_BM_FILE}] error!"
            error_exit
        fi
    done
fi
# 获取idx
EvalPat "SOURCE_IDX_FILE" "${SOURCE_IDX_FILE_PAT}"
rm -f "${TARGET_IDX_FILE}"
if [ ! -z "${DEBUG}" ]
then
    DEBUG_FILE="../data/${TARGET_IDX_FILE##*/}"
    WriteLog "NOTICE" "idx file[${DEBUG_FILE}]"
    if [ -f "${DEBUG_FILE}" ]
    then
        cp "${DEBUG_FILE}" "${TARGET_IDX_FILE}"
    else
        WriteLog "FATAL" "idx file[${DEBUG_FILE}] not exist error!"
        error_exit
    fi
else
    wget ${SOURCE_IDX_FILE} -O ${TARGET_IDX_FILE} >> ${LOG_FILE} 2>&1
    # 获取失败则退出
    if [ 0 -ne $? ]
    then
        WriteLog "FATAL" "get SOURCE_IDX_FILE[${SOURCE_IDX_FILE}] error!"
        error_exit
    fi
fi
IDX=`cat ${TARGET_IDX_FILE}`
WriteLog "NOTICE" "idx[${IDX}] in FILE[${TARGET_IDX_FILE}]"

# 停bin
cd ${BIN_PATH}
if [ 0 -ne $? ]
then
    WriteLog "FATAL" "cd ${BIN_PATH} error!"
    error_exit
fi

sh ${CTRL_NAME} stop
if [ 0 -ne $? ]
then
    WriteLog "FATAL" "sh ${CTRL_NAME} stop error!"
    sh ${CTRL_NAME} start
    error_exit
fi

# 新建dump
dump_budget_rebuild "${APP}" "${SOURCE_DUMP_FILE}" "${SOURCE_IM_FILES}" "${TARGET_BM_FILE}" "${IDX}" "${TARGET_DUMP_FILE}"
if [ 0 -ne $? ]
then
    WriteLog "FATAL" "dump budget rebuild error!"
    sh ${CTRL_NAME} start
    error_exit
fi

if [ ! -z "${DEBUG}" ]
then
    WriteLog "NOTICE" "program END"
    WriteLog "NOTICE" "########################################"
    exit 0
fi
 
# 覆盖原dump
SUBFIX=`date +"%Y%m%d-%H%M%S"`
cp "${SOURCE_DUMP_FILE}" "${OUTPUT_DIR}/${SOURCE_DUMP_FILE##*/}.bak.${SUBFIX}"
mv "${TARGET_DUMP_FILE}" "${SOURCE_DUMP_FILE}"
if [ 0 -ne $? ]
then
    WriteLog "FATAL" "mv ${TARGET_DUMP_FILE} ${SOURCE_DUMP_FILE} error!"
    sh ${CTRL_NAME} start
    error_exit
fi

# 启bin
sh ${CTRL_NAME} start
if [ 0 -ne $? ]
then
    WriteLog "FATAL" "sh ${CTRL_NAME} start error!"
    error_exit
fi

WriteLog "NOTICE" "program END"
WriteLog "NOTICE" "########################################"
#############################################################################

