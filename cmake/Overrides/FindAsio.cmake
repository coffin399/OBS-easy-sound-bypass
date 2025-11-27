# Minimal stub FindAsio.cmake for CI builds.
# Pretend Asio is present so that obs-websocket can configure
# without the real dependency from obs-deps.

message(STATUS "Using override FindAsio.cmake from plugin repository")

# Report Asio as found with a dummy but sufficient version
set(Asio_FOUND TRUE)
set(Asio_VERSION "1.12.1")

# Provide a dummy include directory so any consumers that still rely on
# the legacy include-dir variable see something non-empty.
set(Asio_INCLUDE_DIR "${CMAKE_CURRENT_LIST_DIR}")

# Provide the imported interface target expected by the OBS build
if(NOT TARGET Asio::Asio)
  add_library(Asio::Asio INTERFACE IMPORTED)
  set_target_properties(Asio::Asio PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "${Asio_INCLUDE_DIR}"
  )
endif()
