#ifndef ROS_SECURE_ROS_EXPORT_H
#define ROS_SECURE_ROS_EXPORT_H
#include <string>
#include <boost/shared_array.hpp>

/*
 * export apis
 */
extern "C" {
namespace carsec {
    const int SHA1_STRING_LEN = 40;

    const char* const BIDU_FLAG_BEGIN = "bidu";
    const char* const BIDU_FLAG_END = "//d";

    enum {
        BIDU_FLAG_BEGIN_SIZE = sizeof("bidu"),
        BIDU_FLAG_END_SIZE = sizeof("//d"),
        SEC_SIGN_LEN = SHA1_STRING_LEN + BIDU_FLAG_BEGIN_SIZE + BIDU_FLAG_END_SIZE
    };

    /*
     *\brief api: init_ros_secure
     */
    bool init_ros_secure();

    /*
     * \brief api: uninit_ros_secure
     */
    bool uninit_ros_secure();

    /*
     * \brief api: get_sig_value
     */
    std::string get_sig_value(const std::string data);

    /*
     * \brief api: encrypt_data_for_ros
     */
    unsigned char* encrypt_data_for_ros(const std::string in_data, unsigned long* ullen);

    /*
     * \brief api: decrypt_data_for_ros
     */
    std::string decrypt_data_for_ros(const unsigned char* in_data, unsigned long ullen);

    /*
     * \brief api: encrypt_data_and_sign
     */
    unsigned char* encrypt_data_and_sign(std::string instr, unsigned long* ulLen);

    /*
     * \brief api: decrypt_data_and_unsign
     */
    std::string decrypt_data_and_unsign(unsigned char* inData, unsigned long ulLen);

    /*
     * \brief api: alloc_buffer
     */
    void* alloc_buffer(unsigned long ulLen);

    /*
     * \brief api: free_buffer
     */
    void free_buffer(void* pBuf);

    /*
     * encrypt_buf_and_sign
     */
    unsigned char* encrypt_buf_and_sign(unsigned char* in_data,
            unsigned long* ulLen, void* ctx);

    /*
     * decrypt_buf_and_unsign
     */
    unsigned char* decrypt_buf_and_unsign(unsigned char* in_data,
            unsigned long* ulLen, void* ctx);
    /*
    * encrypt_buf_and_sign for high-performance , the param out_date operated at four offsets
    * add by l0012929
    */
    bool encrypt_buf_and_sign_faster(unsigned char* in_data, unsigned long* ulLen,
            boost::shared_array<unsigned char>& out_data, unsigned long* outLen,
            void* ctx);

    /*
     * decrypt_buf_and_unsign for high-performance
     * add by l0012929
     */
    bool decrypt_buf_and_unsign_faster(unsigned char* in_data, unsigned long* ulLen,
            boost::shared_array<unsigned char>& out_data, unsigned long* outLen,
            void* ctx);

    /*
     * free_ctx
     * that means the connection was closed.
     */

    bool free_ctx(void* ctx);

    /*
     * encrypt_buf_and_sign_for_local
     * used for local machine.
     */
    unsigned char* encrypt_buf_and_sign_for_local(unsigned char* in_data,
            unsigned long* ulLen, void* ctx);

    /*
     * decrypt_buf_and_unsign_for_local
     * used for local machine.
     */
    unsigned char* decrypt_buf_and_unsign_for_local(unsigned char* in_data,
            unsigned long* ulLen, void* ctx);

    bool free_ctx_for_local(void* ctx);

    /*
     * encrypt_buf_and_sign_for_selfchk
     * used for self check.
     */
    unsigned char* encrypt_buf_and_sign_for_selfchk(unsigned char* in_data,
            unsigned long* ulLen, void* ctx);

    /*
     * decrypt_buf_and_unsign_for_selfchk
     * used for self check.
     */
    unsigned char* decrypt_buf_and_unsign_for_selfchk(unsigned char* in_data,
            unsigned long* ulLen, void* ctx);

    /*
     * encrypt_buf_and_sign_for_remote
     * used for communication between hmi and control node.
     * this api will verify cer.
     */
    unsigned char* encrypt_buf_and_sign_for_remote(unsigned char* in_data,
            unsigned long* ulLen, void* ctx);

    /*
     * decrypt_buf_and_unsign_for_remote
     * used for communication between hmi and control node.
     * this api will verify cer.
     */
    unsigned char* decrypt_buf_and_unsign_for_remote(unsigned char* in_data,
            unsigned long* ulLen, void* ctx);

    /*
     * encrypt_buf_and_sign_for_python
     * used for communication between rosnode and rosnode which coded by python.
     */
    unsigned char* encrypt_buf_and_sign_for_python(unsigned char* in_data,
            unsigned long* ulLen, void* ctx);

    /*
     * decrypt_buf_and_unsign_for_python
     * used for communication between rosnode and rosnode which coded by python.
     */
    unsigned char* decrypt_buf_and_unsign_for_python(unsigned char* in_data,
            unsigned long* ulLen, void* ctx);

    /*
     * free_ctx_for_python
     * to support defense replay,import context
     */
    bool free_ctx_for_python(void* ctx);


    /*
     * check_rules
     * to support defense replay,import context
     */
    bool check_rules(std::string topic, std::string node1_name, std::string node2_name, \
            unsigned int* ulflags);
    }
}

#endif
