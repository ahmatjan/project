#!/bin/bash

##! @TODO: hadoop reducer
##! @VERSION: 1.0.0.0
##! @AUTHOR: yangkai04@baidu.com
##! @BRIEF: 将mapper中统计输出的信息进行汇总

set -o pipefail

awk 'BEGIN \
{
    FS=OFS="\t";
    lastsite = "";
    sumcnt = 0;
}
{
    # 输入数据格式: site \t cnt
    site = $1;
    cnt = $2;
    if (site != lastsite) 
    {
        if (lastsite != "")
        {
            print lastsite, sumcnt;
        }
        lastsite = site;
        sumcnt = 0;
    }
    sumcnt += cnt;
}
END \
{
    if (lastsite != "")
    {
        print lastsite, sumcnt;
    }
}'

if [ $? -ne 0 ]
then
    RET_VALUE=$?
    echo -e "FATAL: $0 run error." >> "/dev/stderr"
    exit ${RET_VALUE}
fi
