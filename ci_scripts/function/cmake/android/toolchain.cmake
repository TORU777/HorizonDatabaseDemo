# created by dorgon, all right reserved

cmake_minimum_required( VERSION 3.1.0 )
# configure rtti
if( DEFINED WITH_RTTI )
 if( WITH_RTTI )
  	add_compile_options(-frtti)
 else()
 	add_compile_options(-fno-rtti)
 endif()
endif()

# configure exceptios
if( DEFINED WITH_EXCEPTIONS )
 if( WITH_EXCEPTIONS )
  	add_compile_options(-fexceptions)
 else()
  	add_compile_options(-fno-exceptions)
 endif()
endif()