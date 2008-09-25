SET(CMAKE_LINK_LIBRARY_SUFFIX "")  
SET(CMAKE_STATIC_LIBRARY_PREFIX "lib")
SET(CMAKE_STATIC_LIBRARY_SUFFIX ".a")
SET(CMAKE_SHARED_LIBRARY_PREFIX "lib")          # lib
SET(CMAKE_SHARED_LIBRARY_SUFFIX ".dll")          # .so
SET(CMAKE_SHARED_MODULE_PREFIX "lib")          # lib
SET(CMAKE_SHARED_MODULE_SUFFIX ".dll")          # .so
SET(CMAKE_IMPORT_LIBRARY_PREFIX "lib")
SET(CMAKE_IMPORT_LIBRARY_SUFFIX ".dll.a")
SET(CMAKE_EXECUTABLE_SUFFIX ".exe")          # .exe
SET(CMAKE_DL_LIBS "")
SET(CMAKE_SHARED_LIBRARY_C_FLAGS "")            # -pic 
SET(CMAKE_SHARED_LIBRARY_CXX_FLAGS "")            # -pic 
SET(CMAKE_SHARED_LIBRARY_CREATE_C_FLAGS "-shared")       # -shared
SET(CMAKE_SHARED_LIBRARY_LINK_C_FLAGS "")         # +s, flag for exe link to use shared lib
SET(CMAKE_SHARED_LIBRARY_RUNTIME_C_FLAG "")       # -rpath
SET(CMAKE_SHARED_LIBRARY_RUNTIME_C_FLAG_SEP "")   # : or empty

SET(CMAKE_SHARED_MODULE_C_FLAGS "${CMAKE_SHARED_LIBRARY_C_FLAGS}")               # -pic 
SET(CMAKE_SHARED_MODULE_CXX_FLAGS 
  "${CMAKE_SHARED_LIBRARY_CXX_FLAGS}")           # -pic 
SET(CMAKE_SHARED_MODULE_CREATE_C_FLAGS 
  "${CMAKE_SHARED_LIBRARY_CREATE_C_FLAGS}") # -shared
SET(CMAKE_LIBRARY_PATH_FLAG "-L")
SET(CMAKE_LINK_LIBRARY_FLAG "-l")
SET(CMAKE_EXTRA_LINK_EXTENSIONS ".lib") # MinGW can also link to a MS .lib
SET(CMAKE_CREATE_WIN32_EXE  "-mwindows")

IF(MINGW)
  SET(CMAKE_FIND_LIBRARY_PREFIXES "lib" "")
  SET(CMAKE_FIND_LIBRARY_SUFFIXES ".dll" ".dll.a" ".a" ".lib")
ENDIF(MINGW)

SET(CMAKE_GNULD_IMAGE_VERSION
  "-Wl,--major-image-version,<TARGET_VERSION_MAJOR>,--minor-image-version,<TARGET_VERSION_MINOR>")

SET(CMAKE_C_CREATE_SHARED_MODULE
  "<CMAKE_C_COMPILER> <CMAKE_SHARED_MODULE_C_FLAGS> <LINK_FLAGS> <CMAKE_SHARED_MODULE_CREATE_C_FLAGS> -o <TARGET> ${CMAKE_GNULD_IMAGE_VERSION} <OBJECTS> <LINK_LIBRARIES>")
SET(CMAKE_CXX_CREATE_SHARED_MODULE
  "<CMAKE_CXX_COMPILER> <CMAKE_SHARED_MODULE_CXX_FLAGS> <LINK_FLAGS> <CMAKE_SHARED_MODULE_CREATE_CXX_FLAGS> -o <TARGET> ${CMAKE_GNULD_IMAGE_VERSION} <OBJECTS> <LINK_LIBRARIES>")

SET(CMAKE_C_CREATE_SHARED_LIBRARY
  "<CMAKE_C_COMPILER> <CMAKE_SHARED_LIBRARY_C_FLAGS> <LINK_FLAGS> <CMAKE_SHARED_LIBRARY_CREATE_C_FLAGS> -o <TARGET> -Wl,--out-implib,<TARGET_IMPLIB> ${CMAKE_GNULD_IMAGE_VERSION} <OBJECTS> <LINK_LIBRARIES>")
SET(CMAKE_CXX_CREATE_SHARED_LIBRARY
  "<CMAKE_CXX_COMPILER> <CMAKE_SHARED_LIBRARY_CXX_FLAGS> <LINK_FLAGS> <CMAKE_SHARED_LIBRARY_CREATE_CXX_FLAGS> -o <TARGET> -Wl,--out-implib,<TARGET_IMPLIB> ${CMAKE_GNULD_IMAGE_VERSION} <OBJECTS> <LINK_LIBRARIES>")

SET(CMAKE_C_LINK_EXECUTABLE
  "<CMAKE_C_COMPILER> <FLAGS> <CMAKE_C_LINK_FLAGS> <LINK_FLAGS> <OBJECTS>  -o <TARGET> -Wl,--out-implib,<TARGET_IMPLIB> ${CMAKE_GNULD_IMAGE_VERSION} <LINK_LIBRARIES>")
SET(CMAKE_CXX_LINK_EXECUTABLE
  "<CMAKE_CXX_COMPILER>  <FLAGS> <CMAKE_CXX_LINK_FLAGS> <LINK_FLAGS> <OBJECTS>  -o <TARGET> -Wl,--out-implib,<TARGET_IMPLIB> ${CMAKE_GNULD_IMAGE_VERSION} <LINK_LIBRARIES>")

# Initialize C link type selection flags.  These flags are used when
# building a shared library, shared module, or executable that links
# to other libraries to select whether to use the static or shared
# versions of the libraries.
IF(MSYS OR MINGW)
  FOREACH(type SHARED_LIBRARY SHARED_MODULE EXE)
    SET(CMAKE_${type}_LINK_STATIC_C_FLAGS "-Wl,-Bstatic")
    SET(CMAKE_${type}_LINK_DYNAMIC_C_FLAGS "-Wl,-Bdynamic")
  ENDFOREACH(type)
ENDIF(MSYS OR MINGW)

# Create archiving rules to support large object file lists for static
# libraries.
IF(MSYS OR MINGW)
  SET(CMAKE_C_ARCHIVE_CREATE "<CMAKE_AR> cr <TARGET> <LINK_FLAGS> <OBJECTS>")
  SET(CMAKE_C_ARCHIVE_APPEND "<CMAKE_AR> r  <TARGET> <LINK_FLAGS> <OBJECTS>")
  SET(CMAKE_C_ARCHIVE_FINISH "<CMAKE_RANLIB> <TARGET>")
  SET(CMAKE_CXX_ARCHIVE_CREATE ${CMAKE_C_ARCHIVE_CREATE})
  SET(CMAKE_CXX_ARCHIVE_APPEND ${CMAKE_C_ARCHIVE_APPEND})
  SET(CMAKE_CXX_ARCHIVE_FINISH ${CMAKE_C_ARCHIVE_FINISH})
ENDIF(MSYS OR MINGW)
