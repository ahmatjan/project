#!/bin/sh

function modify()
{
    local FN_FILENAME=$1
    echo ${FN_FILENAME}
    if [ ! -f "${FN_FILENAME}" ]
    then
        return
    fi
    local FN_FILENAME_NEW="${FN_FILENAME}.tmp"
    echo ${FN_FILENAME_NEW}
    cat ${FN_FILENAME} | sed "s#wget \"ftp://cq01-testing-ecom138.vm.baidu.com:/home/work/CI/tools/build_lib.sh\"#svn export https://svn.baidu.com/app/ecom/darwin/trunk/dr-toad/toad-replica/build_lib.sh#g" > ${FN_FILENAME_NEW}
    mv ${FN_FILENAME_NEW} ${FN_FILENAME}
}

function copyto()
{
    local FN_FILENAME=$1
    echo ${FN_FILENAME}
    local FN_DIRNAME=${FN_FILENAME%/*}
    echo ${FN_DIRNAME}
    cp remake.sh ${FN_DIRNAME}/
    ls ${FN_DIRNAME}/
}

find c++/* -name "local_build.sh" | xargs grep "cq01-testing-ecom138" | awk -F":" '{print $1;}' | while read line 
do 
    echo ${line}
    modify ${line}
    #copyto ${line}
done

