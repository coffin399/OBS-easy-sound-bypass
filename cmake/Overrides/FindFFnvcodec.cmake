# Minimal stub FindFFnvcodec.cmake for CI builds.
# Pretend FFnvcodec headers are present so that obs-ffmpeg can configure
# without the real nv-codec headers from obs-deps.

message(STATUS "Using override FindFFnvcodec.cmake from plugin repository")

# Report FFnvcodec as found with a dummy but sufficient version
set(FFnvcodec_FOUND TRUE)
set(FFnvcodec_VERSION "12.0")

# Provide a dummy include directory so any consumers that still rely on
# the legacy include-dir variable see something non-empty.
set(FFnvcodec_INCLUDE_DIR "${CMAKE_CURRENT_LIST_DIR}")

# Provide the imported interface target expected by the OBS build
if(NOT TARGET FFnvcodec::FFnvcodec)
  add_library(FFnvcodec::FFnvcodec INTERFACE IMPORTED)
  set_target_properties(FFnvcodec::FFnvcodec PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "${FFnvcodec_INCLUDE_DIR}"
  )
endif()
