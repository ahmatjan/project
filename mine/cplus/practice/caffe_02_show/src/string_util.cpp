#include "string_util.h"

#include <algorithm>

//#include <xlog.h>

using std::string;
using std::vector;

void StringUtil::explode(
        const string& str, char c, vector<string>* terms_vec) {
    string term;
    for (auto& cur_char : str) {
        if (cur_char != c) {
            term += cur_char;
            continue;
        }
        // find one
        if (!term.empty()) {
            terms_vec->push_back(term);
            term.clear();
        }
    }
    if (!term.empty()) {
        terms_vec->push_back(term);
    }
}

void StringUtil::trim(TrimType type, string* result_str) {
    string& str = *result_str;
    switch (type) {
    case TRIM_LEFT:
        str.erase(
                str.begin(),
                std::find_if_not(
                    str.begin(),
                    str.end(),
                    [] (int c) { return isspace(c) != 0; }));
        break;
    case TRIM_RIGHT:
        str.erase(
                std::find_if_not(
                    str.rbegin(),
                    str.rend(),
                    [] (int c) { return isspace(c) != 0; }).base(),
                str.end());
        break;
    case TRIM_BOTH:
        trim(TRIM_LEFT, result_str);
        trim(TRIM_RIGHT, result_str);
        break;
    default:
        //XLOG(ERROR) << "Invalid trim type, type: " << type;
        break;
    }
}

string StringUtil::trim(TrimType type, const string& str) {
    string result_str(str);
    StringUtil::trim(type, &result_str);
    return result_str;
}

string StringUtil::ltrim(const std::string& str) {
    return trim(TRIM_LEFT, str);
}

string StringUtil::rtrim(const std::string& str) {
    return trim(TRIM_RIGHT, str);
}

string StringUtil::trim(const std::string& str) {
    return trim(TRIM_BOTH, str);
}

bool StringUtil::start_with(const string& raw_str, const string& prefix) {
    if (raw_str.size() < prefix.size()) {
        return false;
    }

    auto raw_iter = raw_str.cbegin();
    auto pre_iter = prefix.cbegin();
    for (; pre_iter != prefix.end(); ++raw_iter, ++pre_iter) {
        if (*raw_iter != *pre_iter) {
            return false;
        }
    }

    return true;
}

bool StringUtil::end_with(const string& raw_str, const string& suffix) {
    if (raw_str.size() < suffix.size()) {
        return false;
    }

    auto raw_iter = raw_str.crbegin();
    auto suffix_iter = suffix.crbegin();
    for (; suffix_iter != suffix.crend(); ++suffix_iter, ++raw_iter) {
        if (*suffix_iter != *raw_iter) {
            return false;
        }
    }

    return true;
}

bool StringUtil::stoi(const string& str, int* ret_val) {
    try {
        *ret_val = std::stoi(str);
        return true;
    } catch (...) {
        //XLOG(ERROR) << "std::stoi() failed.str:" << str;
        return false;
    }
}

