cmake_minimum_required(VERSION 3.6)

project(libzplay
    DESCRIPTION "libZPlay audio library"
    LANGUAGES CXX
)

option(LIBZPLAY_STATIC_CRT "Use static CRT library"                 FALSE)
option(LIBZPLAY_PACK_WITH_UPX "Pack programs with UPX"              FALSE)
option(LIBZPLAY_BUILD_EXAMPLES "Build example programs"             TRUE)
option(LIBZPLAY_INSTALL "Install library"                           FALSE)

option(LIBZPLAY_DSP_SOUNDTOUCH "Soundtouch audio processor support" TRUE)

option(LIBZPLAY_INPUT_AAC "AAC input support (faad2)"               TRUE)
option(LIBZPLAY_INPUT_AC3 "AC3 input support (liba52)"              FALSE)
option(LIBZPLAY_INPUT_FLAC "FLAC input support (libflac)"           TRUE)
option(LIBZPLAY_INPUT_MP3 "MP3 input support (libmad)"              TRUE)
option(LIBZPLAY_INPUT_VORBIS "Vorbis input support (vorbis)"        TRUE)
option(LIBZPLAY_INPUT_WAV "PCM/WAV input support"                   TRUE)
option(LIBZPLAY_INPUT_WAVEIN "WAVEIN input support"                 TRUE)

option(LIBZPLAY_OUTPUT_AAC "AAC output support (faac)"              FALSE)
option(LIBZPLAY_OUTPUT_FLAC "FLAC output support (libflac)"         TRUE)
option(LIBZPLAY_OUTPUT_MP3 "MP3 output support (mp3lame)"           TRUE)
option(LIBZPLAY_OUTPUT_VORBIS "Vorbis output support (vorbis)"      TRUE)
option(LIBZPLAY_OUTPUT_WAV "WAV output support"                     TRUE)

set(LIBZPLAY_ROOT ${CMAKE_CURRENT_SOURCE_DIR})
set(LIBZPLAY_EXAMPLES ${LIBZPLAY_ROOT}/example)
set(LIBZPLAY_INCLUDE ${LIBZPLAY_ROOT}/include)
set(LIBZPLAY_SRC ${LIBZPLAY_ROOT}/src)

set(LIBZPLAY_SOURCE_FILES
    ${LIBZPLAY_SRC}/config.h
    ${LIBZPLAY_SRC}/debug.h
    ${LIBZPLAY_SRC}/libzplay.cpp
    ${LIBZPLAY_SRC}/waudioprocessor.cpp
    ${LIBZPLAY_SRC}/waudioprocessor.h
    ${LIBZPLAY_SRC}/wbmpfont.cpp
    ${LIBZPLAY_SRC}/wbmpfont.h
    ${LIBZPLAY_SRC}/wbpmdetect.cpp
    ${LIBZPLAY_SRC}/wbpmdetect.h
    ${LIBZPLAY_SRC}/wbpmdetect1.cpp
    ${LIBZPLAY_SRC}/wbpmdetect1.h
    ${LIBZPLAY_SRC}/wbpmdetect2.cpp
    ${LIBZPLAY_SRC}/wbpmdetect2.h
    ${LIBZPLAY_SRC}/wbpmdetect3.cpp
    ${LIBZPLAY_SRC}/wbpmdetect3.h
    ${LIBZPLAY_SRC}/wcentercutprocessor.cpp
    ${LIBZPLAY_SRC}/wcentercutprocessor.h
    ${LIBZPLAY_SRC}/wdecoder.cpp
    ${LIBZPLAY_SRC}/wdecoder.h
    ${LIBZPLAY_SRC}/wechoprocessor.cpp
    ${LIBZPLAY_SRC}/wechoprocessor.h
    ${LIBZPLAY_SRC}/wencoder.cpp
    ${LIBZPLAY_SRC}/wencoder.h
    ${LIBZPLAY_SRC}/weqprocessor.cpp
    ${LIBZPLAY_SRC}/weqprocessor.h
    ${LIBZPLAY_SRC}/wfft.cpp
    ${LIBZPLAY_SRC}/wfft.h
    ${LIBZPLAY_SRC}/winputprocessor.cpp
    ${LIBZPLAY_SRC}/winputprocessor.h
    ${LIBZPLAY_SRC}/wmp3x.cpp
    ${LIBZPLAY_SRC}/wmp3x.h
    ${LIBZPLAY_SRC}/woutputprocessor.cpp
    ${LIBZPLAY_SRC}/woutputprocessor.h
    ${LIBZPLAY_SRC}/wqueue.cpp
    ${LIBZPLAY_SRC}/wqueue.h
    ${LIBZPLAY_SRC}/wspectrum.cpp
    ${LIBZPLAY_SRC}/wspectrum.h
    ${LIBZPLAY_SRC}/wtags.cpp
    ${LIBZPLAY_SRC}/wtags.h
    ${LIBZPLAY_SRC}/wtools.cpp
    ${LIBZPLAY_SRC}/wtools.h
    ${LIBZPLAY_SRC}/wwavelet.cpp
    ${LIBZPLAY_SRC}/wwavelet.h
)

