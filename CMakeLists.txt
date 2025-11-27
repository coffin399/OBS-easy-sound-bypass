cmake_minimum_required(VERSION 3.16)
project(easy_sound_bypass_plugin VERSION 0.1.0)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)

#! OBS / Qt のパスは CMake 実行時に設定してください
set(OBS_INCLUDE_DIR "C:/path/to/obs-studio/libobs" CACHE PATH "OBS libobs include dir")
set(OBS_FRONTEND_INCLUDE_DIR "C:/path/to/obs-studio/UI/obs-frontend-api" CACHE PATH "OBS frontend api include dir")
set(OBS_LIB_DIR "C:/path/to/obs-studio/build/libobs" CACHE PATH "OBS lib dir")
set(OBS_FRONTEND_LIB_DIR "C:/path/to/obs-studio/build/UI/obs-frontend-api" CACHE PATH "OBS frontend lib dir")
set(OBS_CONFIG_DIR "C:/path/to/obs-studio/build/config" CACHE PATH "OBS config dir (for obsconfig.h)")

find_package(Qt6 COMPONENTS Widgets Core Gui REQUIRED)

include_directories(
    ${OBS_INCLUDE_DIR}
    ${OBS_FRONTEND_INCLUDE_DIR}
    ${OBS_CONFIG_DIR}
)

find_library(LIBOBS_LIB
    NAMES obs libobs
    PATHS ${OBS_LIB_DIR}
    NO_DEFAULT_PATH
)

find_library(OBS_FRONTEND_LIB
    NAMES obs-frontend-api libobs-frontend-api
    PATHS ${OBS_FRONTEND_LIB_DIR}
    NO_DEFAULT_PATH
)

if(NOT LIBOBS_LIB)
    message(FATAL_ERROR "libobs library not found in OBS_LIB_DIR: ${OBS_LIB_DIR}")
endif()

if(NOT OBS_FRONTEND_LIB)
    message(FATAL_ERROR "obs-frontend-api library not found in OBS_FRONTEND_LIB_DIR: ${OBS_FRONTEND_LIB_DIR}")
endif()

add_library(easy-sound-bypass MODULE
    src/cable_router.cpp
)

target_include_directories(easy-sound-bypass PRIVATE
    ${OBS_INCLUDE_DIR}
    ${OBS_FRONTEND_INCLUDE_DIR}
    ${OBS_CONFIG_DIR}
)

link_directories(
    ${OBS_LIB_DIR}
    ${OBS_FRONTEND_LIB_DIR}
)

target_link_libraries(easy-sound-bypass PRIVATE
    ${LIBOBS_LIB}
    ${OBS_FRONTEND_LIB}
    Qt6::Widgets
    Qt6::Core
    Qt6::Gui
)

set_target_properties(easy-sound-bypass PROPERTIES
    PREFIX ""
    OUTPUT_NAME "easy-sound-bypass"
)
