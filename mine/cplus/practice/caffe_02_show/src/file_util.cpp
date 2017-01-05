#include "file_util.h"

#include <dirent.h>
#include <errno.h>
#include <fcntl.h>
#include <limits.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

#include <algorithm>
#include <cstring>
#include <fstream>

//#include <xlog.h>
#include <glog/logging.h>

using std::string;
using std::vector;

bool FileUtil::get_type(const string& filename, FileType* type) {
    struct stat stat_buf;
    if (lstat(filename.c_str(), &stat_buf) != 0) {
        return false;
    }
    if (S_ISDIR(stat_buf.st_mode) != 0) {
        *type = TYPE_DIR;
    } else if (S_ISREG(stat_buf.st_mode) != 0) {
        *type = TYPE_FILE;
    } else {
        //XLOG(WARN) << "failed to get type: " << filename;
        return false;
    }
    return true;
}

bool FileUtil::delete_file(const string& filename) {
    if (!exists(filename)) {
        return true;
    }
    FileType type;
    if (!get_type(filename, &type)) {
        return false;
    }
    // 文件，直接删除
    if (type == TYPE_FILE) {
        if (remove(filename.c_str()) != 0) {
            //XLOG(ERROR) << "failed to remove file: " << filename;
            return false;
        }
        return true;
    }

    // 目录，需要迭代删除
    DIR* dir = opendir(filename.c_str());
    if (dir == NULL) {
        //XLOG(WARN) << "failed to opendir: " << filename;
        return false;
    }
    dirent* dir_info = NULL;
    while ((dir_info = readdir(dir)) != NULL) {
        if (strcmp(dir_info->d_name, ".") == 0
            || strcmp(dir_info->d_name, "..") == 0) {
            continue;
        }
        // 拼接目录路径
        string temp_file = filename + "/" + string(dir_info->d_name);
        FileType temp_type;
        if (!get_type(temp_file, &temp_type)) {
            //XLOG(WARN) << "failed to get file type: " << temp_file;
            return false;
        }
        if (type == TYPE_DIR) {
            delete_file(temp_file);
        }
        remove(temp_file.c_str());
    }
    closedir(dir);
    remove(filename.c_str());

    return true;
}

bool FileUtil::exists(const string& file) {
    int ret = access(file.c_str(), F_OK);
    if (ret != 0) {
        //XLOG(INFO) << "file not exist. file: " << file << " ret: " << strerror(errno);
        return false;
    }
    return true;
}

bool FileUtil::exists(const string& path, const string& suffix) {
    boost::filesystem::recursive_directory_iterator itr(path);
    while (itr != boost::filesystem::recursive_directory_iterator()) {
        if (boost::algorithm::ends_with(itr->path().string(), suffix)) {
            return true;
        }
        ++itr;
    }
    return false;
}

bool FileUtil::rename_file(const string& old_file, const string& new_file) {
    // 为了通用性，若存在就先删除
    if (!delete_file(new_file)) {
        return false;
    }
    int ret = rename(old_file.c_str(), new_file.c_str());
    if (ret != 0) {
        //XLOG(WARN) << "failed to rename [old file: " << old_file
        //<< "] to [newfile: " << new_file << "] [err: " << strerror(errno) << "]";
        return false;
    }
    return true;
}

bool FileUtil::create_dir(const string& dir) {
    int ret = mkdir(dir.c_str(), S_IRWXU | S_IRWXG | S_IRWXO);
    if (ret != 0) {
        //XLOG(WARN) << "failed to create dir. [dir: " << dir
        //<< "] [err: " << strerror(ret) << "]";
        return false;
    }
    return true;
}

