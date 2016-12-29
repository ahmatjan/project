#include "test.h"

#include <iostream>

#include "people.pb.h"
  
#ifndef UNIT_TEST
int main(int argc, char *argv[]) {
#else
int inner_main(int argc, char *argv[]) {
#endif
    demo::People people;
    people.set_name("yangkai");
    std::cout << people.name() << std::endl;
    return 0;  
}
