#ifndef ADU_PERCEPTION_LIB_BASE_STRING_UTIL_H
#define ADU_PERCEPTION_LIB_BASE_STRING_UTIL_H

#include <string>
#include <vector>

#include "noncopyable.h"

enum TrimType {
    TRIM_UNKNOWN = 0,
    TRIM_LEFT = 1,
    TRIM_RIGHT = 2,
    TRIM_BOTH = 3,
};

class StringUtil {
public:
    StringUtil() = default;
    ~StringUtil() = default;

    // @brief: split string by one character
    //         a,b,c => a b c
    // @param [in]: the string you want to explode
    // @param [in]: the character used to split the string
    // @param [out]: result strings after exploded by character
    static void explode(
            const std::string& str,
            char c,
            std::vector<std::string>* terms_vec);

    // @brief: trim the string, in place vesion
    // @param [in]: type, see TrimType enum
    // @param [out]: trimed string
    // @return: void
    static void trim(TrimType type, std::string* str);

    // @brief: trim the string, copy version
    // @param [in]: type, see TrimType
    // @param [in]: str, the string you want to trim
    // @return: trimed string
    static std::string trim(TrimType type, const std::string& str);

    // @brief: other convenient versions for trim function
    //         you can use functions below with fewer args
    static std::string ltrim(const std::string& str);
    static std::string rtrim(const std::string& str);
    static std::string trim(const std::string& str);

    // @breif: convert digit to string
    //         StringUtil::digit2string(123) = "123"
    // @param [in]: int long double
    // @return: converted string
    // @note: when you use float or double, you will get
    //        StringUtil::digit2string(-123.1)="-123.100000"
    template <typename T>
    static std::string digit2string(T number);

    // @brief: judge raw_str start with prefix or not
    //         StringUtil::start_with("abcedf.txt", "abc") = true
    static bool start_with(const std::string& raw_str, const std::string& prefix);

    // @brief: judge raw_str end with suffix or not
    //         StringUtil::end_with("abc.txt", "txt") = true
    static bool end_with(const std::string& raw_str, const std::string& suffix);

    // string to int
    static bool stoi(const std::string& str, int* ret_val);
private:
    DISALLOW_COPY_AND_ASSIGN(StringUtil);
};

template <typename T>
std::string StringUtil::digit2string(T number) {
    return std::to_string(number);
}

#endif // ADU_PERCEPTION_LIB_BASE_STRING_UTIL_H
