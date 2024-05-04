cmake_minimum_required(VERSION 3.7.2)
project (faac VERSION 1.30)

option(FAAC_BUILD_BINARIES "Build faac binaries" ON)

file(GLOB FAAC_SOURCES "${CMAKE_CURRENT_LIST_DIR}/libfaac/*.c")
file(GLOB FAAC_HEADERS "${CMAKE_CURRENT_LIST_DIR}/libfaac/*.h")

if (BUILD_SHARED_LIBS)
    list(APPEND FAAC_SOURCES "${CMAKE_CURRENT_LIST_DIR}/project/msvc/libfaac.def")
endif ()

add_definitions(-DPACKAGE_VERSION=\"${PROJECT_VERSION}\" -D_CRT_SECURE_NO_WARNINGS -D_USE_MATH_DEFINES)
include_directories(
    "${CMAKE_CURRENT_LIST_DIR}/include"
    "${CMAKE_CURRENT_LIST_DIR}/libfaac"
)
add_library(faac ${FAAC_SOURCES} ${FAAC_HEADERS})

if (BUILD_SHARED_LIBS)
    target_compile_definitions(faac PRIVATE FAACEXPORT)
endif ()

if (FAAC_BUILD_BINARIES)
    include_directories(
        "${CMAKE_CURRENT_LIST_DIR}/frontend"
    )
    if (VCPKG_TARGET_IS_WINDOWS)
        include_directories(
            "${CMAKE_CURRENT_LIST_DIR}/project/msvc"
        )
    endif ()
    add_executable(FAAC_encoder
        "${CMAKE_SOURCE_DIR}/frontend/getopt.c"
        "${CMAKE_SOURCE_DIR}/frontend/input.c"
        "${CMAKE_SOURCE_DIR}/frontend/main.c"
        "${CMAKE_SOURCE_DIR}/frontend/mp4write.c"
    )
    target_link_libraries(FAAC_encoder PRIVATE faac)
endif ()

install(
    TARGETS faac
        ARCHIVE DESTINATION "lib"
        LIBRARY DESTINATION "lib"
        RUNTIME DESTINATION "bin"
    )
