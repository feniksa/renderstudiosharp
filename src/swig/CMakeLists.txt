#set(SWIG_DIR "${CMAKE_SOURCE_DIR}/ThirdParty/swigwin-4.1.1")
set(SWIG_EXECUTABLE "${CMAKE_SOURCE_DIR}/ThirdParty/swigwin-4.1.1/swig.exe")

find_package(SWIG 4.0 REQUIRED)
include(${SWIG_USE_FILE})

get_target_property(RenderStudio_INCLUDE_DIR RenderStudio::Kit INTERFACE_INCLUDE_DIRECTORIES)

include_directories(
        ${PXR_INCLUDE_DIRS}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${CMAKE_SOURCE_DIR}/src
	${RenderStudio_INCLUDE_DIR}
)

message(STATUS "${RenderStudio_INCLUDE_DIR}")

foreach(header IN LISTS HEADERS)
    list(APPEND SWIG_HEADERS "${CMAKE_SOURCE_DIR}/src/${header}")
endforeach()

foreach(source IN LISTS SOURCES)
    list(APPEND SWIG_CPP "${CMAKE_SOURCE_DIR}/src/${source}")
endforeach()
add_custom_target(SwigFilesFakeDep ALL DEPENDS ${SWIG_HEADERS} ${SWIG_CPP})

#set_property(SOURCE usdlib.i PROPERTY SWIG_MODULE_NAME mymod_realname)
set_property(SOURCE Kit.i PROPERTY CPLUSPLUS ON)
set(CMAKE_SWIG_FLAGS "-namespace" "USDPROXY.NET" "-dllimport" "RenderStudioKit.NET.dll")
swig_add_library(RenderStudioKit.NET
	TYPE SHARED
        LANGUAGE csharp
        OUTPUT_DIR "${CMAKE_CURRENT_BINARY_DIR}"
        SOURCES
        Kit.i
)

set_target_properties(RenderStudioKit.NET PROPERTIES CXX_STANDARD_REQUIRED 14)
swig_link_libraries(RenderStudioKit.NET RenderStudio::Kit Boost::json)
add_dependencies(RenderStudioKit.NET SwigFilesFakeDep)

# Tag the generated folders so they are removed when doing calling the clean target
# Doesn't work with the VC generator ...
set_target_properties(RenderStudioKit.NET PROPERTIES ADDITIONAL_CLEAN_FILES "${CMAKE_BINARY_DIR}/*.cs;")

include(GNUInstallDirs)
file(GLOB CSS CONFIGURE_DEPENDS "${CMAKE_CURRENT_BINARY_DIR}/*.cs")
foreach (csfile ${CSS})
    install(FILES "${csfile}" DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
endforeach ()

#set_target_properties(usdproxy PROPERTIES PUBLIC_HEADERS "usdlib.h")
install(TARGETS RenderStudioKit.NET DESTINATION ${CMAKE_INSTALL_LIBDIR})
