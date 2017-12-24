
# Macro, Visio Studio directory packet (filter) 
macro(source_group_by_dir source_files)
    if(MSVC)
        set(sgbd_cur_dir ${CMAKE_CURRENT_SOURCE_DIR})
        foreach(sgbd_file ${${source_files}})
            string(REGEX REPLACE ${sgbd_cur_dir}/\(.*\) \\1 sgbd_fpath ${sgbd_file})
            string(REGEX REPLACE "\(.*\)/.*" \\1 sgbd_group_name ${sgbd_fpath})
            string(COMPARE EQUAL ${sgbd_fpath} ${sgbd_group_name} sgbd_nogroup)
            string(REPLACE "/" "\\" sgbd_group_name ${sgbd_group_name})
            if(sgbd_nogroup)
                set(sgbd_group_name "\\")
            endif(sgbd_nogroup)
            source_group(${sgbd_group_name} FILES ${sgbd_file})
        endforeach(sgbd_file)
    endif(MSVC)
endmacro(source_group_by_dir)

MACRO(ADD_MSVC_PRECOMPILED_HEADER PrecompiledHeader PrecompiledSource Sources)
  IF(MSVC)
    GET_FILENAME_COMPONENT(PrecompiledBasename ${PrecompiledHeader} NAME_WE)
    #${CMAKE_CURRENT_BINARY_DIR}
    #$(IntDir)
    #MESSAGE( STATUS "{CMAKE_CURRENT_BINARY_DIR}:        ${CMAKE_CURRENT_BINARY_DIR}" )
    #MESSAGE( STATUS "(EXECUTABLE_OUTPUT_PATH ):        ${EXECUTABLE_OUTPUT_PATH}" )
    #MESSAGE( STATUS "(RUNTIME_OUTPUT_DIRECTORY):        ${RUNTIME_OUTPUT_DIRECTORY}" )
    SET(PrecompiledBinary "$(IntDir)/${PrecompiledBasename}.pch")
    #SET(Sources ${SourcesVar})

    SET_SOURCE_FILES_PROPERTIES(${PrecompiledSource}
                                PROPERTIES COMPILE_FLAGS "/Yc\"${PrecompiledHeader}\" /Fp\"${PrecompiledBinary}\""
                                           OBJECT_OUTPUTS "${PrecompiledBinary}")
                                           
    foreach( src_file ${Sources} )                                      
            SET_SOURCE_FILES_PROPERTIES(${src_file}
                                PROPERTIES COMPILE_FLAGS "/Yu\"${PrecompiledHeader}\" /FI\"${PrecompiledHeader}\" /Fp\"${PrecompiledBinary}\""
                                           OBJECT_DEPENDS "${PrecompiledBinary}")  
             LIST(APPEND ${src_file} ${PrecompiledSource})
    endforeach( src_file ${Sources} )
    # Add precompiled header to SourcesVar

  ENDIF(MSVC)
ENDMACRO(ADD_MSVC_PRECOMPILED_HEADER)