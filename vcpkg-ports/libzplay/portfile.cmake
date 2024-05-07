vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO oddlf/libzplay
    REF "v${VERSION}"
    SHA512 fa529884c5599df261f5f4a9872c1c2de49516cef6166032d1c895f3090d3d59d6dca33283445b619b69bd5c6e464c7e9c9ad20d78ce738e2b0d25ecbd51fec8
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        dsp-soundtouch      LIBZPLAY_DSP_SOUNDTOUCH
        in-aac              LIBZPLAY_INPUT_AAC
        in-ac3              LIBZPLAY_INPUT_AC3
        in-flac             LIBZPLAY_INPUT_FLAC
        in-mp3              LIBZPLAY_INPUT_MP3
        in-vorbis           LIBZPLAY_INPUT_VORBIS
        in-wav              LIBZPLAY_INPUT_WAV
        in-wavein           LIBZPLAY_INPUT_WAVEIN
        out-aac             LIBZPLAY_OUTPUT_AAC
        out-flac            LIBZPLAY_OUTPUT_FLAC
        out-mp3             LIBZPLAY_OUTPUT_MP3
        out-vorbis          LIBZPLAY_OUTPUT_VORBIS
        out-wav             LIBZPLAY_OUTPUT_WAV
)

string(COMPARE EQUAL "${VCPKG_CRT_LINKAGE}" "static" LIBZPLAY_STATIC_CRT)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DLIBZPLAY_STATIC_CRT=${LIBZPLAY_STATIC_CRT}
        -DLIBZPLAY_PACK_WITH_UPX=OFF
        -DLIBZPLAY_BUILD_EXAMPLES=OFF
        -DLIBZPLAY_INSTALL=ON
        ${FEATURE_OPTIONS}
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/libzplay)
vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/license/GPL.TXT")
file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
