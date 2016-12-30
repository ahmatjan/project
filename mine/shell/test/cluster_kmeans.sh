#!/bin/sh

##################################################
# Shell Name : cluster_kmeans.sh
# Function : �������ļ����о��࣬�������ĵ��ļ��;������ļ�
# NOTICE : ���Ŀ¼�е�һ��Ϊ���ĵ��ļ�Ŀ¼���ڶ���Ϊ����ļ�Ŀ¼
#          ֧��ϡ�衢�������ָ�ʽ��ϡ���ʽ���£�
#          ����Ϊ�����ļ�����ʽΪ��userid\tpid1\tweight1...
#          ���Ϊ���ĵ��ļ��ͽ���ļ������ĵ��ļ���ʽͬ���������ļ���ʽ������ļ���ʽΪ��userid\tpid1\tweight1\t...\tclusterid
# COM_TYPE : ��Ӧ�����ģʽ(1-4),4
##################################################
# ϵͳ�汾��
SYS_VERSION="sardine_1.0.0 cluster_kmeans"
# ��ʾ���� print message
# �޸Ĵ��루��Ҫ�޸Ĵ������ʱ�޸Ĵ˴����룩
# ++++++++++++++++++++++++++++++++++++++++++++++++
function print_help()
{
	echo "Usage:"
	echo "	-c  config file path"
	echo "	-t  set the run_time of program"
	echo "		format is YYYYMMDD"
	echo "		if it's null, default is current time"
	echo "	-n  set the name of the algo"
	echo "	-f  set the func path of the algo"
	echo "	-i  set the input file or dir path of the algo"
	echo "	-o  set the output file or dir path of the algo"
	echo "	-h  print help message"
	echo "	-v  print the version"
}
# ++++++++++++++++++++++++++++++++++++++++++++++++
# ����汾��
function print_version()
{
	echo "${SYS_VERSION}"
}
##################################################
# ��ȡ�����в���
# �޸Ĵ��루��Ҫ�޸Ĵ������ʱ���޸Ĵ˴����룩
# ++++++++++++++++++++++++++++++++++++++++++++++++
#while getopts c:t:n:f:hv flag
while getopts c:t:n:f:i:o:hv flag
do
	case "${flag}" in
		# ���������ļ���ȫ·����
		c) CONF_PATH="${OPTARG}"
		;;
		# ���ó�������ʱ�������ʽ��20120321
		t) SYS_DATE="${OPTARG}"
		;;
		# ���������
		n) COM_NAME="${OPTARG}"
		;;
		# ���ù��ܺ����ļ�·��
		f) SYS_FUNC_PATH="${OPTARG}"
		;;
		# ��������·��
		i) INPUT_PATHS="${OPTARG}"
		;;
		# �������·��
		o) OUTPUT_PATHS="${OPTARG}"
		;;
		# ��ʾ������Ϣ
		h) print_help
		exit 0
		;;
		# ��ʾ�汾��
		v) print_version
		exit 0
		;;
		*) print_help
		exit 1
		;;
	esac
