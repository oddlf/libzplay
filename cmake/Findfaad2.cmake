find_path(faad2_INCLUDE_DIR NAMES faad.h faad/faad.h faad2/faad.h)
mark_as_advanced(faad2_INCLUDE_DIR)

find_library(faad2_LIBRARY NAMES faad)
mark_as_advanced(faad2_LIBRARY)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(faad2 REQUIRED_VARS
    faad2_INCLUDE_DIR
    faad2_LIBRARY
)

if(faad2_FOUND)
    set(faad2_INCLUDE_DIRS ${faad2_INCLUDE_DIR})
    set(faad2_LIBRARIES ${faad2_LIBRARY})
    if(NOT TARGET faad2::faad2)
        add_library(faad2::faad2 UNKNOWN IMPORTED)
        set_target_properties(faad2::faad2 PROPERTIES
            IMPORTED_LINK_INTERFACE_LANGUAGES "C"
            IMPORTED_LOCATION "${faad2_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${faad2_INCLUDE_DIR}")
    endif()
endif()
