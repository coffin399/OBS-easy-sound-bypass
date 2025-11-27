# Minimal stub FindUthash module for CI builds.
# Pretend uthash is present so that libobs can configure without
# obs-deps providing the real headers.

message(STATUS "Using override FindUthash.cmake from plugin repository")

# Mark Uthash as found with a fake but sufficient version
set(Uthash_FOUND TRUE)
set(Uthash_VERSION "2.0.0")

# Variables expected by OBS' FindUthash.cmake
set(Uthash_INCLUDE_DIR "")
set(Uthash_INCLUDE_DIRS "")

# No library to link (uthash is header-only), so nothing else needed.
