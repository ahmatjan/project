#!/bin/bash

setup_dir="$HOME/.Comake2"
bin_dir="$setup_dir/comake"
comake2_url="http://buildkit.scm.baidu.com/comake2/comake2.tar.gz"
comake2_tar="comake2.tar.gz"

function download_with_retry()
{
    local _cmd=$1 
    local _file=$2
    local count=0 
    while [[ $count != 30 ]]
    do
        if [ -e $_file ]; then 
            rm -rf $_file
        fi      
        $_cmd   
        if [[ $? == 0 ]]; then
            count=30
            return 0
        else    
            count=$(( count + 1 ))
            sleep 2 
        fi      
    done    
    return 1
}

modify_path()
{
    grep -v "^#" $HOME/.bashrc | grep "PATH=$1:\$PATH" >/dev/null 2>&1
    local ret0=$?
    grep -v "^#" $HOME/.bashrc | grep "PATH=$1:\$PATH" >/dev/null 2>&1
    local ret1=$?
    local ret=$[$ret0*$ret1]
    if [ $ret -ne 0 ];then
        echo "export PATH=$1:\$PATH" >> $HOME/.bashrc
        source_path="YES"
    fi
}

if [ ! -e $setup_dir ]; then
    mkdir -p $setup_dir
    if [ $? -ne 0 ]; then
        echo "'mkdir -p $setup_dir' for comake2 error!"
        exit 1
    fi
fi

#下载comake2
cd $setup_dir
echo "setup comake2 ..."
download_with_retry "wget -q $comake2_url" $comake2_tar

if [ $? -ne 0 ]; then
    echo "get comake2 from remote error!"
    exit 2
fi

rm -rf comake && tar zxf $comake2_tar && cp comake/libcomake2/COMAKE.VERSION .
if [ $? -ne 0 ]; then
    echo "setup comake2 error!"
    rm -rf COMAKE.VERSION comake
    exit 3
fi

echo "setup comake2 success."

#加入环境变量
modify_path $bin_dir
if [ "$add_lib_path" == "YES" ]; then
    modify_ld_library_path $lib_dir
fi
if [ "$source_path" == "YES" ]; then
    echo -e "\033[;31mPlease run \033[;32msource ~/.bashrc\033[0m"
fi
