# Minimal stub LibDataChannelConfigVersion.cmake for CI builds.
# Make any requested version up to 0.20.0 appear compatible.

set(PACKAGE_VERSION "0.20.0")

# Default: compatible
set(PACKAGE_VERSION_COMPATIBLE TRUE)

if(PACKAGE_FIND_VERSION)
  if(PACKAGE_FIND_VERSION VERSION_GREATER PACKAGE_VERSION)
    set(PACKAGE_VERSION_COMPATIBLE FALSE)
  endif()
endif()
