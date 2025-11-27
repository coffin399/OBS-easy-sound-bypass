# Minimal stub FindLibx264.cmake for CI builds.
# Pretend libx264 is present so that obs-x264 can configure
# without the real x264 library from obs-deps.

message(STATUS "Using override FindLibx264.cmake from plugin repository")

# Fake include dir / library
set(X264_INCLUDE_DIR "${CMAKE_CURRENT_LIST_DIR}")
set(X264_LIB "x264_stub")

# Tell CMake that Libx264 was found
set(LIBX264_FOUND TRUE)
set(LIBX264_INCLUDE_DIRS "${X264_INCLUDE_DIR}")
set(LIBX264_LIBRARIES "${X264_LIB}")

# Provide the imported target expected by the OBS build
if(NOT TARGET LIBX264::LIBX264)
  add_library(LIBX264::LIBX264 INTERFACE IMPORTED)
  set_target_properties(LIBX264::LIBX264 PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "${LIBX264_INCLUDE_DIRS}"
  )
endif()
