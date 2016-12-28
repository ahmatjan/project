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
# 2 restart computer
# 3 connet to the network
function step_network() {
    if [[ ! -f "./anyconnect-64.sh" ]]; then
        wget http://pac.internal.baidu.com/bin/anyconnect-64.sh
    fi
    sudo bash anyconnect-64.sh 
    mkdir ~/bin
    echo -e "#!/bin/bash\n\n/opt/cisco/anyconnect/bin/vpnui &" > ~/bin/connect
    chmod 755 ~/bin/connect
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
    echo "source ${BASH_PROFILE}"
}

function step_tools() {
    sudo apt-get install openssh-server && \
    sudo apt-get install lrzsz
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
    cp vimrc ~/.vimrc
}

function step_libs() {
    sudo apt-get install autoconf automake libtool curl make g++ unzip && \
    sudo apt-get install libgflags-dev && \
    sudo apt-get install libgoogle-glog-dev && \
    sudo apt-get install libgtest-dev && \
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
    cp -r .ssh/* ~/.ssh/
    chmod 755 ~
    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/*
    git clone ssh://yangkai04@icode.baidu.com:8235/baidu/adu/perception ~/project/baidu/adu/perception
}

##! @TODO: 运行所有处理函数
##! @AUTHOR: yangkai04@baidu.com
##! @OUT: 0 => success; other => failed
function run_all_step() {
    echo "${FUNCNAME} start."
    ALL_STEPS="
        step_network
        step_source
        step_profile
        step_tools
        step_vim
        step_libs
        step_git
        "

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

