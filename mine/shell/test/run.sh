#!/bin/bash

HADOOP_PATH="/app/ecom/dashboard/chg"

hadoop fs -test -d "${HADOOP_PATH}"
if [ 0 -ne $? ]
then
	echo "${HADOOP_PATH} doesn't exist! We need to create it!"
	hadoop fs -mkdir ${HADOOP_PATH}
	if [ 0 -ne $? ]
	then
		echo "hadoop fs -mkdir ${HADOOP_PATH} faild!"
		exit 1
	fi
fi

exit 0

PROGRAM_NAME="hadoopTest"

INPUT_FILES="/log/22303/dr_dorado_dbdcharge_bd_anti/20110706/????/*/dcharge.bd.20110706-????.log"

OUTPUT_DIR="${HADOOP_PATH}/test"
hadoop fs -test -d ${OUTPUT_DIR}
if [ 0 -eq $? ]
then
        echo "${OUTPUT_DIR} already exist! We need to remove it!"
        hadoop fs -rmr ${OUTPUT_DIR}
        if [ 0 -ne $? ]
        then
                echo "hadoop fs -rmr ${OUTPUT_DIR} faild!"
                exit 1
        fi
fi

hadoop streaming \
-D mapred.job.name="${PROGRAM_NAME}" \
-D stream.num.map.output.key.fields=1 \
-input ${INPUT_FILES} \
-output ${OUTPUT_DIR} \
-numReduceTasks 20 \
-jobconf mapred.job.map.capacity="40" \
-mapper	"mapper.sh" \
-reducer "reducer.sh" \
-file "mapper.sh" \
-file "reducer.sh"

if [ 0 -eq $? ]
then
	echo "success!"
else
	echo "failed!"
fi

sh download.sh
