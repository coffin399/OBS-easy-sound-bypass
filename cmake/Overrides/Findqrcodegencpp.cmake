# Minimal stub Findqrcodegencpp.cmake for CI builds.
# Pretend qrcodegencpp is present so that obs-websocket can configure
# without the real dependency.

message(STATUS "Using override Findqrcodegencpp.cmake from plugin repository")

# Report qrcodegencpp as found with a dummy version
set(qrcodegencpp_FOUND TRUE)
set(qrcodegencpp_VERSION "1.0.0")

# Provide dummy include directory / library values so any consumers
# depending on the legacy variables see something sensible.
set(qrcodegencpp_INCLUDE_DIR "${CMAKE_CURRENT_LIST_DIR}")
set(qrcodegencpp_LIBRARY "qrcodegencpp_stub")

# Provide an imported interface target matching the expected name
if(NOT TARGET qrcodegencpp::qrcodegencpp)
  add_library(qrcodegencpp::qrcodegencpp INTERFACE IMPORTED)
  set_target_properties(qrcodegencpp::qrcodegencpp PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "${qrcodegencpp_INCLUDE_DIR}"
  )
endif()
