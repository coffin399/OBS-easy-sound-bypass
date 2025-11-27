# Minimal stub nlohmann_jsonConfigVersion.cmake for CI builds.
# Make any requested version up to 3.11.0 appear compatible.

# Report a concrete package version
set(PACKAGE_VERSION "3.11.0")

# Default to compatible
set(PACKAGE_VERSION_COMPATIBLE TRUE)

# If a version was requested, only fail when the requested version is
# strictly greater than what we report here.
if(PACKAGE_FIND_VERSION)
  if(PACKAGE_FIND_VERSION VERSION_GREATER PACKAGE_VERSION)
    set(PACKAGE_VERSION_COMPATIBLE FALSE)
  endif()
endif()
