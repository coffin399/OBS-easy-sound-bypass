# Minimal stub FindFreetype.cmake for CI builds.
# Pretend FreeType is present so that text-freetype2 can configure
# without the real library from obs-deps or the system.

message(STATUS "Using override FindFreetype.cmake from plugin repository")

# Fake include dir / library
set(FREETYPE_INCLUDE_DIRS "${CMAKE_CURRENT_LIST_DIR}")
set(FREETYPE_INCLUDE_DIR "${CMAKE_CURRENT_LIST_DIR}")
set(FREETYPE_LIBRARIES "freetype_stub")
set(FREETYPE_LIBRARY "freetype_stub")

# Tell CMake that FreeType was found
set(FREETYPE_FOUND TRUE)

# Provide the imported target expected by modern CMake consumers
if(NOT TARGET Freetype::Freetype)
  add_library(Freetype::Freetype INTERFACE IMPORTED)
  set_target_properties(Freetype::Freetype PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "${FREETYPE_INCLUDE_DIRS}"
  )
endif()
