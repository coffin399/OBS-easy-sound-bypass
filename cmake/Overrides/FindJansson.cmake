# Minimal stub FindJansson module for CI builds.
# Pretend a suitable Jansson library is present so that libobs can
# configure without the real dependency.

# Mark Jansson as found with a fake but sufficient version
set(Jansson_FOUND TRUE)
set(Jansson_VERSION "2.5")

# Variables expected by OBS' FindJansson.cmake
set(Jansson_INCLUDE_DIR "")
set(Jansson_LIB "")
set(Jansson_LIBRARIES "")

# Provide a dummy interface target so target_link_libraries(... ${Jansson_LIB})
# or similar does not fail.
if(NOT TARGET Jansson::Jansson)
  add_library(Jansson::Jansson INTERFACE IMPORTED)
endif()
