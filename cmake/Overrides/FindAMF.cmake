# Minimal stub FindAMF.cmake for CI builds.
# Pretend AMF (AMD Media Framework) is present so that obs-ffmpeg can
# configure without the real headers from obs-deps.

message(STATUS "Using override FindAMF.cmake from plugin repository")

# Report AMF as found with a dummy but sufficient version
set(AMF_FOUND TRUE)
set(AMF_VERSION "1.4.29")

# Provide a dummy include directory so any consumers that still rely on
# the legacy include-dir variable see something non-empty.
set(AMF_INCLUDE_DIR "${CMAKE_CURRENT_LIST_DIR}")

# Provide the imported interface target expected by the OBS build
if(NOT TARGET AMF::AMF)
  add_library(AMF::AMF INTERFACE IMPORTED)
  set_target_properties(AMF::AMF PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "${AMF_INCLUDE_DIR}"
  )
endif()
