# Minimal stub FindLuajit module for CI builds.
# Pretend LuaJIT is present so that obs-scripting/obslua can configure
# without having the real LuaJIT installed.

# Mark LuaJIT as found
set(LUAJIT_FOUND TRUE)

# Variables expected by OBS' FindLuajit.cmake / legacy scripts
set(LUAJIT_LIB "")
set(LUAJIT_LIBRARY "")
set(LUAJIT_INCLUDE_DIR "")

# Provide a dummy interface target so target_link_libraries(... ${LUAJIT_LIB})
# or similar does not fail.
if(NOT TARGET luajit)
  add_library(luajit INTERFACE IMPORTED)
endif()
