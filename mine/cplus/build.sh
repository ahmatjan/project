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
ROOT_PATH=`pwd`
THIRD_LIB_PATH="${ROOT_PATH}/third"
THIRD_SRC_PATH="${THIRD_LIB_PATH}/src"

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

function caffe_install() {
    CUR_LIB_NAME="caffe"
    CUR_LIB_SOURCE="https://github.com/bvlc/caffe.git"
    CMAKE_OPTION="-DCPU_ONLY=ON"
    sudo apt-get install libatlas-base-dev && \
    sudo apt-get install libprotobuf-dev && \
    sudo apt-get install libleveldb-dev && \
    sudo apt-get install libsnappy-dev && \
    sudo apt-get install libopencv-dev && \
    sudo apt-get install libboost-all-dev && \
    sudo apt-get install libhdf5-serial-dev && \
    sudo apt-get install libgflags-dev && \
    sudo apt-get install libgoogle-glog-dev && \
    sudo apt-get install liblmdb-dev && \
    sudo apt-get install protobuf-compiler && \
    sudo apt-get install cmake && \
    cmake_install && \
    mkdir -p "${CUR_LIB_LIB_PATH}/include/caffe/proto/" && \
    /usr/bin/protoc --cpp_out=${CUR_LIB_LIB_PATH}/include/caffe/proto/ -I ${CUR_LIB_SRC_PATH}/src/caffe/proto/ ${CUR_LIB_SRC_PATH}/src/caffe/proto/caffe.proto
}

function opencv_install() {
    CUR_LIB_NAME="opencv"
    CUR_LIB_SOURCE="https://github.com/opencv/opencv.git"
    CMAKE_OPTION=""
    cmake_install
}

function pcl_install() {
    CUR_LIB_NAME="pcl"
    CUR_LIB_SOURCE="https://github.com/PointCloudLibrary/pcl.git"
    CMAKE_OPTION=""
    sudo apt-get install g++ && \
    sudo apt-get install cmake cmake-gui && \
    sudo apt-get install doxygen && \
    sudo apt-get install mpi-default-dev openmpi-bin openmpi-common && \
    sudo apt-get install libflann-dev && \
    sudo apt-get install libeigen3-dev && \
    sudo apt-get install libboost-all-dev libboost-system1.55.0 && \
    sudo apt-get install libvtk5.8-qt4 libvtk5.8 libvtk5-dev libvtk-java python-vtk && \
    sudo apt-get install libqhull* && \
    sudo apt-get install libusb-dev && \
    sudo apt-get install libgtest-dev && \
    sudo apt-get install git-core freeglut3-dev pkg-config && \
    sudo apt-get install build-essential libxmu-dev libxi-dev && \
    sudo apt-get install libusb-1.0-0-dev graphviz mono-complete    
    sudo apt-get install qt-sdk openjdk-7-jdk openjdk-7-jre && \
    sudo apt-get install phonon-backend-gstreamer && \
    sudo apt-get install phonon-backend-vlc && \
    cmake_install
}

function jsoncpp_install() {
    CUR_LIB_NAME="jsoncpp"
    CUR_LIB_SOURCE="https://github.com/open-source-parsers/jsoncpp.git"
    CMAKE_OPTION=""
    cmake_install
}

function protobuf_install() {
    #sudo apt-get install autoconf automake libtool curl make g++ unzip
    CUR_LIB_NAME="protobuf"
    CUR_LIB_SOURCE="https://github.com/google/protobuf.git"
    CMAKE_OPTION=""
    configure_install
}

function stringencoders_install() {
    CUR_LIB_NAME="stringencoders"
    CUR_LIB_SOURCE="https://github.com/client9/stringencoders.git"
    CMAKE_OPTION=""
    configure_install
}

function glog_install() {
    CUR_LIB_NAME="glog"
    CUR_LIB_SOURCE="https://github.com/google/glog.git"
    CMAKE_OPTION=""
    cmake_install
}

function gtest_install() {
    CUR_LIB_NAME="gtest"
    CUR_LIB_SOURCE="https://github.com/google/googletest.git"
    CMAKE_OPTION=""
    cmake_install
}

