# Minimal stub LibDataChannelConfig.cmake for CI builds.
# Pretend libdatachannel is present so that obs-webrtc can configure
# without the real library.

message(STATUS "Using override LibDataChannelConfig.cmake from plugin repository")

# Report LibDataChannel as found with a version compatible with 0.20
set(LibDataChannel_FOUND TRUE)
set(LibDataChannel_VERSION "0.20.0")

# Provide an imported interface target matching the expected name
if(NOT TARGET LibDataChannel::LibDataChannel)
  add_library(LibDataChannel::LibDataChannel INTERFACE IMPORTED)
  # Optional: expose a dummy include directory if someone queries it
  set_target_properties(LibDataChannel::LibDataChannel PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "${CMAKE_CURRENT_LIST_DIR}"
  )
endif()