find_package(JPEG REQUIRED)
find_package(PNG REQUIRED)

if(LIBZPLAY_DSP_SOUNDTOUCH)
    find_package(SoundTouch QUIET)
    if(${SoundTouch_FOUND})
        SET(LIBZPLAY_SOURCE_FILES ${LIBZPLAY_SOURCE_FILES}
            ${LIBZPLAY_SRC}/wstprocessor.cpp
            ${LIBZPLAY_SRC}/wstprocessor.h
        )
    else()
        SET(LIBZPLAY_DSP_SOUNDTOUCH FALSE CACHE BOOL "Soundtouch audio processor support" FORCE)
        MESSAGE(STATUS "Dependencies not found. Disabling Soundtouch DSP support")
    endif()
endif()

if(LIBZPLAY_INPUT_AAC)
    find_package(PkgConfig REQUIRED)
    pkg_check_modules(FAAD2 QUIET IMPORTED_TARGET faad2)
    if(${FAAD2_FOUND})
        SET(LIBZPLAY_SOURCE_FILES ${LIBZPLAY_SOURCE_FILES}
            ${LIBZPLAY_SRC}/waacdecoder.cpp
            ${LIBZPLAY_SRC}/waacdecoder.h
        )
    else()
        SET(LIBZPLAY_INPUT_AAC FALSE CACHE BOOL "AAC input support (faad2)" FORCE)
        MESSAGE(STATUS "Dependencies not found. Disabling aac input support")
    endif()
endif()

if(LIBZPLAY_INPUT_AC3)
    SET(LIBZPLAY_SOURCE_FILES ${LIBZPLAY_SOURCE_FILES}
        ${LIBZPLAY_SRC}/wac3decoder.cpp
        ${LIBZPLAY_SRC}/wac3decoder.h
    )
endif()

if(LIBZPLAY_INPUT_FLAC)
    find_package(FLAC QUIET)
    find_package(Ogg CONFIG QUIET)
    if(${FLAC_FOUND} AND ${Ogg_FOUND})
        SET(LIBZPLAY_SOURCE_FILES ${LIBZPLAY_SOURCE_FILES}
            ${LIBZPLAY_SRC}/wflacdecoder.cpp
            ${LIBZPLAY_SRC}/wflacdecoder.h
        )
    else()
        SET(LIBZPLAY_INPUT_FLAC FALSE CACHE BOOL "FLAC input support (libflac)" FORCE)
        MESSAGE(STATUS "Dependencies not found. Disabling flac input support")
    endif()
endif()

if(LIBZPLAY_INPUT_MP3)
    find_package(mad CONFIG QUIET)
    if(${mad_FOUND})
        SET(LIBZPLAY_SOURCE_FILES ${LIBZPLAY_SOURCE_FILES}
            ${LIBZPLAY_SRC}/wmp3decoder.cpp
            ${LIBZPLAY_SRC}/wmp3decoder.h
        )
    else()
        SET(LIBZPLAY_INPUT_MP3 FALSE CACHE BOOL "MP3 input support (libmad)" FORCE)
        MESSAGE(STATUS "Dependencies not found. Disabling mp3 input support")
    endif()
endif()

if(LIBZPLAY_INPUT_VORBIS)
    find_package(Ogg CONFIG QUIET)
    find_package(Vorbis CONFIG QUIET)
    if(${Ogg_FOUND} AND ${Vorbis_FOUND})
        SET(LIBZPLAY_SOURCE_FILES ${LIBZPLAY_SOURCE_FILES}
            ${LIBZPLAY_SRC}/woggdecoder.cpp
            ${LIBZPLAY_SRC}/woggdecoder.h
        )
    else()
        SET(LIBZPLAY_INPUT_VORBIS FALSE CACHE BOOL "Vorbis input support (vorbis)" FORCE)
        MESSAGE(STATUS "Dependencies not found. Disabling vorbis input support")
    endif()
