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
}

# 6 modify root password
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
    sudo apt-get install libflann-dev
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

function step_ros() {
    grep 'source /opt/ros/indigo/setup.bash' ~/.bashrc
    if [[ $? -ne 0 ]]; then
        echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc
    fi
    sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
    sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net --recv-key 0xB01FA116 && \
    sudo rm -rf /var/lib/apt/lists/* && \ 
    sudo mkdir /var/lib/apt/lists/partial && \
    sudo apt-get update && \
    sudo apt-get install ros-indigo-desktop-full && \
    sudo rosdep init && \
    sudo rosdep update && \
    sudo apt-get install python-rosinstall python-rosdep
    #source ~/.bashrc
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
    cp ./tools/pwdftp ~/bin && \
    cp ./tools/pwdscp ~/bin && \
    cp ./tools/eagle.py ~/bin/ && \
    ~/.BCloud/bin/bcloud login -u yangkai04 -p yangkai416@
}

##! @TODO: 运行所有处理函数
##! @AUTHOR: yangkai04@baidu.com
##! @OUT: 0 => success; other => failed
function run_all_step() {
    echo "${FUNCNAME} start."
        #step_tools # 下载脚本前执行这步
    ALL_STEPS="
        step_root
        step_source
        step_profile
        step_tools
        step_vim
        step_libs
        step_git
        step_ros
        step_network
        "
        #step_baidu_tools # 连接准入后，执行这步
        #step_ros_deps # 是下载一些系统依赖，这种安装方式和apt-get有些冲突 可以不执行就不执行

    local FN_ALL_STEPS=${ALL_STEPS}
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

