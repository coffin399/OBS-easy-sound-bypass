# Minimal stub FindMbedTLS.cmake for CI builds.
# Pretend mbedTLS is present so that obs-outputs (RTMPS support) can
# configure without the real libraries from obs-deps.

message(STATUS "Using override FindMbedTLS.cmake from plugin repository")

# Fake include dir / libraries
set(MBEDTLS_INCLUDE_DIR "${CMAKE_CURRENT_LIST_DIR}")
set(MBEDTLS_LIB "mbedtls_stub")
set(MBEDCRYPTO_LIB "mbedcrypto_stub")
set(MBEDX509_LIB "mbedx509_stub")

# Aggregate variables like the real module would
set(MBEDTLS_INCLUDE_DIRS "${MBEDTLS_INCLUDE_DIR}")
set(MBEDTLS_LIBRARIES "${MBEDTLS_LIB};${MBEDCRYPTO_LIB};${MBEDX509_LIB}")

# Tell CMake that MbedTLS was found
set(MBEDTLS_FOUND TRUE)

# Provide imported targets expected by OBS (optional but keeps things closer
# to the real module behaviour).
foreach(component TLS CRYPTO X509)
  if(NOT TARGET Mbedtls::${component})
    add_library(Mbedtls::${component} INTERFACE IMPORTED)
    set_target_properties(Mbedtls::${component} PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${MBEDTLS_INCLUDE_DIRS}"
    )
  endif()
endforeach()

if(NOT TARGET Mbedtls::Mbedtls)
  add_library(Mbedtls::Mbedtls INTERFACE IMPORTED)
  target_link_libraries(Mbedtls::Mbedtls INTERFACE
    Mbedtls::TLS
    Mbedtls::CRYPTO
    Mbedtls::X509
  )
endif()
