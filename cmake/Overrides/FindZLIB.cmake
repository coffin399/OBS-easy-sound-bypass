# Minimal stub FindZLIB module for CI builds.
# Pretend ZLIB is present so that libobs can configure without the
# real zlib library installed.

message(STATUS "Using override FindZLIB.cmake from plugin repository")

# Mark ZLIB as found
set(ZLIB_FOUND TRUE)

# Variables expected by CMake's FindZLIB and OBS' legacy scripts
set(ZLIB_INCLUDE_DIR "")
set(ZLIB_INCLUDE_DIRS "")
set(ZLIB_LIBRARY "")
set(ZLIB_LIBRARIES "")

# Provide a dummy interface target so target_link_libraries(... ZLIB::ZLIB)
# or similar does not fail.
if(NOT TARGET ZLIB::ZLIB)
  add_library(ZLIB::ZLIB INTERFACE IMPORTED)
endif()
