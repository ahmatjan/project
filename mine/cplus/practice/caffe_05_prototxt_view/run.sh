#!/bin/bash

#test_net net_proto pretrained_net_proto iterations [CPU/GPU]  

./release/demo ../caffe_04_cloud_classifier/height_train_10layer_deploy.prototxt ../caffe_04_cloud_classifier/lenet_solver.prototxt 20 GPU 
#./data 7 
