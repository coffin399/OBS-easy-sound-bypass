# Minimal stub FindVulkan module for CI builds.
# Pretend Vulkan SDK is present so that win-capture/graphics-hook can
# configure without a real Vulkan installation.

message(STATUS "Using override FindVulkan.cmake from plugin repository")

# Mark Vulkan as found
set(Vulkan_FOUND TRUE)
set(Vulkan_VERSION "1.0.0")

# Variables expected by CMake's FindVulkan and OBS scripts
set(Vulkan_INCLUDE_DIR "")
set(Vulkan_LIBRARY "")
set(Vulkan_LIBRARIES "")

# Provide a dummy interface target so target_link_libraries(... Vulkan::Vulkan)
# does not fail.
if(NOT TARGET Vulkan::Vulkan)
  add_library(Vulkan::Vulkan INTERFACE IMPORTED)
endif()