function change_cmake_version() {
    CUR_CMAKELISTS_PATH="${CUR_LIB_SRC_PATH}/CMakeLists.txt"
    sed '/cmake_minimum_required/I s/VERSION[^)]*/VERSION 2.8/I' ${CUR_CMAKELISTS_PATH} > ${CUR_CMAKELISTS_PATH}.new
    mv ${CUR_CMAKELISTS_PATH}.new ${CUR_CMAKELISTS_PATH}
}

function cmake_install() {
    CUR_LIB_LIB_PATH="${THIRD_LIB_PATH}/${CUR_LIB_NAME}"
    CUR_LIB_SRC_PATH="${THIRD_SRC_PATH}/${CUR_LIB_NAME}"
    CUR_LIB_BUILD_PATH="${CUR_LIB_SRC_PATH}/release"
    echo "CUR_LIB_LIB_PATH : ${CUR_LIB_LIB_PATH}"
    echo "CUR_LIB_SRC_PATH : ${CUR_LIB_SRC_PATH}"
    echo "CUR_LIB_BUILD_PATH : ${CUR_LIB_BUILD_PATH}"
    if [[ ! -d "${CUR_LIB_SRC_PATH}" ]]; then
        rm -rf ${CUR_LIB_SRC_PATH} && git clone ${CUR_LIB_SOURCE} ${CUR_LIB_SRC_PATH}
        if [[ $? -ne 0 ]]; then
            cd ${ROOT_PATH}
            return 1
        fi
    else
        cd ${CUR_LIB_SRC_PATH} && git pull && cd -
        if [[ $? -ne 0 ]]; then
            cd ${ROOT_PATH}
            return 1
        fi
    fi
    change_cmake_version
    if [[ 1 -eq 1 ]]; then
        rm -rf ${CUR_LIB_BUILD_PATH} && mkdir -p ${CUR_LIB_BUILD_PATH}
        if [[ $? -ne 0 ]]; then
            cd ${ROOT_PATH}
            return 1
        fi
    fi

    rm -rf ${CUR_LIB_LIB_PATH} && \
    cd ${CUR_LIB_BUILD_PATH} && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=${CUR_LIB_LIB_PATH} ${CMAKE_OPTION} .. && \
    make -j4 && \
    make install && \
    cd -
    if [[ $? -ne 0 ]]; then
        cd ${ROOT_PATH}
        return 1
    fi
}

function configure_install() {
    CUR_LIB_LIB_PATH="${THIRD_LIB_PATH}/${CUR_LIB_NAME}"
    CUR_LIB_SRC_PATH="${THIRD_SRC_PATH}/${CUR_LIB_NAME}"
    echo "CUR_LIB_LIB_PATH : ${CUR_LIB_LIB_PATH}"
    echo "CUR_LIB_SRC_PATH : ${CUR_LIB_SRC_PATH}"
    if [[ ! -d "${CUR_LIB_SRC_PATH}" ]]; then
        rm -rf ${CUR_LIB_SRC_PATH} && git clone ${CUR_LIB_SOURCE} ${CUR_LIB_SRC_PATH}
        if [[ $? -ne 0 ]]; then
            cd ${ROOT_PATH}
            return 1
        fi
    else
        cd ${CUR_LIB_SRC_PATH} && git pull && cd -
        if [[ $? -ne 0 ]]; then
            cd ${ROOT_PATH}
            return 1
        fi
    fi

    rm -rf ${CUR_LIB_LIB_PATH} && \
    cd ${CUR_LIB_SRC_PATH} && \
    ./autogen.sh && \
    ./configure --prefix=${CUR_LIB_LIB_PATH} && \
    make -j4 && \
    make install && \
    cd -
    if [[ $? -ne 0 ]]; then
        cd ${ROOT_PATH}
        return 1
    fi
}

function tool_check() {
    sudo apt-get install git
    sudo apt-get install cmake
    sudo apt-get install autoconf automake libtool curl make g++ unzip
    sudo apt-get install libgflags-dev
    sudo apt-get install libgoogle-glog-dev
    sudo apt-get install libgtest-dev
}

##! @TODO: 运行所有处理函数
##! @AUTHOR: yangkai04@baidu.com
##! @OUT: 0 => success; other => failed
function run_all_step() {
    echo "${FUNCNAME} start."
    ALL_STEPS="
        tool_check
        glog_install
        jsoncpp_install
        protobuf_install
        opencv_install
        pcl_install
        caffe_install
        gtest_install
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

