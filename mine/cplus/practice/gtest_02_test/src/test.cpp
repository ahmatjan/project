#include "test.h"

#include <iostream>  

int foo(int a, int b) {
    if (a == 0 || b == 0) {
        throw "don't do that";
    }
    int c = a % b;
    if (c == 0) {
        return b;
    }
    return foo(b, c);
}

#ifndef UNIT_TEST
int main(int argc, char *argv[]) {
#else
int inner_main(int argc, char *argv[]) {
#endif
    std::cout << foo(4, 10) << std::endl;
    std::cout << foo(30, 18) << std::endl;
    return 0;
}  
