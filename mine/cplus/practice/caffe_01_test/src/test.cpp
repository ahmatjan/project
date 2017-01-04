#include "test.h"

#include <iostream> 

#include <gflags/gflags.h>
#include <glog/logging.h>
#include <caffe/proto/caffe.pb.h>
#include <caffe/util/db.hpp>
#include <caffe/util/format.hpp>

DEFINE_string(db_path, "", "Leveldb path.");

#ifndef UNIT_TEST
int main(int argc, char *argv[]) {
#else
    int inner_main(int argc, char *argv[]) {
#endif
    google::ParseCommandLineFlags(&argc, &argv, true);
    if (FLAGS_db_path.empty()) {
        std::cout << "db_path empty error." << std::endl;
    }
    return 0;
}
