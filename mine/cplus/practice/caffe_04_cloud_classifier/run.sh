#!/bin/bash

CAFFE_SRC_ROOT="/home/yangkai04/project/mine/cplus/third/src/caffe"
CAFFE="${CAFFE_SRC_ROOT}/build/tools/caffe"
CAFFE_BIN="${CAFFE_SRC_ROOT}/build/tools/caffe.bin"

function step_compile() {
    cd ${CAFFE_SRC_ROOT}
    sudo apt-get install git
    sudo apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler
    sudo apt-get install --no-install-recommends libboost-all-dev
    sudo apt-get install libatlas-base-dev
    sudo apt-get install python-dev
    sudo apt-get install libgflags-dev libgoogle-glog-dev liblmdb-dev
    mv Makefile.config.example Makefile.config
    make -j
    cd -
    # 检查cuda的so是否在.bashrc中配置了 export LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH:/usr/local/cuda-8.0/lib64/
}

function step_prepare() {
    cp -r ../caffe_01_convert/data ../caffe_01_convert/data2
}

function step_train() {
    ${CAFFE} train --solver=./lenet_solver.prototxt
}

function step_predict() {
    ${CAFFE_BIN} test -model ./height_train_10layer_deploy.prototxt -weights ../caffe_01_convert/data/_iter_10000.caffemodel -iterations 100
}

#step_compile
#step_get_data
#step_convert
step_prepare
step_train
#step_predict
