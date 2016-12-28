#include "test.h"

#include <iostream>  

#include <boost/lexical_cast.hpp>

int main(int argc, char *argv[]) {   
    int a = boost::lexical_cast<int>("123"); 
    double b = boost::lexical_cast<double>("123.12"); 
    std::cout << a << std::endl; 
    std::cout << b << std::endl; 
    return 0; 
}
