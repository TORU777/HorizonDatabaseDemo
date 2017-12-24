set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${HORIZON_ENGINE_ROOT}/cmake/Modules/")

FUNCTION (FindBoost)	
	MESSAGE( STATUS "FindBoost==============BOOST_ROOT: ${BOOST_ROOT}" )
	set (Boost_NO_SYSTEM_PATHS ON)
	set (Boost_USE_MULTITHREADED ON)
	set (Boost_USE_STATIC_LIBS ON)
	set (Boost_USE_STATIC_RUNTIME OFF)
	set (BOOST_ALL_DYN_LINK OFF)
	set (Boost_DEBUG TRUE)
	set(BOOST_ROOT ${BOOST_ROOT})
	set(BOOST_INCLUDEDIR ${BOOST_INCLUDE_DIR})
	set(BOOST_LIBRARYDIR ${BOOST_LIBRARYDIR})

	find_package(Boost COMPONENTS filesystem log REQUIRED) 

	if(Boost_FOUND)
		MESSAGE( STATUS "Boost_LIBRARY_DIRS: ${Boost_LIBRARY_DIRS}" )
		MESSAGE( STATUS "Boost_INCLUDE_DIR: ${Boost_INCLUDE_DIR}" )
		MESSAGE( STATUS "Boost_LIBRARIES: ${Boost_LIBRARIES}" )

		link_directories(${Boost_LIBRARY_DIRS})
		include_directories( ${Boost_INCLUDE_DIR})
	endif()

ENDFUNCTION()


FUNCTION (GetBoostVersion)
  # Extract Boost_VERSION and Boost_LIB_VERSION from version.hpp
  set(Boost_VERSION 0)
  set(Boost_LIB_VERSION "")
  file(STRINGS "$ENV{BOOST_INCLUDE_DIR}/boost/version.hpp" _boost_VERSION_HPP_CONTENTS REGEX "#define BOOST_(LIB_)?VERSION ")
  set(_Boost_VERSION_REGEX "([0-9]+)")
  set(_Boost_LIB_VERSION_REGEX "\"([0-9_]+)\"")
  foreach(v VERSION LIB_VERSION)
    if("${_boost_VERSION_HPP_CONTENTS}" MATCHES "#define BOOST_${v} ${_Boost_${v}_REGEX}")
      set(Boost_${v} "${CMAKE_MATCH_1}" PARENT_SCOPE)
    endif()
  endforeach()
  unset(_boost_VERSION_HPP_CONTENTS)

  math(EXPR Boost_MAJOR_VERSION "${Boost_VERSION} / 100000")
  math(EXPR Boost_MINOR_VERSION "${Boost_VERSION} / 100 % 1000")
  math(EXPR Boost_SUBMINOR_VERSION "${Boost_VERSION} % 100")

ENDFUNCTION()




FUNCTION (SetupBoost)
	message("ENV{BOOST_INCLUDE_DIR}: 	$ENV{BOOST_INCLUDE_DIR}")
	message("ENV{BOOST_LIBRARYDIR}: 	$ENV{BOOST_LIBRARYDIR}")
	include_directories($ENV{BOOST_INCLUDE_DIR})
ENDFUNCTION()


