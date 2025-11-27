# Minimal stub FindLibAJANTV2.cmake for CI builds.
# Pretend AJA NTV2 (LibAJANTV2) is present so that the 'aja' plugin can
# configure without the real SDK.

message(STATUS "Using override FindLibAJANTV2.cmake from plugin repository")

# Fake include root for AJA libraries
set(AJA_LIBRARIES_INCLUDE_DIR "${CMAKE_CURRENT_LIST_DIR}")
set(AJA_LIBRARIES_INCLUDE_DIRS
  "${AJA_LIBRARIES_INCLUDE_DIR}"
  "${AJA_LIBRARIES_INCLUDE_DIR}/ajaanc"
  "${AJA_LIBRARIES_INCLUDE_DIR}/ajabase"
  "${AJA_LIBRARIES_INCLUDE_DIR}/ajantv2"
  "${AJA_LIBRARIES_INCLUDE_DIR}/ajantv2/includes"
)

# On Windows OBS 30.2.3's real module also appends a platform-specific src dir;
# for the stub we don't need that, but it is harmless to keep only the base dirs.
set(LIBAJANTV2_INCLUDE_DIRS "${AJA_LIBRARIES_INCLUDE_DIRS}")

# Fake library names
set(AJA_NTV2_LIB "ajantv2_stub")
set(LIBAJANTV2_LIBRARIES "${AJA_NTV2_LIB}")
set(LIBAJANTV2_DEBUG_LIBRARIES "${AJA_NTV2_LIB}")

# Mark as found
set(LIBAJANTV2_FOUND TRUE)

# Provide imported target expected by OBS
if(NOT TARGET AJA::LibAJANTV2)
  add_library(AJA::LibAJANTV2 INTERFACE IMPORTED)
  set_target_properties(AJA::LibAJANTV2 PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "${LIBAJANTV2_INCLUDE_DIRS}"
  )

  # Provide the same kind of compile definitions as the real module (simplified)
  target_compile_definitions(
    AJA::LibAJANTV2
    INTERFACE "$<$<BOOL:${OS_WINDOWS}>:AJA_WINDOWS;_WINDOWS;WIN32;MSWindows>"
  )
endif()
