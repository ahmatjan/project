CMAKE_MINIMUM_REQUIRED(VERSION 2.8)
PROJECT(demo)

SET(PROTO_NAME "${PROJECT_NAME}_proto")

# we put proto result .h .cpp to proto source dirs to find them
INCLUDE_DIRECTORIES(${PROJECT_SOURCE_DIR}/inc ${PROJECT_SOURCE_DIR}/proto)
AUX_SOURCE_DIRECTORY(${PROJECT_SOURCE_DIR}/src DIR_SRCS)
INCLUDE(${PROJECT_SOURCE_DIR}/../../cmake/Packages.cmake)

ADD_EXECUTABLE(${PROJECT_NAME} ${DIR_SRCS})
#ADD_LIBRARY(${PROJECT_NAME} ${DIR_SRCS})

#TARGET_LINK_LIBRARIES(${PROJECT_NAME} ${PROJECT_THIRD_LIBS})

# must add PROTO_NAME to assure the proto be compiled before project
# must add PROTO_NAME before PROJECT_THIRD_LIBS, otherwise can't find probuf libs when compile proto
TARGET_LINK_LIBRARIES(${PROJECT_NAME} ${PROTO_NAME} ${PROJECT_THIRD_LIBS})

ADD_SUBDIRECTORY(proto)

