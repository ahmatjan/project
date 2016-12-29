SET(CUR_LIB_NAME "protobuf")
SET(CUR_LIB_PATH "${PROJECT_THIRD_PATH}/${CUR_LIB_NAME}")
#SET(CMAKE_PREFIX_PATH ${CUR_LIB_PATH})
SET(CUR_LIB_INCLUDE_PATH "${CUR_LIB_PATH}/include")
SET(CUR_LIB_LIB_PATH "${CUR_LIB_PATH}/lib")
SET(PROTOC "${CUR_LIB_PATH}/bin/protoc")
SET(CUR_LIB_LIBRARIES protobuf protobuf-lite protoc)

#FIND_PACKAGE(Protobuf REQUIRED)

INCLUDE_DIRECTORIES(${CUR_LIB_INCLUDE_PATH})
LINK_DIRECTORIES(${CUR_LIB_LIB_PATH})
SET(PROJECT_THIRD_LIBS ${PROJECT_THIRD_LIBS} ${CUR_LIB_LIBRARIES})

function(PROTOBUF_GENERATE_CPP SRCS HDRS)

  if(NOT ARGN)
    message(SEND_ERROR "Error: PROTOBUF_GENERATE_CPP() called without any proto files")
    return()
  endif(NOT ARGN)

  set(${SRCS})
  set(${HDRS})
  foreach(FIL ${ARGN})
    get_filename_component(ABS_FIL ${FIL} ABSOLUTE)
    get_filename_component(FIL_WE ${FIL} NAME_WE)

    list(APPEND ${SRCS} "${CMAKE_CURRENT_SOURCE_DIR}/${FIL_WE}.pb.cc")
    list(APPEND ${HDRS} "${CMAKE_CURRENT_SOURCE_DIR}/${FIL_WE}.pb.h")

    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_SOURCE_DIR}/${FIL_WE}.pb.cc"
               "${CMAKE_CURRENT_SOURCE_DIR}/${FIL_WE}.pb.h"
      COMMAND  ${PROTOC}
      ARGS --cpp_out  ${CMAKE_CURRENT_SOURCE_DIR} --proto_path ${CMAKE_CURRENT_SOURCE_DIR} ${ABS_FIL}
      DEPENDS ${ABS_FIL}
      COMMENT "Running C++ protocol buffer compiler on ${FIL}"
      VERBATIM )
  endforeach()

  set_source_files_properties(${${SRCS}} ${${HDRS}} PROPERTIES GENERATED TRUE)
  set(${SRCS} ${${SRCS}} PARENT_SCOPE)
  set(${HDRS} ${${HDRS}} PARENT_SCOPE)
endfunction()

function(PROTOBUF_GENERATE_CPP_TO_BINARY_DIR SRCS HDRS)

  if(NOT ARGN)
    message(SEND_ERROR "Error: PROTOBUF_GENERATE_CPP() called without any proto files")
    return()
  endif(NOT ARGN)

  set(${SRCS})
  set(${HDRS})
  foreach(FIL ${ARGN})
    get_filename_component(ABS_FIL ${FIL} ABSOLUTE)
    get_filename_component(FIL_WE ${FIL} NAME_WE)

    list(APPEND ${SRCS} "${CMAKE_CURRENT_BINARY_DIR}/${FIL_WE}.pb.cc")
    list(APPEND ${HDRS} "${CMAKE_CURRENT_BINARY_DIR}/${FIL_WE}.pb.h")

    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${FIL_WE}.pb.cc"
               "${CMAKE_CURRENT_BINARY_DIR}/${FIL_WE}.pb.h"
      COMMAND  ${PROTOC}
      ARGS --cpp_out  ${CMAKE_CURRENT_BINARY_DIR} --proto_path ${CMAKE_CURRENT_SOURCE_DIR} ${ABS_FIL}
      DEPENDS ${ABS_FIL}
      COMMENT "Running C++ protocol buffer compiler on ${FIL}"
      VERBATIM )
  endforeach()

  set_source_files_properties(${${SRCS}} ${${HDRS}} PROPERTIES GENERATED TRUE)
  set(${SRCS} ${${SRCS}} PARENT_SCOPE)
  set(${HDRS} ${${HDRS}} PARENT_SCOPE)
