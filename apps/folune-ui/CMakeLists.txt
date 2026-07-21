cmake_minimum_required(VERSION 3.31.12)

project(folune_ui VERSION 0.1.0 LANGUAGES C)

find_path(LVGL_INCLUDE_DIR
  NAMES lvgl/lvgl.h
  REQUIRED
)

find_library(LVGL_LIBRARY
  NAMES lvgl
  REQUIRED
)

find_package(PkgConfig REQUIRED)
pkg_check_modules(LIBDRM REQUIRED IMPORTED_TARGET libdrm)

add_executable(folune-ui main.c)

target_compile_features(folune-ui PRIVATE c_std_17)

target_include_directories(folune-ui PRIVATE
  ${LVGL_INCLUDE_DIR}/lvgl
  ${LVGL_INCLUDE_DIR}
)

target_compile_definitions(folune-ui PRIVATE
  LV_CONF_INCLUDE_SIMPLE
)

target_link_libraries(folune-ui PRIVATE
  ${LVGL_LIBRARY}
  PkgConfig::LIBDRM
  m
)

install(TARGETS folune-ui
  RUNTIME DESTINATION bin
)
