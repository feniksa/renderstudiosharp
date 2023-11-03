cmake_minimum_required (VERSION 3.16)
project (renderstudiosharp CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake")

option(FORCE_COLORED_OUTPUT "Always produce ANSI-colored output (GNU/Clang only)." FALSE)
option(EXPORT "Export sybmols" TRUE)

include("${CMAKE_SOURCE_DIR}/cmake/CompileOptions.cmake")

find_package(OpenSSL REQUIRED)
find_package(Boost REQUIRED COMPONENTS python json log log_setup)
find_package(pxr REQUIRED)
find_package(PythonInterp 3 REQUIRED)
find_package(PythonLibs 3 REQUIRED)
find_package(TBB REQUIRED)
find_package(RenderStudio REQUIRED)

add_subdirectory(src)


