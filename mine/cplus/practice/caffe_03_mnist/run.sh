#!/bin/bash

CAFFE_SRC_ROOT="/home/yangkai04/project/mine/cplus/third/src/caffe"

MNIST_DIR="${CAFFE_SRC_ROOT}/data/mnist"

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

function step_get_data() {
    cd ${MNIST_DIR}
    ./get_mnist.sh
    cd -
}

function step_convert() {
    cd ${CAFFE_SRC_ROOT}
    ./examples/mnist/create_mnist.sh 
    cd -
}

function step_train() {
    cd ${CAFFE_SRC_ROOT}
    ./build/tools/caffe train --solver=examples/mnist/lenet_solver.prototxt
    cd -
}

function step_predict() {
    cd ${CAFFE_SRC_ROOT}
    ./build/tools/caffe.bin test -model examples/mnist/lenet_train_test.prototxt -weights examples/mnist/lenet_iter_10000.caffemodel -iterations 100
    cd -
}

#step_compile
step_get_data
step_convert
step_train
step_predict
