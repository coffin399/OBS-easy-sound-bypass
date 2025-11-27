# Minimal stub FindZstd.cmake for CI builds.
# Pretend zstd is present so that the Windows updater target can link
# against zstd::libzstd_static without having the real library.

message(STATUS "Using override FindZstd.cmake from plugin repository")

# Mark Zstd as found
set(ZSTD_FOUND TRUE)

# Dummy include dir / library variables (kept minimal as OBS mainly
# uses the imported target)
set(ZSTD_INCLUDE_DIR "${CMAKE_CURRENT_LIST_DIR}")
set(ZSTD_LIBRARY "zstd_stub")

# Provide the imported static library target used by the OBS updater
if(NOT TARGET zstd::libzstd_static)
  add_library(zstd::libzstd_static INTERFACE IMPORTED)
  set_target_properties(zstd::libzstd_static PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "${ZSTD_INCLUDE_DIR}"
  )
endif()
