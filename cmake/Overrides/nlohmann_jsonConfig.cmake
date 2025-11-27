# Minimal stub nlohmann_jsonConfig.cmake for CI builds.
# Pretend nlohmann_json is present so that obs-websocket can configure
# without the real dependency.

message(STATUS "Using override nlohmann_jsonConfig.cmake from plugin repository")

# Mark nlohmann_json as found
set(nlohmann_json_FOUND TRUE)
set(nlohmann_json_VERSION "3.11.0")

# Provide an imported interface target matching the expected name
if(NOT TARGET nlohmann_json::nlohmann_json)
  add_library(nlohmann_json::nlohmann_json INTERFACE IMPORTED)
endif()