endif()

if(LIBZPLAY_INPUT_WAV)
    SET(LIBZPLAY_SOURCE_FILES ${LIBZPLAY_SOURCE_FILES}
        ${LIBZPLAY_SRC}/wpcmdecoder.cpp
        ${LIBZPLAY_SRC}/wpcmdecoder.h
        ${LIBZPLAY_SRC}/wwavedecoder.cpp
        ${LIBZPLAY_SRC}/wwavedecoder.h
    )
endif()

if(LIBZPLAY_INPUT_WAVEIN)
    SET(LIBZPLAY_SOURCE_FILES ${LIBZPLAY_SOURCE_FILES}
        ${LIBZPLAY_SRC}/wwavein.cpp
        ${LIBZPLAY_SRC}/wwavein.h
    )
endif()

if(LIBZPLAY_OUTPUT_AAC)
    SET(LIBZPLAY_SOURCE_FILES ${LIBZPLAY_SOURCE_FILES}
        ${LIBZPLAY_SRC}/waacencoder.cpp
        ${LIBZPLAY_SRC}/waacencoder.h
    )
endif()

if(LIBZPLAY_OUTPUT_FLAC)
    find_package(FLAC QUIET)
    find_package(Ogg CONFIG QUIET)
    if(${FLAC_FOUND} AND ${Ogg_FOUND})
        SET(LIBZPLAY_SOURCE_FILES ${LIBZPLAY_SOURCE_FILES}
            ${LIBZPLAY_SRC}/wflacencoder.cpp
            ${LIBZPLAY_SRC}/wflacencoder.h
        )
    else()
        SET(LIBZPLAY_OUTPUT_FLAC FALSE CACHE BOOL "FLAC output support (libflac)" FORCE)
        MESSAGE(STATUS "Dependencies not found. Disabling flac output support")
    endif()
endif()

if(LIBZPLAY_OUTPUT_MP3)
    find_package(mp3lame CONFIG QUIET)
    if(${mp3lame_FOUND})
        SET(LIBZPLAY_SOURCE_FILES ${LIBZPLAY_SOURCE_FILES}
            ${LIBZPLAY_SRC}/wmp3encoder.cpp
            ${LIBZPLAY_SRC}/wmp3encoder.h
        )
    else()
        SET(LIBZPLAY_OUTPUT_MP3 FALSE CACHE BOOL "MP3 output support (mp3lame)" FORCE)
        MESSAGE(STATUS "Dependencies not found. Disabling mp3 output support")
    endif()
endif()

if(LIBZPLAY_OUTPUT_VORBIS)
    find_package(Ogg CONFIG QUIET)
    find_package(Vorbis CONFIG QUIET)
    if(${Ogg_FOUND} AND ${Vorbis_FOUND})
        SET(LIBZPLAY_SOURCE_FILES ${LIBZPLAY_SOURCE_FILES}
            ${LIBZPLAY_SRC}/wvorbisencoder.cpp
            ${LIBZPLAY_SRC}/wvorbisencoder.h
        )
    else()
        SET(LIBZPLAY_OUTPUT_VORBIS FALSE CACHE BOOL "Vorbis output support (vorbis)" FORCE)
        MESSAGE(STATUS "Dependencies not found. Disabling vorbis output support")
    endif()
endif()

if(LIBZPLAY_OUTPUT_WAV)
    SET(LIBZPLAY_SOURCE_FILES ${LIBZPLAY_SOURCE_FILES}
        ${LIBZPLAY_SRC}/wwaveencoder.cpp
        ${LIBZPLAY_SRC}/wwaveencoder.h
    )
endif()

add_library(${PROJECT_NAME} ${LIBZPLAY_SOURCE_FILES})
set_target_properties(${PROJECT_NAME} PROPERTIES PREFIX "")
target_compile_features(${PROJECT_NAME} PRIVATE cxx_std_11)
target_include_directories(${PROJECT_NAME}
    PUBLIC
        $<BUILD_INTERFACE:${LIBZPLAY_INCLUDE}>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
    PRIVATE
        ${LIBZPLAY_MINIAUDIO_PATH} ${LIBZPLAY_SRC}
)

if(WIN32 AND MINGW)
    target_link_libraries(${PROJECT_NAME} PRIVATE winmm)
endif()

