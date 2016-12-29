#include "test.h"

#include "people.pb.h"
  
#ifndef UNIT_TEST
int main(int argc, char *argv[]) {
#else
int inner_main(int argc, char *argv[]) {
#endif
    //std::cout << people.name() << std::endl;
    return 0;  
}
