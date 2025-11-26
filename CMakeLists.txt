cmake_minimum_required(VERSION 3.16)
project(easy_sound_bypass_plugin VERSION 0.1.0)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)

# OBS / Qt のパスは CMake 実行時に設定してください
set(OBS_INCLUDE_DIR "C:/path/to/obs-studio/libobs" CACHE PATH "OBS libobs include dir")
set(OBS_FRONTEND_INCLUDE_DIR "C:/path/to/obs-studio/UI/obs-frontend-api" CACHE PATH "OBS frontend api include dir")
set(OBS_LIB_DIR "C:/path/to/obs-studio/build/libobs" CACHE PATH "OBS lib dir")
set(OBS_FRONTEND_LIB_DIR "C:/path/to/obs-studio/build/UI/obs-frontend-api" CACHE PATH "OBS frontend lib dir")

find_package(Qt6 COMPONENTS Widgets Core Gui REQUIRED)

add_library(easy-sound-bypass MODULE
    src/cable_router.cpp
)

target_include_directories(easy-sound-bypass PRIVATE
    ${OBS_INCLUDE_DIR}
    ${OBS_FRONTEND_INCLUDE_DIR}
)

link_directories(
    ${OBS_LIB_DIR}
    ${OBS_FRONTEND_LIB_DIR}
)

target_link_libraries(easy-sound-bypass PRIVATE
    obs
    obs-frontend-api
    Qt6::Widgets
    Qt6::Core
    Qt6::Gui
)

set_target_properties(easy-sound-bypass PROPERTIES
    PREFIX ""
    OUTPUT_NAME "easy-sound-bypass"
)
