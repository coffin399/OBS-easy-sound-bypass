# Minimal stub FindCURL module for CI builds.
# Marks CURL as found and provides a dummy CURL::libcurl target so that
# deps/file-updater can be configured without having actual libcurl on the system.

if(NOT TARGET CURL::libcurl)
    add_library(CURL::libcurl INTERFACE IMPORTED)
endif()

set(CURL_FOUND TRUE)
set(CURL_INCLUDE_DIR "")
set(CURL_LIBRARIES CURL::libcurl)
