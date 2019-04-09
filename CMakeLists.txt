cmake_minimum_required(VERSION 2.8 FATAL_ERROR)
project(test_travis)
message(STATUS "CMake version: " ${CMAKE_VERSION})

add_subdirectory(src)

enable_testing()
add_subdirectory(test)

add_subdirectory(doc)