endfunction()

function(PROTOBUF_GENERATE_CPP_IMPORT1 SRCS HDRS IMPORT_PATH1)

  if(NOT ARGN)
    message(SEND_ERROR "Error: PROTOBUF_GENERATE_CPP() called without any proto files")
    return()
  endif(NOT ARGN)

  set(${SRCS})
  set(${HDRS})
  foreach(FIL ${ARGN})
    get_filename_component(ABS_FIL ${FIL} ABSOLUTE)
    get_filename_component(FIL_WE ${FIL} NAME_WE)

    list(APPEND ${SRCS} "${CMAKE_CURRENT_BINARY_DIR}/${FIL_WE}.pb.cc")
    list(APPEND ${HDRS} "${CMAKE_CURRENT_BINARY_DIR}/${FIL_WE}.pb.h")

    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${FIL_WE}.pb.cc"
               "${CMAKE_CURRENT_BINARY_DIR}/${FIL_WE}.pb.h"
      COMMAND  ${PROTOC}
      ARGS --cpp_out ${CMAKE_CURRENT_BINARY_DIR} --proto_path ${CMAKE_CURRENT_SOURCE_DIR} 
                                                 --proto_path "${CMAKE_CURRENT_SOURCE_DIR}/${IMPORT_PATH1}" 
                                                 ${ABS_FIL}
      DEPENDS ${ABS_FIL}
      COMMENT "Running C++ protocol buffer compiler on ${FIL}"
      VERBATIM )
  endforeach()

  set_source_files_properties(${${SRCS}} ${${HDRS}} PROPERTIES GENERATED TRUE)
  set(${SRCS} ${${SRCS}} PARENT_SCOPE)
  set(${HDRS} ${${HDRS}} PARENT_SCOPE)
endfunction()

function(PROTOBUF_GENERATE_CPP_IMPORT2 SRCS HDRS IMPORT_PATH1 IMPORT_PATH2)

  if(NOT ARGN)
    message(SEND_ERROR "Error: PROTOBUF_GENERATE_CPP() called without any proto files")
    return()
  endif(NOT ARGN)

  set(${SRCS})
  set(${HDRS})
  foreach(FIL ${ARGN})
    get_filename_component(ABS_FIL ${FIL} ABSOLUTE)
    get_filename_component(FIL_WE ${FIL} NAME_WE)

    list(APPEND ${SRCS} "${CMAKE_CURRENT_BINARY_DIR}/${FIL_WE}.pb.cc")
    list(APPEND ${HDRS} "${CMAKE_CURRENT_BINARY_DIR}/${FIL_WE}.pb.h")

    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${FIL_WE}.pb.cc"
               "${CMAKE_CURRENT_BINARY_DIR}/${FIL_WE}.pb.h"
      COMMAND  ${PROTOC}
      ARGS --cpp_out ${CMAKE_CURRENT_BINARY_DIR} --proto_path ${CMAKE_CURRENT_SOURCE_DIR} 
                                                 --proto_path "${CMAKE_CURRENT_SOURCE_DIR}/${IMPORT_PATH1}" 
                                                 --proto_path "${CMAKE_CURRENT_SOURCE_DIR}/${IMPORT_PATH2}" 
                                                 ${ABS_FIL}
      DEPENDS ${ABS_FIL}
      COMMENT "Running C++ protocol buffer compiler on ${FIL}"
      VERBATIM )
  endforeach()

  set_source_files_properties(${${SRCS}} ${${HDRS}} PROPERTIES GENERATED TRUE)
  set(${SRCS} ${${SRCS}} PARENT_SCOPE)
  set(${HDRS} ${${HDRS}} PARENT_SCOPE)
endfunction()

