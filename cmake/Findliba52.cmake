find_path(liba52_INCLUDE_DIR NAMES a52.h liba52/a52.h)
mark_as_advanced(liba52_INCLUDE_DIR)

find_library(liba52_LIBRARY NAMES liba52)
mark_as_advanced(liba52_LIBRARY)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(liba52 REQUIRED_VARS
    liba52_INCLUDE_DIR
    liba52_LIBRARY
)

if(liba52_FOUND)
    set(liba52_INCLUDE_DIRS ${liba52_INCLUDE_DIR})
    set(liba52_LIBRARIES ${liba52_LIBRARY})
    if(NOT TARGET liba52::liba52)
        add_library(liba52::liba52 UNKNOWN IMPORTED)
        set_target_properties(liba52::liba52 PROPERTIES
            IMPORTED_LINK_INTERFACE_LANGUAGES "C"
            IMPORTED_LOCATION "${liba52_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${liba52_INCLUDE_DIR}")
    endif()
endif()
