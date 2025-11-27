# Minimal stub FindDetours module for CI builds.
# Pretend Microsoft Detours is present so that win-capture/graphics-hook
# can configure without the real library.

message(STATUS "Using override FindDetours.cmake from plugin repository")

# Mark Detours as found
set(Detours_FOUND TRUE)

# Variables expected by OBS' FindDetours.cmake
set(DETOURS_INCLUDE_DIR "")
set(DETOURS_LIB "")
set(DETOURS_LIBRARIES "")

# Provide a dummy interface target so target_link_libraries(... ${DETOURS_LIB})
# or Detours::Detours does not fail.
if(NOT TARGET Detours::Detours)
  add_library(Detours::Detours INTERFACE IMPORTED)
endif()
