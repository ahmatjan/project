#!/bin/bash
#
# Copyright (c) 2015 Baidu.com, Inc. All Rights Reserved
#
# Author: yangkai04@baidu.com
# Date: 2016/12/26
# Brief:
#   A frame for running applications.
# Globals:
#   none
# Arguments:
#   -h  print help message
# Returns:
#   succ:0
#   fail:1

#set -x # set -o xtrace
#set -e # set -o errexit
#set -u # set -o nounset
set -o pipefail 

STEP_SERI="1"
if [[ ! -z "$1" ]]; then
    STEP_SERI="2"
fi

TRACK="./track.log"
#rm -f ${TRACK}

function print_help() {
    echo -e "Usage: $0" >&2
    echo -e "    -h  print help message" >&2
    echo -e "    http://wiki.baidu.com/display/perception/Quick+Start" >&2
    return 0
}

function get_option() {
    while getopts sohvc:t: OPTION; do
        case "${OPTION}" in
            h) print_help
            exit 0
            ;;
            *) print_help
            exit 1
            ;;
        esac
    done
    return 0
}

function init_track() {
    TRACK="./track.log"
    if [[ ! -z "${TRACK}" ]]; then
        touch ${TRACK}
    fi
    return 0
}

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

# 1 press u disk to computer, reboot computer and press F12
# 2 connect to network
# 3 init tools manually
function step_tools() {
    sudo apt-get install openssh-server && \
    sudo apt-get install lrzsz && \
    sudo apt-get install git && \
    sudo apt-get install vim
}

# 4 init nvidia manually
function step_nvidia(){
    #显卡型号：NVIDIA GeForce 730 2GB GDDR3
    #如果是uefi的主版，请关掉secure boot。启动按F2进BIOS，选择boot选项卡，disable掉secure boot
    lspci | grep -i NVIDIA
    sudo apt-get install mesa-utils
    glxinfo | grep rendering
    lsmod | grep nouveau # 发现存在nouveau
    #在/etc/modprobe.d/blacklist.conf文件中，将nouveau模块加入
    sudo reboot
    lsmod | grep nouveau #发现已经没有了
    #到http://www.geforce.cn/drivers，下载合适驱动 NVIDIA GeForce 730 2GB GDDR3
    sudo ./NVIDIA-Linux-x86_64-375.26.run -no-x-check -no-nouveau-check -no-opengl-files
    sudo service lightdm stop
    sudo service lightdm start
    nvidia-settings # 检查是否安装成功
}

# 5 init cuda manually
function step_cuda() {
    #https://developer.nvidia.com/cuda-downloads
    #wget https://developer.nvidia.com/compute/cuda/8.0/prod/local_installers/cuda_8.0.44_linux-run
    sudo sh cuda_8.0.44_linux.run
    #如果已经更新了显卡驱动，就跳过安装驱动
    #最后到example的安装目录，执行make，编译所有测试用例
    vim ~/.bashrc
    #添加  export LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH:/usr/local/cuda-8.0/lib64/
    #添加  export PATH=$PATH:/usr/local/cuda-8.0/bin/
}

# 6 init cudnn
function step_cudnn() {
    #https://developer.nvidia.com/rdp/cudnn-download
    #对应cuda版本下载对应sample
    ##安装前，cmake caffe的时候
    ##-- NVIDIA CUDA:
    ##--   Target GPU(s)     :   Auto
    ##--   GPU arch(s)       :   sm_35
    ##--   cuDNN             :   Not found
    #tar -zxvf ./tools/cudnn-7.0-linux-x64-v4.0-rc.tgz 
    tar -zxvf ./tools/cudnn-8.0-linux-x64-v5.0-ga.tgz
    sudo cp cuda/lib64/libcudnn* /usr/local/lib/
    sudo cp cuda/include/cudnn.h /usr/local/include/
    rm cuda -rf
    cd /usr/local/lib
    sudo chmod +r libcudnn.so.5.0.5
    sudo ln -sf libcudnn.so.5.0.5 libcudnn.so.5
    sudo ln -sf libcudnn.so.5 libcudnn.so
    sudo ldconfig
    cd -
    ##安装后效果，cmake caffe的时候
    ##-- NVIDIA CUDA:
    ##--   Target GPU(s)     :   Auto
    ##--   GPU arch(s)       :   sm_35
    ##--   cuDNN             :   Yes (ver. 4.0.4)
    #tar -zxvf tools/cudnn-sample-v5.tgz
    #cd mnistCUDNN/ 
    #make
    #./mnistCUDNN
    #cd ..
    #rm -rf mnistCUDNN RNN
}

function step_root() {
    sudo passwd root
    #[sudo] password for yangkai04: 
    #Enter new UNIX password: 
    #Retype new UNIX password: 
    #passwd: password updated successfully
}