FUNCTION (LinkBoost targetName)
	#ex:
	#libboost_system-vc110-mt-gd-1_59.lib
	#libboost_system-vc110-mt-1_59.lib
	#libboost_system-gcc-mt-1_59.a
	set(prefix "libboost_")
	set(mt "-mt-")
	IF(MSVC)
		set(suffix ".lib")
		IF(MSVC11)	#vs2012
			set(toolset "-vc110")
		ELSEIF(MSVC12) #vs2013
			set(toolset "-vc120")
		ELSEIF(MSVC14) #vs2015
			set(toolset "-vc140")
		ENDIF()
	ELSE()
		set(toolset "-gcc")
		set(suffix ".a")
	ENDIF()

	GetBoostVersion()
	message("Boost_VERSION: 	${Boost_VERSION}")
	message("Boost_LIB_VERSION: ${Boost_LIB_VERSION}")
	message("BOOST_LIBRARIES: 	$ENV{BOOST_LIBRARIES}")
	string(REPLACE " " ";" BOOST_LIBRARIES_LIST $ENV{BOOST_LIBRARIES})
	FOREACH(libFileName ${BOOST_LIBRARIES_LIST})
		set(libFilePath 
		"$ENV{BOOST_LIBRARYDIR}${prefix}${libFileName}${toolset}${mt}${Boost_LIB_VERSION}${suffix}")

		IF(EXISTS ${libFilePath})
		   message("LinkBoost: find file ${libFilePath}")
		   list(APPEND libBoostList ${libFilePath})
		ELSE()
		   message(FATAL_ERROR "LinkBoost: can't find file ${libFilePath}")
		ENDIF()		
	ENDFOREACH()
	#message("LinkBoost: ${libBoostList}")
	message(STATUS "${targetName}: ${libBoostList}")
	target_link_libraries(${targetName} ${libBoostList})
ENDFUNCTION(LinkBoost)




FUNCTION (LinkStaticLibrary targetName libName)
	#ex
	#libbox2dStatic.a
	#box2dStatic.lib
	# BOX2D_INCLUDE_DIR
	# BOX2D_LIBRARYDIR
	string(TOUPPER ${libName} LIB_NAME)
	set(INCLUDE_DIR ${LIB_NAME}_INCLUDE_DIR)
	set(LIBRARYDIR_DIR ${LIB_NAME}_LIBRARYDIR)
	include_directories("$ENV{${INCLUDE_DIR}}")
	link_directories($ENV{${LIBRARYDIR_DIR}})
	IF(MSVC)
		set(prefix "")
		set(suffix ".lib")
	ELSE()
		set(prefix "lib")
		set(suffix ".a")
	ENDIF()
	set(libraryFilePath $ENV{${LIBRARYDIR_DIR}}/${prefix}${libName}${suffix})
	target_link_libraries(${targetName} ${libraryFilePath})

ENDFUNCTION(LinkStaticLibrary)







FUNCTION(horizon_use_boost targetName)
option(USE_BOOST "Use BOOST" ON)
if(USE_BOOST)
	#link_directories($ENV{BOOST_LIBRARYDIR})
	IF (WIN32)
		#use auto link
	ELSE()
		add_definitions(-DBOOST_ALL_NO_LIB)
		LinkBoost(${targetName})
	ENDIF()
	target_include_directories(${targetName} PUBLIC $ENV{BOOST_INCLUDE_DIR})
	add_definitions(-DUSE_BOOST=1)
endif(USE_BOOST)
ENDFUNCTION(horizon_use_boost)



function(horizon_use_rapidjson target)
option(USE_RAPIDJSON "Use rapidjson" OFF)
if(USE_RAPIDJSON)
add_definitions(-DUSE_RAPIDJSON=1)
set(RAPIDJSON_INCLUDE_PATH $ENV{HORIZON_ENGINE_ROOT}/thirdparty/librapidjson/rapidjson/include)
target_include_directories(${target} PUBLIC ${RAPIDJSON_INCLUDE_PATH})
endif(USE_RAPIDJSON)
endfunction(horizon_use_rapidjson)



function(horizon_use_pkg target pkg)
option(USE_{pkg} "Use ${pkg}" OFF)
if(USE_{pkg})
add_definitions(-DUSE_{pkg}=1)
set({pkg}_INCLUDE_PATH $ENV{HORIZON_ENGINE_ROOT}/thirdparty/librapidjson/rapidjson/include)
target_include_directories(${target} PUBLIC ${${pkg}_INCLUDE_PATH})
endif(USE_RAPIDJSON)
endfunction()