#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdbool.h>
#include <string>

#ifndef PROJECT_PATH_BASE64_H
#define PROJECT_PATH_BASE64_H

#ifndef MAX_PATH
#define MAX_PATH 256
#endif

#define modp_b64_encode_len(A) ((A+2)/3 * 4 + 1)
#define modp_b64_decode_len(A) (A / 4 * 3 + 2)
#define MODP_B64_ERROR ((size_t)-1)

using std::string;

int base64_encode(const unsigned char* bindata, int binlength, char* base64);
inline void base64_encode(const string& input, string* output) {
    std::string temp;
    temp.resize(modp_b64_encode_len(input.size()));
    //size_t output_size = modp_b64_encode(&(temp[0]), input.data(), input.size());
    size_t output_size = base64_encode((const unsigned char*)input.data(), input.size(), &(temp[0]));
    temp.resize(output_size);
    output->swap(temp);
}

int base64_decode(const char* base64, int base64length, unsigned char* bindata);
inline bool base64_decode(const string& input, string* output) {
    std::string temp;
    temp.resize(modp_b64_decode_len(input.size()));

    size_t input_size = input.size();
    size_t output_size = base64_decode(input.data(), input_size, (unsigned char*)&(temp[0]));
    if (output_size == MODP_B64_ERROR) {
        return false;
    }   
    temp.resize(output_size);
    output->swap(temp);
    return true;
}

void encode(FILE * fp_in, FILE * fp_out);

void decode(FILE * fp_in, FILE * fp_out);

#endif  // PROJECT_PATH_BASE64_H