function step_source() {
    sudo rm -rf /var/lib/apt/lists/* && \ 
    sudo mkdir /var/lib/apt/lists/partial && \
    sudo apt-get update  
}

function step_profile() {
    grep 'export PATH=$PATH:~/bin' ~/.bashrc
    if [[ $? -ne 0 ]]; then
        echo -e 'export PATH=$PATH:~/bin\n' >> ~/.bashrc
    fi
    BASH_PROFILE=~/.bash_profile
    if [[ ! -f "${BASH_PROFILE}" ]]; then
        touch ${BASH_PROFILE}
        echo -e "if [ -f ~/.bashrc ]; then\n. ~/.bashrc\nfi\n" > ${BASH_PROFILE}
        echo -e "if [ -f ~/.bash_order ]; then\n. ~/.bash_order\nfi\n" >> ${BASH_PROFILE}
    fi
    cp ./tools/bash_aliases ~/.bash_aliases
    #echo "source ${BASH_PROFILE}"
}

function step_vim() {
    sudo apt-get install vim && \
    sudo apt-get install exuberant-ctags && \
    sudo apt-get install vim vim-scripts vim-doc && \
    sudo apt-get install vim-addon-manager && \
    vim-addons install taglist && \
    vim-addons status && \
    vim-addons install taglist && \
    vim-addons install winmanager && \
    vim-addons install project  && \
    vim-addons status && \
    cp ./tools/vimrc ~/.vimrc
}

function step_libs() {
    sudo apt-get install cmake autoconf automake libtool curl make g++ unzip && \
    sudo apt-get install libgflags-dev && \
    sudo apt-get install libgoogle-glog-dev && \
    sudo apt-get install libgtest-dev && \
    cd /usr/src/gtest && \
    sudo cmake CMakeLists.txt && \
    sudo make && \
    sudo cp *.a /usr/lib/ && \
    cd - && \
    sudo apt-get install libeigen3-dev && \
    sudo apt-get install libflann-dev && \
    sudo apt-get install libproj-dev
}

function step_git() {
    sudo apt-get install git && \
    git config --global user.email yangck0410672@163.com && \
    git config --global user.name yangkai04 && \
    #git clone https://github.com/yangkai04/project.git ~/project
    #git add xxx
    #git commit -m"xxx"
    #git push
    mkdir -p ~/.ssh
    cp -r ./tools/ssh/* ~/.ssh/
    chmod 755 ~
    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/*
}

function step_ros_deps() {
    # 先执行前面配好的connect，连接内网进行
    ROS_DEPS_PATH="./tools/ros_deps"
    ROS_DEPS_DATA_PATH="${ROS_DEPS_PATH}/data"
    mkdir -p ${ROS_DEPS_DATA_PATH}
    while read -r line; do
	    echo ${line}
	    srcpath="http://buildkit.scm.baidu.com/adu-deps/${line}"
	    dstpath="${ROS_DEPS_DATA_PATH}/${line}"
	    wget ${srcpath} -O ${dstpath}
	    sudo dpkg -i ${dstpath}
    done <"${ROS_DEPS_PATH}/ros_drivers_deps.list"
    return 0
}

function step_ros1() {
    grep 'source /opt/ros/indigo/setup.bash' ~/.bashrc
    if [[ $? -ne 0 ]]; then
        echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc
    fi
    sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
    sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net --recv-key 0xB01FA116 && \
    sudo rm -rf /var/lib/apt/lists/* && \ 
    sudo mkdir /var/lib/apt/lists/partial && \
    sudo apt-get update
}

function step_ros2() {
    sudo apt-get install ros-indigo-desktop-full
}

function step_ros3() {
    source ~/.bashrc && \
    sudo rosdep init && \
    sudo rosdep update
}

function step_ros4() {
    sudo apt-get install python-rosinstall python-rosdep
}

# connect to zhunru
function step_network() {
    ANYCONNECT_FILE="./tools/anyconnect-64.sh"
    if [[ ! -f "${ANYCONNECT_FILE}" ]]; then
        wget http://pac.internal.baidu.com/bin/anyconnect-64.sh -O ${ANYCONNECT_FILE}
    fi
    sudo bash ${ANYCONNECT_FILE}
    mkdir -p ~/bin
    echo -e "#!/bin/bash\n\n/opt/cisco/anyconnect/bin/vpnui &" > ~/bin/connect
    chmod 755 ~/bin/connect
    # ~/bin/connect
    #在弹出的界面中填入：izhunru.baidu.com
    #点击设置：全部不选中
    #点击Connect anyway，输入用户名和密码（PIN+TOKEN）即可
}

function step_baidu_tools() {
    #grep 'export PATH=${HOME}/.Comake2/comake:${HOME}/.BCloud/bin:$PATH' ~/.bashrc
    #if [[ $? -ne 0 ]]; then
    #    echo -e 'export PATH=${HOME}/.Comake2/comake:${HOME}/.BCloud/bin:$PATH' >> ~/.bashrc
    #fi
    #wget http://buildkit.scm.baidu.com/comake2/install_comake2.sh
    #wget http://buildkit.scm.baidu.com/bcloud/package/install.sh
    #wget http://fatcat.baidu.com/ota/download/eagle.py
    git clone ssh://yangkai04@icode.baidu.com:8235/baidu/adu/perception ~/project/baidu/adu/perception && \
    bash ./tools/install_comake2.sh && \
    bash ./tools/install_bcloud.sh && \
    chmod 755 ./tools/eagle.py && \
    chmod 755 ./tools/pwdftp && \
    chmod 755 ./tools/pwdscp && \
    chmod 755 ./tools/my* && \
    cp ./tools/pwdftp ~/bin && \
    cp ./tools/pwdscp ~/bin && \
    cp ./tools/eagle.py ~/bin/ && \
    cp ./tools/my* ~/bin/ && \
    ~/.BCloud/bin/bcloud login -u yangkai04 -p yangkai416@
}

function step_matlab() {
    #在Ubuntu14.04下安装matlab2014a以及破解
    #2015-10-12 18:41 2574人阅读 评论(0) 收藏 举报
    #版权声明：本文为博主原创文章，未经博主允许不得转载。
    #
    #目录(?)[+]
    #下载matlab安装包
    #
    #从网盘上下载安装包以及Crack
    #Crack中包含license和破解文件
    #解压得到iso镜像,并挂载到linux
    #
    #$sudo mkdir /download/temp_matlab (此文件夹用于临时存放挂载后的iso文件)
    #$sudo mount -o loop /path/MATHWORKS_R2014A.iso /download/temp_matlab (path为我们存放iso的路径)
    #安装
    #
    #$cd /download/temp_matlab
    #$sudo ./install
    #选择不联网安装
    #安装过程中使用序列号
    #
    #12345-67890-12345-67890
    #激活
    #
    #安装完成之后选择Crack下的license_405329_R2014a.lic文件进行激活
    #破解
    #
    #由于/usr/local/MATLAB只有只读的权限, 所以先要将其权限修改为”可写”
    #$sudo chmod -R a+w /usr/local/MATLAB
    #将Crack/Linux下的libmwservices.so 复制到 /usr/local/MATLAB/R2014A/bin/glnxa64
    #将先前挂载的iso卸载
    #
    #sudo umount /download/temp_matlab
    #启动matlab
    #
    #sudo matlab
    return 0
}

##! @TODO: 运行所有处理函数
##! @AUTHOR: yangkai04@baidu.com
##! @OUT: 0 => success; other => failed
function run_all_step() {
    echo "${FUNCNAME} start."
        #step_tools # 下载脚本前执行这步
    ALL_STEPS1="
        step_cudnn
        step_root
        step_source
        step_profile
        step_tools
        step_vim
        step_libs
        step_git
        step_ros1
        step_ros2
        step_ros3
        step_ros4
        step_network
        "
    ALL_STEPS2="
        step_baidu_tools
        "
        #step_baidu_tools # 连接准入后，执行这步
        #step_ros_deps # 是下载一些系统依赖，这种安装方式和apt-get有些冲突 可以不执行就不执行

    local FN_ALL_STEPS=${ALL_STEPS1}
    if [[ "${STEP_SERI}" == "2" ]]; then
        FN_ALL_STEPS=${ALL_STEPS2}
    fi
    for step in ${FN_ALL_STEPS}; do
        STEP_START_TIME=`date +"%Y-%m-%d %H:%M:%S"`
        STEP_START_TIME_SEC=`date +"%s"`
        local FN_TRACK_MSG="${step}"
        check_track "${FN_TRACK_MSG}"
        if [[ $? -ne 0 ]]; then
            echo "${FN_TRACK_MSG} already run, not to run again."
            continue
        fi
        echo "${step} start."
        ${step}
        if [[ $? -ne 0 ]]; then
            echo "${FN_TRACK_MSG} run error."
            exit 1
        else
            echo -e "${FN_TRACK_MSG}" >> ${TRACK}
        fi
        local FN_END_TIME_SEC=`date +"%s"`
        local FN_RUN_TIME=`expr ${FN_END_TIME_SEC} - ${STEP_START_TIME_SEC}`
        echo "${step} finished. run time[${FN_RUN_TIME}]"
    done
    echo "${FUNCNAME} finished."
    return 0
}

##! @TODO: 程序入口.
##! @AUTHOR: yangkai04@baidu.com
##! @OUT: 0 => success; other => failed
function frame_main() {
    get_option "$@"
    echo "PROGRAM BEGIN."
    run_all_step
    echo "PROGRAM END."
    return 0
}

frame_main "$@"
exit $?