done
# ++++++++++++++++++++++++++++++++++++++++++++++++
SHELL_NAME=$0
##################################################
#����shell���ܺ���
idx=0
VAR=(`echo ${SYS_FUNC_PATH} | sed "s/,/ /g"`)
loop=${#VAR[@]}
while [ $idx -lt $loop ]
do
	if [ ! -f "${VAR[$idx]}" ]
	then
		echo "[FATAL]: ${VAR[$idx]} doesn't exist in the item SYS_FUNC_PATH!"
		exit 1
	fi
	source ${VAR[$idx]}
	if [ 0 -ne $? ]
	then
		echo "[FATAL]: source ${VAR[$idx]} failed!"
		exit 1
	fi
	idx=`expr $idx + 1`
done
##################################################
#������������������·����Ϊ��,��ô����ȡ�����ļ�
if [ ! -z "${CONF_PATH}" ]
then
	#���������ļ�
	source  ${CONF_PATH}
	if [ 0 -ne $? ]
	then
		echo "[FATAL]: source ${CONF_PATH} failed!"
		exit 1
	fi
fi
##################################################
#��־������ã���������ļ������������,ȡĬ�ϵ�../logĿ¼
if [ -z "${SYS_LOG_DIR}" ]
then
	SYS_LOG_DIR="../log"
fi

if [ -z "${LOG_NAME}" ] 
then 
	LOG_NAME="${COM_NAME}.log"
fi

#�����־Ŀ¼�Ƿ����,��������ڣ��򴴽�һ����
if [ ! -d "${SYS_LOG_DIR}" ]
then
	mkdir -p "${SYS_LOG_DIR}"
	#����������ɹ����򱨾��˳���
	if [ $? -ne 0 ]
	then
		#ע������������־Ŀ¼�����ڣ����ǲ��ܴ���־��
		echo "[FATAL]: mkdir -p  ${SYS_LOG_DIR} failed!"
		exit 1
	fi
fi

#��־�ļ�ȫ·����
if [ -z "${LOG_FILE}" ]
then
	LOG_FILE="${SYS_LOG_DIR}/${LOG_NAME}"
fi

if [ -z "${TRACK_FILE}" ]
then
	TRACK_FILE="${SYS_LOG_DIR}/${COM_NAME}.track"
fi
##################################################
WriteLog "--------------------------------------------------" "${LOG_FILE}"
WriteLog "NOTICE: [${SHELL_NAME}] algorithm begin ~!" "${LOG_FILE}"
##################################################
# �����������Ƿ�Ϊ��

CheckConfIsEmpty "SYS_VERSION" "${SYS_VERSION}" "${LOG_FILE}" "${ALARM_MAIL}" "${ALARM_MOBILE}" "${SHELL_NAME}"
CheckConfIsEmpty "ALARM_MAIL" "${ALARM_MAIL}" "${LOG_FILE}" "${ALARM_MAIL}" "${ALARM_MOBILE}" "${SHELL_NAME}"
CheckConfIsEmpty "ALARM_MOBILE" "${ALARM_MOBILE}" "${LOG_FILE}" "${ALARM_MAIL}" "${ALARM_MOBILE}" "${SHELL_NAME}"
CheckConfIsEmpty "SYS_LOG_DIR" "${SYS_LOG_DIR}" "${LOG_FILE}" "${ALARM_MAIL}" "${ALARM_MOBILE}" "${SHELL_NAME}"
CheckConfIsEmpty "SYS_DATA_DIR" "${SYS_DATA_DIR}" "${LOG_FILE}" "${ALARM_MAIL}" "${ALARM_MOBILE}" "${SHELL_NAME}"
CheckConfIsEmpty "SYS_ALGO_DIR" "${SYS_ALGO_DIR}" "${SYS_LOG_FILE}" "${ALARM_MAIL}" "${ALARM_MOBILE}" "${SHELL_NAME}"
CheckConfIsEmpty "PER_ALGO_DIR" "${PER_ALGO_DIR}" "${SYS_LOG_FILE}" "${ALARM_MAIL}" "${ALARM_MOBILE}" "${SHELL_NAME}"
CheckConfIsEmpty "SYS_DATE" "${SYS_DATE}" "${LOG_FILE}" "${ALARM_MAIL}" "${ALARM_MOBILE}" "${SHELL_NAME}"
CheckConfIsEmpty "SYS_FUNC_PATH" "${SYS_FUNC_PATH}" "${LOG_FILE}" "${ALARM_MAIL}" "${ALARM_MOBILE}" "${SHELL_NAME}"
CheckConfIsEmpty "SHELL_NAME" "${SHELL_NAME}" "${LOG_FILE}" "${ALARM_MAIL}" "${ALARM_MOBILE}" "${SHELL_NAME}"

# ��Ӵ��루��Ҫ����������ļ��ʱ�޸Ĵ˴����룩
# ++++++++++++++++++++++++++++++++++++++++++++++++
CheckConfIsEmpty "INPUT_PATHS" "${INPUT_PATHS}" "${LOG_FILE}" "${ALARM_MAIL}" "${ALARM_MOBILE}" "${SHELL_NAME}"
CheckConfIsEmpty "OUTPUT_PATHS" "${OUTPUT_PATHS}" "${LOG_FILE}" "${ALARM_MAIL}" "${ALARM_MOBILE}" "${SHELL_NAME}"
CheckConfIsEmpty "KMEANS_EXE_PATH" "${KMEANS_EXE_PATH}" "${LOG_FILE}" "${ALARM_MAIL}" "${ALARM_MOBILE}" "${SHELL_NAME}"
CheckConfIsEmpty "KMEANS_EXE_PARAM" "${KMEANS_EXE_PARAM}" "${LOG_FILE}" "${ALARM_MAIL}" "${ALARM_MOBILE}" "${SHELL_NAME}"
CheckConfIsEmpty "KMEANS_HADOOP_PATH" "${KMEANS_HADOOP_PATH}" "${LOG_FILE}" "${ALARM_MAIL}" "${ALARM_MOBILE}" "${SHELL_NAME}"
CheckConfIsEmpty "KMEANS_ROOT_PATH" "${KMEANS_ROOT_PATH}" "${LOG_FILE}" "${ALARM_MAIL}" "${ALARM_MOBILE}" "${SHELL_NAME}"
CheckConfIsEmpty "SAPRSE_OR_DENSE" "${SPARSE_OR_DENSE}" "${LOG_FILE}" "${ALARM_MAIL}" "${ALARM_MOBILE}" "${SHELL_NAME}"
CheckConfIsEmpty "CENTER_TYPE" "${CENTER_TYPE}" "${LOG_FILE}" "${ALARM_MAIL}" "${ALARM_MOBILE}" "${SHELL_NAME}"
CheckConfIsEmpty "THRESH_CONVER" "${THRESH_CONVER}" "${LOG_FILE}" "${ALARM_MAIL}" "${ALARM_MOBILE}" "${SHELL_NAME}"
CheckConfIsEmpty "K_TIMES" "${K_TIMES}" "${LOG_FILE}" "${ALARM_MAIL}" "${ALARM_MOBILE}" "${SHELL_NAME}"
CheckConfIsEmpty "CENTER_NUM" "${CENTER_NUM}" "${LOG_FILE}" "${ALARM_MAIL}" "${ALARM_MOBILE}" "${SHELL_NAME}"
# ���߲�������Ĭ��ֵ
ARGS_CLUSTER_PARAMETERS="t1,0.4:t2,0.2:n,300:ow:cl:xm,sequential:im,inmemory"
ARGS_ISDATAPRE="true"
ARGS_ISCLUSTERPRE="true"
ARGS_VECTOR_SIZE="2000"
ARGS_ISCLASSIFY="true"
ARGS_XM="sequential"
if [ ! -z "${RUN_TYPE}" ]
then
	ARGS_XM="${RUN_TYPE}"
fi
ARGS_X="${K_TIMES}"
ARGS_CD="${THRESH_CONVER}"
ARGS_DM="Cosine"
if [ ! -z "${DISTANCE_TYPE}" ]
then
	ARGS_DM="${DISTANCE_TYPE}"
fi

ARGS_OW="true"
# ������ȷ�Լ��
IsFileExist "${KMEANS_EXE_PATH}" "${LOG_FILE}" "${ALARM_MAIL}" "${ALARM_MOBILE}" "${SHELL_NAME}"
IsFileExist "${KMEANS_HADOOP_PATH}" "${LOG_FILE}" "${ALARM_MAIL}" "${ALARM_MOBILE}" "${SHELL_NAME}"
if [ "${SPARSE_OR_DENSE}" != "Sparse" -a "${SPARSE_OR_DENSE}" != "Dense" ]
then
	WriteLog "FATAL: [${SHELL_NAME}] the value of SPARSE_OR_DENSE is \"SPARSE\" or \"DENSE\"" "${LOG_FILE}"
	exit 1
fi

ARGS_DATA_TYPE="${SPARSE_OR_DENSE}"
ARGS_CLUSTER_DATA_TYPE="${SPARSE_OR_DENSE}"

if [ "${SPARSE_OR_DENSE}" == "Sparse" ]
then
	ARGS_DATA_STORAGE_TYPE="RandomAccessSparseVector"
	ARGS_CLUSTER_STORAGE_TYPE="RandomAccessSparseVector"
fi

if [ "${SPARSE_OR_DENSE}" == "Dense" ]
then
	ARGS_DATA_STORAGE_TYPE="DenseVector"
	ARGS_CLUSTER_STORAGE_TYPE="DenseVector"
fi

if [ ! -z "${DATA_STORAGE_TYPE}" ]
then
	ARGS_DATA_STORAGE_TYPE="${DATA_STORAGE_TYPE}"
	ARGS_CLUSTER_STORAGE_TYPE="${DATA_STORAGE_TYPE}"
fi

if [ "${CENTER_TYPE/:*/}" != "RANDOM" -a "${CENTER_TYPE/:*/}" != "CANOPY" -a "${CENTER_TYPE/:*/}" != "CENTER_FILE" ]
then
	WriteLog "FATAL: [${SHELL_NAME}] the value of CENTER_TYPE is \"RANDOM\" or \"CANOPY\" or \"CENTER_FILE\"" "${LOG_FILE}"
	exit 1
fi

if [ "${CENTER_TYPE/:*/}" == "RANDOM" ]
then
	WriteLog "NOTICE: [${SHELL_NAME}] CENTER_TYPE = [RANDOM]!" "${LOG_FILE}"
	ARGS_CLUSTER_TYPE="HKMeans"
	ARGS_ISCLUSTERPRE="false"
fi

if [ "${CENTER_TYPE/:*/}" == "CENTER_FILE" ]
then
	CENTER_FILE_PATH="${CENTER_TYPE#*:}"
	CheckConfIsEmpty "CENTER_FILE_PATH" "${CENTER_FILE_PATH}" "${LOG_FILE}" "${ALARM_MAIL}" "${ALARM_MOBILE}" "${SHELL_NAME}"
	IsFileExist "${CENTER_FILE_PATH}" "${LOG_FILE}" "${ALARM_MAIL}" "${ALARM_MOBILE}" "${SHELL_NAME}"
	WriteLog "NOTICE: [${SHELL_NAME}] CENTER_FILE=[${CENTER_FILE_PATH}]!" "${LOG_FILE}"
	ARGS_CLUSTER_TYPE="Assign"
fi

if [ "${CENTER_TYPE/:*/}" == "CANOPY" ]
then
	T1=$(echo "${CENTER_TYPE#*:}" | grep -i "T1,.*:T2,.*" | sed 's/t1,\(.*\):t2,\(.*\)/\1/i')
	T2=$(echo "${CENTER_TYPE#*:}" | grep -i "T1,.*:T2,.*" | sed 's/t1,\(.*\):t2,\(.*\)/\2/i')
	if [ -z "${T1}" -o -z "${T2}" ]
	then
		WriteLog "FATAL: [${SHELL_NAME}] CANOPY T1 T2 error!" "${LOG_FILE}"
		exit 1
	fi
	WriteLog "NOTICE: [${SHELL_NAME}] CANOPY T1=[${T1}] T2=[${T2}]!" "${LOG_FILE}"
	ARGS_CLUSTER_TYPE="Canopy"
	ARGS_CLUSTER_PARAMETERS="t1,${T1}:t2,${T2}:n,${CENTER_NUM}:ow:cl:xm,sequential:im,inmemory"
fi

CENTER_NUM_TYPE1=$(echo "${CENTER_NUM}" | grep -i "^[0-9]*$" | sed 's/\([0-9]*\)/\1/i')
CENTER_NUM_TYPE2=$(echo "${CENTER_NUM}" | grep -i "^LINES\/[0-9]*$" | sed 's/LINES\/\([0-9]*\)/\1/i')

if [ -z "${CENTER_NUM_TYPE1}" -a -z "${CENTER_NUM_TYPE2}" ]
then
	WriteLog "FATAL: [${SHELL_NAME}] CENTER_NUM  error!" "${LOG_FILE}"
	exit 1
fi

if [ ! -z "${CENTER_NUM_TYPE1}" ]
then
	CENTER_NUM_TYPE=1
	CENTER_NUM=$CENTER_NUM_TYPE1
	WriteLog "NOTICE: [${SHELL_NAME}] CENTER_NUM_TYPE1 [${CENTER_NUM}]!" "${LOG_FILE}"
fi

if [ ! -z "${CENTER_NUM_TYPE2}" ]
then
	CENTER_NUM_TYPE=2
	CENTER_NUM=$CENTER_NUM_TYPE2
	WriteLog "NOTICE: [${SHELL_NAME}] CENTER_NUM_TYPE2 [${CENTER_NUM}]!" "${LOG_FILE}"
fi

if [ ${CENTER_NUM} -le 0 ]
then
	WriteLog "FATAL: [${SHELL_NAME}] CENTER_NUM[${CENTER_NUM}] <=0  error!" "${LOG_FILE}"
	exit 1
fi
# ++++++++++++++++++++++++++++++++++++++++++++++++
##################################################
# ��鲢��������Ŀ¼
CheckPath "${SYS_DATA_DIR}"  "${LOG_FILE}" "${ALARM_MAIL}" "${ALARM_MOBILE}" "${SHELL_NAME}"
##################################################
WriteLog "NOTICE: [${SHELL_NAME}] pass the conf check!" "${LOG_FILE}"
##################################################
# ����������
# �޸Ĵ��루��Ҫ������������м��ʱ���޸Ĵ˴����룩
# ++++++++++++++++++++++++++++++++++++++++++++++++
# �����ļ���Ŀ����,ע�͵���һ�У�������������
#INPUT_FILE_NUM=1
INPUT_PATHS=${INPUT_PATHS//\"/} 
INPUT_PATHS=${INPUT_PATHS//,/ } 
if [ ! -z "${INPUT_PATHS}" ]
then
	idx=0
	VAR=(${INPUT_PATHS})
	loop=${#VAR[@]}
	if [ ! -z "${INPUT_FILE_NUM}" -a "$loop" != "${INPUT_FILE_NUM}" ]
	then
		WriteLog "FATAL: [${SHELL_NAME}] INPUT_PATHS should have ${INPUT_FILE_NUM} file!" "${LOG_FILE}"
		exit 1;
	fi

	while [ $idx -lt $loop ]
	do
		WriteLog "NOTICE: [${SHELL_NAME}] INPUT:${VAR[$idx]}" "${LOG_FILE}"
		IsFileExist "${VAR[$idx]}" "${LOG_FILE}" "${ALARM_MAIL}" "${ALARM_MOBILE}" "${SHELL_NAME}"
		idx=`expr $idx + 1`
	done	
fi

# ����ļ���Ŀ¼��Ŀ���ƣ�ע�͵���һ�У������������
OUTPUT_FILE_OR_DIR_NUM=2
OUTPUT_PATHS=${OUTPUT_PATHS//\"/}
OUTPUT_PATHS=${OUTPUT_PATHS//,/ }
if [ ! -z "${OUTPUT_PATHS}" ]
then
	idx=0
	VAR=(${OUTPUT_PATHS})
	loop=${#VAR[@]}
	if [ ! -z "${OUTPUT_FILE_OR_DIR_NUM}" -a "$loop" != "${OUTPUT_FILE_OR_DIR_NUM}" ]
	then
		WriteLog "FATAL: [${SHELL_NAME}] OUTPUT_PATHS should have ${OUTPUT_FILE_OR_DIR_NUM} dir!" "${LOG_FILE}"
		exit 1
	fi

	while [ $idx -lt $loop ]
	do
		WriteLog "NOTICE: [${SHELL_NAME}] OUTPUT:${VAR[$idx]}" "${LOG_FILE}"
		CheckPath "${VAR[$idx]}"  "${LOG_FILE}" "${ALARM_MAIL}" "${ALARM_MOBILE}" "${SHELL_NAME}"
		idx=`expr $idx + 1`
	done
fi

# ��һ�������ĵ��ļ�Ŀ¼
CENTER_FILE_DIR=${VAR[0]}
# �ڶ����ǽ���ļ�Ŀ¼
RESULT_FILE_DIR=${VAR[1]}

# ��������˶���̣���ô��ʼ������
if [ ! -z "${THREAD_NUM}" ]
then
	WriteLog "NOTICE: [${SHELL_NAME}] MULTI THREAD" "${LOG_FILE}"
	TEMP_FIFOFILE="/tmp/$$.fifo"
	mkfifo "$TEMP_FIFOFILE"
	exec 6<>"$TEMP_FIFOFILE"
	for((i=0;i<$THREAD_NUM;i++))
	do
		echo
	done >&6
fi

# ++++++++++++++++++++++++++++++++++++++++++++++++
##################################################
# ��Ӵ���
# ++++++++++++++++++++++++++++++++++++++++++++++++
WriteLog "NOTICE: [${SHELL_NAME}] SPARSE_OR_DENSE=[${SPARSE_OR_DENSE}], CENTER_TYPE=[${CENTER_TYPE}], THRESH_CONVER=[${THRESH_CONVER}], K_TIMES=[${K_TIMES}], CENTER_NUM=[${CENTER_NUM}]" "${LOG_FILE}"
#idx=0
idy=0
VAR=(${INPUT_PATHS})
loop=${#VAR[@]}
#while [ $idx -lt $loop ]
for INPUT_FILE in ${VAR[*]}
do
	WriteLog "INPUT:${INPUT_FILE}" "${LOG_FILE}"
	FILE_NAME="${INPUT_FILE##*/}"
	CENTER_RES_FILE="${CENTER_FILE_DIR}/${FILE_NAME}${CENTER_FILE_SUBFIX}"
	RESULT_FILE="${RESULT_FILE_DIR}/${FILE_NAME}${RESULT_FILE_SUBFIX}"

	DATA_DATE_ROOT_PATH="${KMEANS_ROOT_PATH}/${SYS_DATE}"
	ARGS_INPUT="${KMEANS_ROOT_PATH}/${SYS_DATE}/${FILE_NAME}/input"
	ARGS_OUTPUT="${KMEANS_ROOT_PATH}/${SYS_DATE}/${FILE_NAME}/output"
	ARGS_CLUSTER="${KMEANS_ROOT_PATH}/${SYS_DATE}/${FILE_NAME}/center"

	KMEANS_OUTPUT_CLUSTER_RESULT="${ARGS_OUTPUT}/ClassificationFinal/result.out"
	KMEANS_OUTPUT_CLUSTER_CENTER="${ARGS_OUTPUT}/ClusterFinal/clusters.out"
	
	# ���hadoop��·������������ڣ���ô�����˳�
	`${KMEANS_HADOOP_PATH} fs -test -d ${KMEANS_ROOT_PATH}  >> "${LOG_FILE}" 2>&1`
	if [ 0 -ne $? ]
	then
		WriteLog "FATAL: [${SHELL_NAME}] KMEANS_ROOT_PATH [${KMEANS_ROOT_PATH}] not exist, program stop!" "${LOG_FILE}"
		exit 1
	fi
	# ------------------------------------------------
	# ���þ�������ARGS_K,ARGS_CLUSTER_PARAMETERS
	INPUT_FILE_LINES=$(wc -l ${INPUT_FILE} | awk '{print $1}')
	WriteLog "NOTICE: [${SHELL_NAME}] INPUT_FILE_LINES=[${INPUT_FILE_LINES}]" "${LOG_FILE}"
	if [ ${INPUT_FILE_LINES} -lt 0 ]
	then
		WriteLog "FATAL: [${SHELL_NAME}] INPUT_FILE_LINES=[${INPUT_FILE_LINES}] < 0!" "${LOG_FILE}"
		exit 1
	fi

	# ��������ļ�Ϊ�գ���ô�����յĽ���ļ��Ϳյ����ĵ��ļ�
	if [ ${INPUT_FILE_LINES} -eq 0 ]
	then
		WriteLog "NOTICE: [${SHELL_NAME}] INPUT_FILE_LINES=[${INPUT_FILE_LINES}] == 0!" "${LOG_FILE}"
		> ${CENTER_RES_FILE}
		> ${RESULT_FILE}
		continue
	fi

	if [ ${CENTER_NUM_TYPE} -eq 1 ]
	then
		ARGS_K="${CENTER_NUM}"
	fi
	
	if [ ${CENTER_NUM_TYPE} -eq 2 ]
	then
		ARGS_K=`expr ${INPUT_FILE_LINES} / ${CENTER_NUM}`
	fi
	
	if [ "${CENTER_TYPE/:*/}" == "CANOPY" ]
	then
		ARGS_CLUSTER_PARAMETERS="t1,${T1}:t2,${T2}:n,${ARGS_K}:ow:cl:xm,sequential:im,inmemory"
	fi

	if [ ${ARGS_K} -le  1 ]
	then
		WriteLog "NOTICE: [${SHELL_NAME}] ARGS_K[${ARGS_K}] <= 1!" "${LOG_FILE}"
		> ${CENTER_RES_FILE}
		awk 'BEGIN{FS=OFS="\t"}{print $0,0}' "${INPUT_FILE}" > "${RESULT_FILE}"
		if [ 0 -ne $? ]
		then
			WriteLog "FATAL: [${SHELL_NAME}] [awk 'BEGIN{FS=OFS=\"\t\"}{print \$0,0}' ${INPUT_FILE} > ${RESULT_FILE}] error!" "${LOG_FILE}"
			exit 1
		fi
		continue
	fi
	WriteLog "NOTICE: [${SHELL_NAME}] ARGS_K=[${ARGS_K}], ARGS_CLUSTER_PARAMETERS=[${ARGS_CLUSTER_PARAMETERS}]!" "${LOG_FILE}"
	FILE_NAME_LIST[$idy]="${FILE_NAME}"
	idy=`expr $idy + 1`

	# ����Ƿ���TRACK�ļ���
	TRACK_PAT="cluster_${FILE_NAME}_${SYS_DATE},"
	if [ -f "${TRACK_FILE}" ]
	then
		if [ "" != "$(grep -i ${TRACK_PAT} ${TRACK_FILE})" ]
		then
			WriteLog "NOTICE: [${SHELL_NAME}] ${INPUT_FILE} already clustered, ignored here!" "${LOG_FILE}"
			continue
		fi
	fi
	
	# ��� HADOOP����Ŀ¼
	# �������·����������ڣ���ôɾ��
	I=1
	while [ ${I} -le 3 ]
	do
		`${KMEANS_HADOOP_PATH} fs -test -d ${ARGS_INPUT} >> "${LOG_FILE}" 2>&1`
		if [ 0 -eq $? ]
		then
			WriteLog "NOTICE: [${SHELL_NAME}] INPUT_PATH [${ARGS_INPUT}] already exist, delete it!" "${LOG_FILE}"
			`${KMEANS_HADOOP_PATH} fs -rmr ${ARGS_INPUT}  >> "${LOG_FILE}" 2>&1`
			if [ 0 -ne $? ]
			then
				WriteLog "WARNING: [${SHELL_NAME}] [${KMEANS_HADOOP_PATH} fs -rmr ${ARGS_INPUT}] error!" "${LOG_FILE}"
			else
				break
			fi
		else
			break
		fi
		((I++))
	done
	
	if [ $I -gt 3 ]
	then
		WriteLog "FATAL: [${SHELL_NAME}] [${KMEANS_HADOOP_PATH} fs -rmr ${ARGS_INPUT}] error!" "${LOG_FILE}"
		exit 1
	fi
	
	# ��������·��
	`${KMEANS_HADOOP_PATH} fs -mkdir ${ARGS_INPUT} >> "${LOG_FILE}" 2>&1`
	if [ 0 -ne $? ]
	then
		WriteLog "FATAL: [${SHELL_NAME}] [${KMEANS_HADOOP_PATH} fs -mkdir ${ARGS_INPUT}] error!" "${LOG_FILE}"
		exit 1
	fi
	
	# ������·����������ڣ���ôɾ��
	I=1
	while [ ${I} -le 3 ]
	do
		`${KMEANS_HADOOP_PATH} fs -test -d ${ARGS_OUTPUT} >> "${LOG_FILE}" 2>&1`
		if [ 0 -eq $? ]
		then
			WriteLog "NOTICE: [${SHELL_NAME}] OUTPUT_PATH [${ARGS_OUTPUT}] already exist, delete it!" "${LOG_FILE}"
			`${KMEANS_HADOOP_PATH} fs -rmr ${ARGS_OUTPUT} >> "${LOG_FILE}"`
			if [ 0 -ne $? ]
			then
				WriteLog "WARNING: [${SHELL_NAME}] [${KMEANS_HADOOP_PATH} fs -rmr ${ARGS_OUTPUT}] error!" "${LOG_FILE}"
			else
				break
			fi
		else
			break
		fi
		((I++))
	done
	
	if [ $I -gt 3 ]
	then
		WriteLog "FATAL: [${SHELL_NAME}] [${KMEANS_HADOOP_PATH} fs -rmr ${ARGS_OUTPUT}] error!" "${LOG_FILE}"
		exit 1
	fi
	
	# ������ĵ�·����������ڣ���ôɾ��
	I=1
	while [ ${I} -le 3 ]
	do
		`${KMEANS_HADOOP_PATH} fs -test -d ${ARGS_CLUSTER}  >> "${LOG_FILE}" 2>&1`
		if [ 0 -eq $? ]
		then
			WriteLog "NOTICE: [${SHELL_NAME}] CENTER_PATH [${ARGS_CLUSTER}] already exist, delete it!" "${LOG_FILE}"
			`${KMEANS_HADOOP_PATH} fs -rmr ${ARGS_CLUSTER} >> "${LOG_FILE}" 2>&1`
			if [ 0 -ne $? ]
			then
				WriteLog "WARNING: [${SHELL_NAME}] [${KMEANS_HADOOP_PATH} fs -rmr ${ARGS_CLUSTER}] error!" "${LOG_FILE}"
			else
				break
			fi
		else
			break
		fi
		((I++))
	done
	
	if [ $I -gt 3 ]
	then
		WriteLog "FATAL: [${SHELL_NAME}] [${KMEANS_HADOOP_PATH} fs -rmr ${ARGS_CLUSTER}] error!" "${LOG_FILE}"
		exit 1
	fi

	# �������ĵ�·��
	`${KMEANS_HADOOP_PATH} fs -mkdir ${ARGS_CLUSTER} >> "${LOG_FILE}" 2>&1`
	if [ 0 -ne $? ]
	then
		WriteLog "FATAL: [${SHELL_NAME}] [${KMEANS_HADOOP_PATH} fs -mkdir ${ARGS_CLUSTER}] error!" "${LOG_FILE}"
		exit 1
	fi

	# �������ļ����͵�����·��
	`${KMEANS_HADOOP_PATH} fs -put ${INPUT_FILE} ${ARGS_INPUT}  >> "${LOG_FILE}" 2>&1`
	if [ 0 -ne $? ]
	then
		WriteLog "FATAL: [${SHELL_NAME}] [${KMEANS_HADOOP_PATH} fs -put ${INPUT_FILE} ${ARGS_INPUT}] error!" "${LOG_FILE}"
		exit 1
	fi
	# �����ָ�����ĵ��ļ�ģʽ����ô�����ĵ��ļ��ϴ�
	if [ "${CENTER_TYPE/:*/}" == "CENTER_FILE" ]
	then
		CENTER_FILE_PATH="${CENTER_TYPE#*:}"
		`${KMEANS_HADOOP_PATH} fs -put ${CENTER_FILE_PATH} ${ARGS_CLUSTER}  >> "${LOG_FILE}" 2>&1`
		if [ 0 -ne $? ]
		then
			WriteLog "FATAL: [${SHELL_NAME}] [${KMEANS_HADOOP_PATH} fs -put ${CENTER_FILE_PATH} ${ARGS_CLUSTER}] error!" "${LOG_FILE}"
			exit 1
		fi
	fi

	# ϡ�����ݣ�����ARGS_VECTOR_SIZE
	if [ "${SPARSE_OR_DENSE}" == "Sparse" ]
	then
		ARGS_VECTOR_SIZE=`awk ' \
		BEGIN{ \
			FS=OFS="\t";\
			pid=0; \
		} \
		{ \
			for(i=1;i<NF/2;i++) \
			{ \
				if($(2*i) > pid) \
				{ \
					pid=$(2*i); \
				} \
			} \
		} \
		END{ \
			print pid; \
		}' "${INPUT_FILE}" "${CENTER_FILE_PATH}"`
	fi

	# ���о��๤��
	THE_PARAM=" ${KMEANS_EXE_PARAM} -ARGS_INPUT ${ARGS_INPUT} -ARGS_OUTPUT ${ARGS_OUTPUT} -ARGS_CLUSTER ${ARGS_CLUSTER} -ARGS_DATA_TYPE ${ARGS_DATA_TYPE} -ARGS_CLUSTER_DATA_TYPE ${ARGS_CLUSTER_DATA_TYPE} -ARGS_CLUSTER_TYPE ${ARGS_CLUSTER_TYPE} -ARGS_CLUSTER_PARAMETERS ${ARGS_CLUSTER_PARAMETERS} -ARGS_DATA_STORAGE_TYPE ${ARGS_DATA_STORAGE_TYPE} -ARGS_CLUSTER_STORAGE_TYPE ${ARGS_CLUSTER_STORAGE_TYPE} -ARGS_ISDATAPRE ${ARGS_ISDATAPRE} -ARGS_ISCLUSTERPRE ${ARGS_ISCLUSTERPRE} -ARGS_VECTOR_SIZE ${ARGS_VECTOR_SIZE} -ARGS_ISCLASSIFY ${ARGS_ISCLASSIFY} -ARGS_XM ${ARGS_XM} -ARGS_X ${ARGS_X} -ARGS_K ${ARGS_K} -ARGS_CD ${ARGS_CD} -ARGS_DM ${ARGS_DM} -ARGS_OW ${ARGS_OW}"
	WriteLog "NOTICE: [${SHELL_NAME}] [${KMEANS_EXE_PATH} ${THE_PARAM}]" "${LOG_FILE}"
	# ��������˶����
	if [ ! -z "${THREAD_NUM}" ]
	then
		read -u 6
		{
			sh ${KMEANS_EXE_PATH} ${THE_PARAM} >> ${LOG_FILE} 2>&1
			if [ 0 -ne $? ]
			then
				WriteLog "FATAL: [${SHELL_NAME}] [${KMEANS_EXE_PATH}] [$!] run error!" "${LOG_FILE}"
				exit 1
			else
				echo "${TRACK_PAT}" >> ${TRACK_FILE}
			fi
			sleep 3
			echo >&6
		}&
		THREAD_PID=$!
		WriteLog "NOTICE: [${SHELL_NAME}] [${KMEANS_EXE_PATH}] [pid="$THREAD_PID"] [INPUT="$INPUT_FILE"]" "${LOG_FILE}"
	else
		sh ${KMEANS_EXE_PATH} ${THE_PARAM} >> ${LOG_FILE} 2>&1
		if [ 0 -ne $? ]
		then
			WriteLog "FATAL: [${SHELL_NAME}] [${KMEANS_EXE_PATH}] run error!" "${LOG_FILE}"
			exit 1
		else
			echo "${TRACK_PAT}" >> ${TRACK_FILE}
		fi
	fi

	# ------------------------------------------------
done

# ��������˶����
if [ ! -z "${THREAD_NUM}" ]
then
	# �ȴ����н����˳�
	wait
	# ɾ���ܵ�
	exec 6>&-
fi


for FILE_NAME in ${FILE_NAME_LIST[*]}
do
	# ����Ƿ���TRACK�ļ���
	TRACK_PAT="get_result_${FILE_NAME}_${SYS_DATE},"
	if [ -f "${TRACK_FILE}" ]
	then
		if [ "" != "$(grep -i ${TRACK_PAT} ${TRACK_FILE})" ]
		then
			WriteLog "NOTICE: [${SHELL_NAME}] ${INPUT_FILE} already get to local, ignored here!" "${LOG_FILE}"
			continue
		fi
	fi

	CENTER_RES_FILE="${CENTER_FILE_DIR}/${FILE_NAME}${CENTER_FILE_SUBFIX}"
	RESULT_FILE="${RESULT_FILE_DIR}/${FILE_NAME}${RESULT_FILE_SUBFIX}"
	ARGS_OUTPUT="${KMEANS_ROOT_PATH}/${SYS_DATE}/${FILE_NAME}/output"
	KMEANS_OUTPUT_CLUSTER_RESULT="${ARGS_OUTPUT}/ClassificationFinal/result.out"
	KMEANS_OUTPUT_CLUSTER_CENTER="${ARGS_OUTPUT}/ClusterFinal/clusters.out"
	
	# �����ĵ��ļ���hadoop�����ص�����·����
	if [ ${K_TIMES} -gt 0 ]
	then
		WriteLog "NOTICE: [${SHELL_NAME}] [${KMEANS_HADOOP_PATH} fs -test -e ${KMEANS_OUTPUT_CLUSTER_CENTER}]" "${LOG_FILE}"
		`${KMEANS_HADOOP_PATH} fs -test -e ${KMEANS_OUTPUT_CLUSTER_CENTER} >> "${LOG_FILE}" 2>&1`
		if [ 0 -ne $? ]
		then
			WriteLog "WARNING: [${SHELL_NAME}] [${KMEANS_OUTPUT_CLUSTER_CENTER}] doesn't exist!" "${LOG_FILE}"
			TRACK_PAT="_${FILE_NAME}_${SYS_DATE},"
			cp ${TRACK_FILE} ${TRACK_FILE}.bak
			grep -iv ${TRACK_PAT} ${TRACK_FILE}.bak > ${TRACK_FILE}
			exit 1
		fi
		WriteLog "NOTICE: [${SHELL_NAME}] [${KMEANS_HADOOP_PATH} fs -cat ${KMEANS_OUTPUT_CLUSTER_CENTER} > ${CENTER_RES_FILE}]" "${LOG_FILE}"
		`${KMEANS_HADOOP_PATH} fs -cat ${KMEANS_OUTPUT_CLUSTER_CENTER} > ${CENTER_RES_FILE}`
		if [ 0 -ne $? ]
		then
			WriteLog "WARNING: [${SHELL_NAME}] [${KMEANS_HADOOP_PATH} fs -cat ${KMEANS_OUTPUT_CLUSTER_CENTER} > ${CENTER_RES_FILE}] error!" "${LOG_FILE}"
			exit 1
		fi
	fi

	# �������ļ���hadoop�����ص�����·����
	WriteLog "NOTICE: [${SHELL_NAME}] [${KMEANS_HADOOP_PATH} fs -test -e ${KMEANS_OUTPUT_CLUSTER_RESULT}]" "${LOG_FILE}"
	`${KMEANS_HADOOP_PATH} fs -test -e ${KMEANS_OUTPUT_CLUSTER_RESULT} >> "${LOG_FILE}" 2>&1`
	if [ 0 -ne $? ]
	then
		WriteLog "WARNING: [${SHELL_NAME}] [${KMEANS_OUTPUT_CLUSTER_RESULT}] doesn't exist!" "${LOG_FILE}"
		TRACK_PAT="_${FILE_NAME}_${SYS_DATE},"
		cp ${TRACK_FILE} ${TRACK_FILE}.bak
		grep -iv ${TRACK_PAT} ${TRACK_FILE}.bak > ${TRACK_FILE}
		exit 1
	fi
	WriteLog "NOTICE: [${SHELL_NAME}] [${KMEANS_HADOOP_PATH} fs -cat ${KMEANS_OUTPUT_CLUSTER_RESULT} > ${RESULT_FILE}]" "${LOG_FILE}"
	`${KMEANS_HADOOP_PATH} fs -cat ${KMEANS_OUTPUT_CLUSTER_RESULT} > ${RESULT_FILE}`
	if [ 0 -ne $? ]
	then
		WriteLog "WARNING: [${SHELL_NAME}] [${KMEANS_HADOOP_PATH} fs -cat ${KMEANS_OUTPUT_CLUSTER_RESULT} > ${RESULT_FILE}] error!" "${LOG_FILE}"
		exit 1
	fi
	echo "${TRACK_PAT}" >> ${TRACK_FILE}
done

if [ ! -z "${DELETE_DATA}" -a "${DELETE_DATA}" == "1" ]
then
	WriteLog "NOTICE: [${SHELL_NAME}] [${KMEANS_HADOOP_PATH} fs -rmr ${DATA_DATE_ROOT_PATH}]" "${LOG_FILE}"
	`${KMEANS_HADOOP_PATH} fs -rmr ${DATA_DATE_ROOT_PATH} >> "${LOG_FILE}" 2>&1`
	if [ 0 -ne $? ]
	then
		WriteLog "WARNING: [${SHELL_NAME}] [${KMEANS_HADOOP_PATH} fs -rmr ${DATA_DATE_ROOT_PATH}] error!" "${LOG_FILE}"
	fi
fi
# ++++++++++++++++++++++++++++++++++++++++++++++++
##################################################
WriteLog "NOTICE: [${SHELL_NAME}] algorithm finished successfully~!" "${LOG_FILE}"
WriteLog "--------------------------------------------------" "${LOG_FILE}"
##################################################
