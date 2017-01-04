#include "test.h"

#include <iostream>  
#include <fstream>  

#ifndef UNIT_TEST
int main(int argc, char *argv[]) {
#else
int inner_main(int argc, char *argv[]) {
#endif
    std::string file_name = "../data/test.data";
    std::string line;
    std::ifstream read_file(file_name, std::ios::in);
    while(getline(read_file, line)) {
        std::cout << line << std::endl;
    }
    return 0;
}  
