# Minimal stub FindLibspeexdsp.cmake for CI builds.
# Pretend libspeexdsp is present so that obs-filters can configure
# without the real library from obs-deps.

message(STATUS "Using override FindLibspeexdsp.cmake from plugin repository")

# Fake include dir / library
set(SPEEXDSP_INCLUDE_DIR "${CMAKE_CURRENT_LIST_DIR}")
set(SPEEXDSP_LIB "speexdsp_stub")

# Tell CMake that Libspeexdsp was found
set(LIBSPEEXDSP_FOUND TRUE)
set(LIBSPEEXDSP_INCLUDE_DIRS "${SPEEXDSP_INCLUDE_DIR}")
set(LIBSPEEXDSP_LIBRARIES "${SPEEXDSP_LIB}")

# Provide the imported target expected by OBS
if(NOT TARGET LibspeexDSP::LibspeexDSP)
  add_library(LibspeexDSP::LibspeexDSP INTERFACE IMPORTED)
  set_target_properties(LibspeexDSP::LibspeexDSP PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "${LIBSPEEXDSP_INCLUDE_DIRS}"
  )
endif()
