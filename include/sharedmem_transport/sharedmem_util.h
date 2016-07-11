#ifndef SHAREDMEM_TRANSPORT_SHAREDMEM_UTIL_H
#define SHAREDMEM_TRANSPORT_SHAREDMEM_UTIL_H

#include "sharedmem_transport/sharedmem_segment.h"

namespace sharedmem_transport {

/**
 * \brief Class for SharedMemoryUtil, defines some util functions of shared memory.

 * 1) create segment, get segment
 * 2) create segment mgr, get segment mgr
 * 3) get block descriptors
 * 4) remove segment
 */
class SharedMemoryUtil {
public:
    SharedMemoryUtil() {
    }
    
    virtual ~SharedMemoryUtil() {
    }

    /**
     * \brief Get segment pointer, according to topic name
     *
     * @param topic_name: topic name
     * Return segment pointer
     */
    boost::interprocess::managed_shared_memory* get_segment(const char* topic_name);

    /**
     * \brief Create segment, according to topic name and segment size
     *
     * @param topic_name: topic name
     * @param segment_size: segment size
     * Return segment pointer
     */
    boost::interprocess::managed_shared_memory* create_segment(const char* topic_name, 
        uint64_t segment_size);

    /**
     * \brief Get segment manager, according to segment pointer
     *
     * @param segment: segment pointer
     * Return segment manager pointer
     */
    SharedMemorySegment* get_segment_mgr(boost::interprocess::managed_shared_memory*& segment);

    /**
     * \brief Create segment manager, according to segment pointer
     *
     * @param segment: segment pointer
     * Return segment manager pointer
     */
    SharedMemorySegment* create_segment_mgr(boost::interprocess::managed_shared_memory*& segment);

    /**
     * \brief Get block descriptors pair, including header and size
     *
     * @param segment: segment pointer
     * @param descriptors: block descriptors pointer
     * @param queue_size: queue size
     */
    void get_header_and_size(boost::interprocess::managed_shared_memory*& segment, 
        SharedMemoryBlock*& descriptors, uint32_t* queue_size);

    /**
     * \brief Remove segment, according to segment name
     *
     * @param topic_name: topic name
     * Return result for remove segment
     */
    bool remove_segment(const char* topic_name);

private:
    /**
     * \brief Get segment name, according to topic name
     *
     * @param topic_name: topic name
     * @param segment_name: segment name
     */
    void get_segment_name(const char* topic_name, char* segment_name);
    /**
      * \brief Replace all old_char with new_char in src
      *
      * @param src: string which needs to replace
      * @param old_char: char which is replaced
      * @param new_char: char which is used to replace
      * Return string which has been replaced
      */
    char* replace_all(char* src, char old_char, char new_char);

};

} // namespace sharedmem_transport

#endif // SHAREDMEM_TRANSPORT_SHAREDMEM_UTIL_H