target_link_libraries(${PROJECT_NAME} PRIVATE JPEG::JPEG PNG::PNG)

if(LIBZPLAY_DSP_SOUNDTOUCH)
    if(${SoundTouch_FOUND})
        target_link_libraries(${PROJECT_NAME} PRIVATE SoundTouch::SoundTouch)
        target_compile_definitions(${PROJECT_NAME} PRIVATE LIBZPLAY_DSP_SOUNDTOUCH)
    endif()
endif()

if(LIBZPLAY_INPUT_AAC)
    if(${FAAD2_FOUND})
        LIST(REMOVE_ITEM FAAD2_LINK_LIBRARIES m)
        target_link_libraries(${PROJECT_NAME} PRIVATE ${FAAD2_LINK_LIBRARIES})
        target_compile_definitions(${PROJECT_NAME} PRIVATE LIBZPLAY_INPUT_AAC)
    endif()
endif()

if(LIBZPLAY_INPUT_AC3)
    target_compile_definitions(${PROJECT_NAME} PRIVATE LIBZPLAY_INPUT_AC3)
endif()

if(LIBZPLAY_INPUT_FLAC)
    if(${FLAC_FOUND})
        target_link_libraries(${PROJECT_NAME} PRIVATE FLAC::FLAC Ogg::ogg)
        target_compile_definitions(${PROJECT_NAME} PRIVATE LIBZPLAY_INPUT_FLAC)
    endif()
endif()

if(LIBZPLAY_INPUT_MP3)
    if(${mad_FOUND})
        target_link_libraries(${PROJECT_NAME} PRIVATE mad::mad)
        target_compile_definitions(${PROJECT_NAME} PRIVATE LIBZPLAY_INPUT_MP3)
    endif()
endif()

if(LIBZPLAY_INPUT_VORBIS)
    if(${Ogg_FOUND} AND ${Vorbis_FOUND})
        target_link_libraries(${PROJECT_NAME} PRIVATE Ogg::ogg Vorbis::vorbisfile)
        target_compile_definitions(${PROJECT_NAME} PRIVATE LIBZPLAY_INPUT_VORBIS)
    endif()
endif()

if(LIBZPLAY_INPUT_WAV)
    target_compile_definitions(${PROJECT_NAME} PRIVATE LIBZPLAY_INPUT_WAV)
endif()

if(LIBZPLAY_INPUT_WAVEIN)
    target_compile_definitions(${PROJECT_NAME} PRIVATE LIBZPLAY_INPUT_WAVEIN)
endif()

if(LIBZPLAY_OUTPUT_AAC)
    target_compile_definitions(${PROJECT_NAME} PRIVATE LIBZPLAY_OUTPUT_AAC)
endif()

if(LIBZPLAY_OUTPUT_FLAC)
    if(${FLAC_FOUND} AND ${Ogg_FOUND})
        target_link_libraries(${PROJECT_NAME} PRIVATE FLAC::FLAC Ogg::ogg)
        target_compile_definitions(${PROJECT_NAME} PRIVATE LIBZPLAY_OUTPUT_FLAC)
    endif()
endif()

if(LIBZPLAY_OUTPUT_MP3)
    if(${mp3lame_FOUND})
        target_link_libraries(${PROJECT_NAME} PRIVATE mp3lame::mp3lame)
        target_compile_definitions(${PROJECT_NAME} PRIVATE LIBZPLAY_OUTPUT_MP3)
    endif()
endif()

if(LIBZPLAY_OUTPUT_VORBIS)
    if(${Ogg_FOUND} AND ${Vorbis_FOUND})
        target_link_libraries(${PROJECT_NAME} PRIVATE Ogg::ogg Vorbis::vorbisenc)
        target_compile_definitions(${PROJECT_NAME} PRIVATE LIBZPLAY_OUTPUT_VORBIS)
    endif()
endif()

if(LIBZPLAY_OUTPUT_WAV)
    target_compile_definitions(${PROJECT_NAME} PRIVATE LIBZPLAY_OUTPUT_WAV)
endif()

