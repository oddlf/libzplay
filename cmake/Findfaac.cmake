find_path(faac_INCLUDE_DIR NAMES faac.h faac/faac.h)
mark_as_advanced(faac_INCLUDE_DIR)

find_library(faac_LIBRARY NAMES faac)
mark_as_advanced(faac_LIBRARY)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(faac REQUIRED_VARS
    faac_INCLUDE_DIR
    faac_LIBRARY
)

if(faac_FOUND)
    set(faac_INCLUDE_DIRS ${faac_INCLUDE_DIR})
    set(faac_LIBRARIES ${faac_LIBRARY})
    if(NOT TARGET faac::faac)
        add_library(faac::faac UNKNOWN IMPORTED)
        set_target_properties(faac::faac PROPERTIES
            IMPORTED_LINK_INTERFACE_LANGUAGES "C"
            IMPORTED_LOCATION "${faac_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${faac_INCLUDE_DIR}")
    endif()
endif()
