# Minimal stub FindFFmpeg module for CI builds.
# This pretends FFmpeg is present so that deps/media-playback and related
# components can configure without actual FFmpeg libraries.

# Mark FFmpeg as found
set(FFMPEG_FOUND TRUE)

# Provide dummy include dirs and libraries variables expected by OBS' FindFFmpeg.cmake
set(FFMPEG_AVCODEC_INCLUDE_DIRS "")
set(FFMPEG_AVDEVICE_INCLUDE_DIRS "")
set(FFMPEG_AVFORMAT_INCLUDE_DIRS "")
set(FFMPEG_AVUTIL_INCLUDE_DIRS "")

set(FFMPEG_AVCODEC_LIBRARIES "")
set(FFMPEG_AVDEVICE_LIBRARIES "")
set(FFMPEG_AVFORMAT_LIBRARIES "")
set(FFMPEG_AVUTIL_LIBRARIES "")

# Also create interface targets with the expected names so that
# target_link_libraries(... avcodec avdevice avutil avformat) and
# target_link_libraries(... FFmpeg::avcodec ...) do not fail.
foreach(_fflib avcodec avdevice avutil avformat swscale swresample)
  if(NOT TARGET ${_fflib})
    add_library(${_fflib} INTERFACE IMPORTED)
  endif()

  # Namespaced FFmpeg targets, e.g. FFmpeg::avcodec
  if(NOT TARGET FFmpeg::${_fflib})
    add_library(FFmpeg::${_fflib} INTERFACE IMPORTED)
    # Point them at the same (dummy) include dirs as the plain targets.
    set_target_properties(FFmpeg::${_fflib} PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${CMAKE_CURRENT_LIST_DIR}"
    )
  endif()
endforeach()
