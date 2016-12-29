#include "test.h"

#include <iostream>  

DEFINE_string(mystr, "hello world~!", "my words");

#ifndef UNIT_TEST
int main(int argc, char *argv[]) {
#else
int inner_main(int argc, char *argv[]) {
#endif
    //google::ParseCommandLineFlags(&argc, &argv, true);
    //argc和argv想必大家都很清楚了，说明以下第三个参数的作用：
    //如果设为true，则该函数处理完成后，argv中只保留argv[0]，argc会被设置为1。
    //如果为false，则argv和argc会被保留，但是注意函数会调整argv中的顺序。
    google::ParseCommandLineFlags(&argc, &argv, true);
    //printf("%s", FLAGS_mystr);
    std::cout << FLAGS_mystr << std::endl;

    return 0;
}  
