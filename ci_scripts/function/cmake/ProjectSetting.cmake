#MESSAGE( STATUS "SET_UP_COMMON_SETTING:         " ${PROJECT_NAME} )

#PROJECT_SOURCE_DIR

#include project root, public and private folder for current project
set (PROJECT_PRIVATE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Private)
include_directories("${PROJECT_PRIVATE_DIR}")

set (PROJECT_PUBLIC_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Public)
include_directories("${PROJECT_PUBLIC_DIR}")
include_directories("${CMAKE_CURRENT_SOURCE_DIR}")

#set CXX FLAGS for linux
IF(UNIX)
	set (CMAKE_CXX_FLAGS "-std=c++11 -stdlib=libc++ -O2 -g -Wall")
ENDIF()