if(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
    target_compile_options(${PROJECT_NAME} PRIVATE -Wall -Wpedantic -O3)
    if(WIN32)
        target_compile_options(${PROJECT_NAME} PRIVATE -ffunction-sections -fdata-sections)
    endif()
endif()

if(LIBZPLAY_STATIC_CRT AND WIN32)
    if(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -static")
    elseif(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
        set_property(TARGET ${PROJECT_NAME} PROPERTY MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
    endif()
endif()

if(BUILD_SHARED_LIBS)
    target_compile_definitions(${PROJECT_NAME} PRIVATE LIB_ZPLAY_DYNAMIC)

    if(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
        target_link_libraries(${PROJECT_NAME} PRIVATE -s)
        if(WIN32)
            target_link_libraries(${PROJECT_NAME} PRIVATE -Wl,--gc-sections)
        endif()
    endif()

    if(LIBZPLAY_PACK_WITH_UPX)
        include(FindSelfPackers)
        if(SELF_PACKER_FOR_EXECUTABLE)
            ADD_CUSTOM_COMMAND(
                COMMAND ${SELF_PACKER_FOR_EXECUTABLE} $<TARGET_FILE:${PROJECT_NAME}>
                ARGS ${SELF_PACKER_FOR_EXECUTABLE_FLAGS} -9q
                TARGET ${PROJECT_NAME}
            )
        endif()
    endif()
else()
    target_compile_definitions(${PROJECT_NAME} PRIVATE LIB_ZPLAY_STATIC)
endif()

if(LIBZPLAY_BUILD_EXAMPLES)
    # Create a list of all examples
    set(examples)
    file(GLOB sources ${LIBZPLAY_EXAMPLES}/*.cpp)
    list(APPEND examples ${sources})

    # Build each example
    foreach(example_source ${examples})
        # Create the basename for the example
        get_filename_component(example_name ${example_source} NAME)
        string(REPLACE ".cpp" "${OUTPUT_EXT}" example_name ${example_name})

        # Setup the example
        add_executable(${example_name} ${example_source})

        target_compile_features(${example_name} PRIVATE cxx_std_11)
        target_link_libraries(${example_name} PRIVATE ${PROJECT_NAME})

        if(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
            target_compile_options(${example_name} PRIVATE -Wall -Wpedantic -O3)
            if(WIN32)
                target_compile_options(${example_name} PRIVATE -ffunction-sections -fdata-sections)
            endif()
        endif()

        if(LIBZPLAY_STATIC_CRT AND WIN32)
            if(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -static")
            elseif(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
                set_property(TARGET ${example_name} PROPERTY MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
            endif()
        endif()
    endforeach()
endif()

macro(message_bool_option _NAME _VALUE)
    if(${_VALUE})
        message(STATUS "  ${_NAME}: enabled")
    else()
        message(STATUS "  ${_NAME}: disabled")
    endif()
endmacro()

message(STATUS "libZPlay will be built with the following options:")
message_bool_option("Build shared library" BUILD_SHARED_LIBS)
message_bool_option("Export function names" LIBZPLAY_EXPORT_DLL)
message_bool_option("Use static CRT library" LIBZPLAY_STATIC_CRT)
message_bool_option("Pack programs with UPX" LIBZPLAY_PACK_WITH_UPX)
message_bool_option("Build example programs" LIBZPLAY_BUILD_EXAMPLES)

message(STATUS "libZPlay will be built with the following DSP audio processors:")
message_bool_option("Soundtouch audio processor support" LIBZPLAY_DSP_SOUNDTOUCH)

message(STATUS "libZPlay will be built with the following input formats:")
message_bool_option("AAC input support (faad2)" LIBZPLAY_INPUT_AAC)
message_bool_option("AC3 input support (liba52)" LIBZPLAY_INPUT_AC3)
message_bool_option("FLAC input support (libflac)" LIBZPLAY_INPUT_FLAC)
message_bool_option("MP3 input support (libmad)" LIBZPLAY_INPUT_MP3)
message_bool_option("Vorbis input support (vorbis)" LIBZPLAY_INPUT_VORBIS)
message_bool_option("PCM/WAV input support" LIBZPLAY_INPUT_WAV)
message_bool_option("WAVEIN input support" LIBZPLAY_INPUT_WAVEIN)

message(STATUS "libZPlay will be built with the following output formats:")
message_bool_option("AAC output support (faac)" LIBZPLAY_OUTPUT_AAC)
message_bool_option("FLAC output support (libflac)" LIBZPLAY_OUTPUT_FLAC)
message_bool_option("MP3 output support (mp3lame)" LIBZPLAY_OUTPUT_MP3)
message_bool_option("Vorbis output support (vorbis)" LIBZPLAY_OUTPUT_VORBIS)
message_bool_option("WAV output support" LIBZPLAY_OUTPUT_WAV)
