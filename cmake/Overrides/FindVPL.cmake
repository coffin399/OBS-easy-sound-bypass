# Minimal stub FindVPL module for CI builds.
# Pretend Intel oneVPL is present so that obs-qsv11 can configure
# without the real VPL SDK installed.

message(STATUS "Using override FindVPL.cmake from plugin repository")

# Mark VPL as found with a fake but sufficient version
set(VPL_FOUND TRUE)
set(VPL_VERSION "2.6")

# Variables expected by OBS' FindVPL.cmake
set(VPL_INCLUDE_DIR "")
set(VPL_INCLUDE_DIRS "")
set(VPL_LIBRARY "")
set(VPL_LIBRARIES "")

# Provide a dummy interface target so target_link_libraries(... VPL::VPL)
# or similar does not fail.
if(NOT TARGET VPL::VPL)
  add_library(VPL::VPL INTERFACE IMPORTED)
endif()
