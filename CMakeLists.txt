cmake_minimum_required(VERSION 3.16.0 FATAL_ERROR)

project(libzplay)

set(Header_Files
    "include/libzplay.h"
    "src/config.h"
    "src/debug.h"
    "src/waacdecoder.h"
    "src/waacencoder.h"
    "src/wac3decoder.h"
    "src/waudioprocessor.h"
    "src/wbmpfont.h"
    "src/wbpmdetect.h"
    "src/wbpmdetect1.h"
    "src/wbpmdetect2.h"
    "src/wbpmdetect3.h"
    "src/wcentercutprocessor.h"
    "src/wdecoder.h"
    "src/wechoprocessor.h"
    "src/wencoder.h"
    "src/weqprocessor.h"
    "src/wfft.h"
    "src/wflacdecoder.h"
    "src/wflacencoder.h"
    "src/winputprocessor.h"
    "src/wmp3decoder.h"
    "src/wmp3encoder.h"
    "src/wmp3x.h"
    "src/woggdecoder.h"
    "src/woutputprocessor.h"
    "src/wpcmdecoder.h"
    "src/wqueue.h"
    "src/wspectrum.h"
    "src/wstprocessor.h"
    "src/wtags.h"
    "src/wtools.h"
    "src/wvorbisencoder.h"
    "src/wwavedecoder.h"
    "src/wwaveencoder.h"
    "src/wwavein.h"
    "src/wwavelet.h"
)

set(Source_Files
    "src/libzplay.cpp"
    "src/libzplay.def"
    "src/waacdecoder.cpp"
    "src/waacencoder.cpp"
    "src/wac3decoder.cpp"
    "src/waudioprocessor.cpp"
    "src/wbmpfont.cpp"
    "src/wbpmdetect.cpp"
    "src/wbpmdetect1.cpp"
    "src/wbpmdetect2.cpp"
    "src/wbpmdetect3.cpp"
    "src/wcentercutprocessor.cpp"
    "src/wdecoder.cpp"
    "src/wechoprocessor.cpp"
    "src/wencoder.cpp"
    "src/weqprocessor.cpp"
    "src/wfft.cpp"
    "src/wflacdecoder.cpp"
    "src/wflacencoder.cpp"
    "src/winputprocessor.cpp"
    "src/wmp3decoder.cpp"
    "src/wmp3encoder.cpp"
    "src/wmp3x.cpp"
    "src/woggdecoder.cpp"
    "src/woutputprocessor.cpp"
    "src/wpcmdecoder.cpp"
    "src/wqueue.cpp"
    "src/wspectrum.cpp"
    "src/wstprocessor.cpp"
    "src/wtags.cpp"
    "src/wtools.cpp"
    "src/wvorbisencoder.cpp"
    "src/wwavedecoder.cpp"
    "src/wwaveencoder.cpp"
    "src/wwavein.cpp"
    "src/wwavelet.cpp"
)

set(ALL_FILES
    ${Header_Files}
    ${Source_Files}
)

add_library(${PROJECT_NAME} SHARED ${ALL_FILES})
add_library(${PROJECT_NAME}_static STATIC ${ALL_FILES})

set_target_properties(${PROJECT_NAME} PROPERTIES COMPILE_FLAGS -DLIB_ZPLAY_DYNAMIC)
set_target_properties(${PROJECT_NAME}_static PROPERTIES COMPILE_FLAGS -DLIB_ZPLAY_STATIC)
