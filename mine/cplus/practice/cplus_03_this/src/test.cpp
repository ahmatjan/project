#include "test.h"

#include <iostream>  
#include <type_traits>  

template<class T>
class A {
public:
    int x;
};

template<class T>
class B : public A<T> {
public:
    int print() {
        std::cout << this->x << std::endl;
        std::cout << y << std::endl;
    }
    int y;
};

#ifndef UNIT_TEST
int main(int argc, char *argv[]) {
#else
int inner_main(int argc, char *argv[]) {
#endif
    B<int> b;
    b.print();
    return 0;
}  
