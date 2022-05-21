vcpkg_download_distfile(ARCHIVE
    URLS "https://liba52.sourceforge.io/files/a52dec-0.7.4.tar.gz"
    FILENAME "a52dec-0.7.4.tar.gz"
    SHA512 4b26fe9492f218b775fb190b76ecf06edaeb656adfe6dcbd24d0a0f86871c3ba917edb88a398eb12dccedaa1605b6f0a0be06b09f9fddd9a46e457b7dd244848
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

file(COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" DESTINATION "${SOURCE_PATH}")
file(COPY "${CMAKE_CURRENT_LIST_DIR}/liba52.def" DESTINATION "${SOURCE_PATH}")

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_copy_pdbs()

file(INSTALL "${SOURCE_PATH}/include"
    DESTINATION "${CURRENT_PACKAGES_DIR}/include"
    RENAME a52dec
    PATTERN "*.in" EXCLUDE
    PATTERN "*.am" EXCLUDE
)
file(INSTALL "${SOURCE_PATH}/vc++/config.h" DESTINATION "${CURRENT_PACKAGES_DIR}/include/a52dec")
file(INSTALL "${SOURCE_PATH}/vc++/inttypes.h" DESTINATION "${CURRENT_PACKAGES_DIR}/include/a52dec")
file(INSTALL "${SOURCE_PATH}/COPYING" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
