# Minimal stub FindUthash module for CI builds.
# Pretend uthash is present so that libobs can configure without
# obs-deps providing the real headers.

message(STATUS "Using override FindUthash.cmake from plugin repository")

# Mark Uthash as found with a fake but sufficient version
set(Uthash_FOUND TRUE)
set(Uthash_VERSION "2.0.0")

# Variables expected by OBS' FindUthash.cmake
set(Uthash_INCLUDE_DIR "${CMAKE_CURRENT_LIST_DIR}")
set(Uthash_INCLUDE_DIRS "${Uthash_INCLUDE_DIR}")

# Provide an imported interface target so that target_link_libraries can
# safely reference Uthash::Uthash.
if(NOT TARGET Uthash::Uthash)
  add_library(Uthash::Uthash INTERFACE IMPORTED)
  set_target_properties(Uthash::Uthash PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "${Uthash_INCLUDE_DIRS}"
  )
endif()