bool FileUtil::get_file_content(const string& path, string* content) {
    if (content == NULL) {
        return false;
    }

    int fd = ::open(path.c_str(), O_RDONLY);
    if (fd < 0) {
        //XLOG(WARN) << "failed to open file: " << path;
        return false;
    }
    struct stat buf;
    if (::fstat(fd, &buf) != 0) {
        //XLOG(WARN) << "failed to lstat file: " << path;
        return false;
    }

    size_t fsize = buf.st_size;
    content->resize(fsize);
    char* data = const_cast<char*>(content->data());
    int size = 0;
    size_t has_read = 0;
    do {
        size = ::read(fd, data + has_read, fsize - has_read);
        if (size < 0) {
            //XLOG(WARN) << "failed to read file: " << path;
            return false;
        }
        has_read += size;
    } while (size > 0);
    return true;
}

bool FileUtil::read_lines(const string& path, vector<string>* lines) {
    std::ifstream fin(path);
    if (!fin.good()) {
        LOG(ERROR) << "Failed to open path: " << path;
        return false;
    }
    if (lines == nullptr) {
        return false;
    }

    string line;
    while (std::getline(fin, line)) {
        lines->push_back(line);
    }
    return true;
}

std::string FileUtil::remove_file_suffix(std::string filename) {
    int first_index = filename.find_last_of("/");
    size_t last_index = filename.find_last_of(".");
    if (last_index == std::string::npos) {
        last_index = filename.length();
    }
    std::string raw_name = filename.substr(first_index + 1, last_index - first_index - 1);
    return raw_name;
}

void FileUtil::get_file_list(vector<string>& files, const string path, const string suffix) {
    get_file_list(path, suffix, &files);
}

void FileUtil::get_file_list(
        const std::string& path,
        const std::string& suffix,
        std::vector<std::string>* files) {
    if (!exists(path)) {
        //XLOG(INFO) << path << " not exist.";
        return;
    }

    boost::filesystem::recursive_directory_iterator itr(path);
    while (itr != boost::filesystem::recursive_directory_iterator()) {
        try {
            if (suffix.empty() || boost::algorithm::ends_with(itr->path().string(), suffix)) {
                files->push_back(itr->path().string());
            }
            ++itr;
        } catch (const std::exception & ex) {
            //XLOG(WARN) << "Caught execption: " << ex.what();
            continue;
        }
    }
}

void FileUtil::get_file_list(const string& path, vector<string>* files) {
    get_file_list(path, "", files);
}

string FileUtil::get_absolute_path(
        const string& prefix,
        const string& relative_path) {

    if (relative_path.empty()) {
        return prefix;
    }

    if (prefix.empty()) {
        return relative_path;
    }

    string result = prefix;

    if (relative_path[0] == '/') {
        return relative_path;
    }

    if (prefix[prefix.length() - 1] != '/') {
        result.append("/");
    }
    return result.append(relative_path);
}

void FileUtil::get_file_name(const string& file, string* name) {
    size_t pos_left = file.find_last_of('/');
    size_t pos_right = file.find_last_of('.');
    if (pos_right == string::npos) {
        *name = file.substr(pos_left + 1);
    } else {
        *name = file.substr(pos_left + 1, pos_right - pos_left - 1);
    }
}

bool FileUtil::compare_file_by_digital(const string& file_left, const string& file_right) {
    return compare_file(file_left, file_right, FCT_DIGITAL);
}

bool FileUtil::compare_file_by_lexicographical(
        const string& file_left, const string& file_right) {
    return compare_file(file_left, file_right, FCT_LEXICOGRAPHICAL);
}

// private functions

bool FileUtil::compare_file(
        const string& file_left, const string& file_right, FileCompareType type) {
    string name_left;
    get_file_name(file_left, &name_left);
    string name_right;
    get_file_name(file_right, &name_right);

    switch (type) {
    case FCT_DIGITAL:
        return atoll(name_left.c_str()) < atoll(name_right.c_str());
    case FCT_LEXICOGRAPHICAL:
        return std::lexicographical_compare(
                name_left.begin(), name_left.end(), name_right.begin(), name_right.end());
    default:
        //XLOG(ERROR) << "Unknown compare type!";
        return true;
    }

    return true;
}

