cmake_minimum_required(VERSION 3.7.2)
project (liba52 VERSION 0.7.4)

file(GLOB LIBA52_SOURCES "${CMAKE_CURRENT_LIST_DIR}/liba52/*.c")
file(GLOB LIBA52_HEADERS "${CMAKE_CURRENT_LIST_DIR}/liba52/*.h")

if (BUILD_SHARED_LIBS)
    list(APPEND LIBA52_SOURCES "${CMAKE_CURRENT_LIST_DIR}/liba52.def")
endif ()

include_directories(
    "${CMAKE_CURRENT_LIST_DIR}/include"
    "${CMAKE_CURRENT_LIST_DIR}/liba52"
    "${CMAKE_CURRENT_LIST_DIR}/vc++"
)
add_library(liba52 ${LIBA52_SOURCES} ${LIBA52_HEADERS})

install(
    TARGETS liba52
        ARCHIVE DESTINATION "lib"
        LIBRARY DESTINATION "lib"
        RUNTIME DESTINATION "bin"
    )
