# Minimal stub FindWebsocketpp.cmake for CI builds.
# Pretend WebSocket++ is present so that obs-websocket can configure
# without the real dependency from obs-deps.

message(STATUS "Using override FindWebsocketpp.cmake from plugin repository")

# Report Websocketpp as found with a dummy but sufficient version
set(Websocketpp_FOUND TRUE)
set(Websocketpp_VERSION "0.8.0")

# Provide a dummy include directory so any consumers that still rely on
# the legacy include-dir variable see something non-empty.
set(Websocketpp_INCLUDE_DIR "${CMAKE_CURRENT_LIST_DIR}")

# Provide the imported interface target expected by the OBS build
if(NOT TARGET Websocketpp::Websocketpp)
  add_library(Websocketpp::Websocketpp INTERFACE IMPORTED)
  set_target_properties(Websocketpp::Websocketpp PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "${Websocketpp_INCLUDE_DIR}"
  )
endif()
