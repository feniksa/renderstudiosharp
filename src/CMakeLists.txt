#set(HEADERS
#	usdlib.h
#)

#set(SOURCES	
#	usdlib.cpp
#)

#add_library(renderstudiosharp SHARED ${HEADERS} ${SOURCES})
#target_compile_definitions(renderstudiosharp PUBLIC "-DNOMINMAX=1")
#target_include_directories(renderstudiosharp PUBLIC
#		"${PXR_INCLUDE_DIRS}"
#)
#target_link_directories(usdproxy PUBLIC "c:/libs/usd/lib")
#target_link_libraries(usdproxy PUBLIC
#		Boost::atomic Boost::regex
#		"${PXR_LIBRARIES}"
#)
#if (EXPORT)
#	target_compile_definitions(usdproxy PRIVATE "-DEXPORT=1")
#endif()

add_subdirectory(swig)
