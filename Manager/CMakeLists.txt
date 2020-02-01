set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()

set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O2 -ftree-vectorize -pipe")
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -g -Og -Wall -Wextra -pipe")

# for CMake Version < 3.16 
if( NOT BIN_INSTALL_DIR) 
    set(BIN_INSTALL_DIR ${CMAKE_INSTALL_PREFIX}/bin)
endif()

set(DBUS_SOURCE
    Source/communication.cpp
    Source/communication.hpp
)

write_basic_package_version_file(
    ${CMAKE_CURRENT_BINARY_DIR}/OpenWallpaperVersion.cmake
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY  SameMajorVersion
)

qt5_add_dbus_interface(DBUS_SOURCE DBus/dbus_manager.xml dbus_manager_interface)

add_subdirectory(Simple_parser)
add_subdirectory(Resources)

set(MANAGER_SOURCE
    Source/debug.hpp
    Source/shared.hpp
    Source/main.cpp
    Source/package_manager.cpp
    Source/package_model.cpp
    Source/settings.cpp
    Source/package_manager.hpp
    Source/package_model.hpp
    Source/settings.hpp
    ${DBUS_SOURCE}
    
    Source/qrc/qml.qrc
)

add_executable(${PROJECT_NAME} ${MANAGER_SOURCE})

target_link_libraries(${PROJECT_NAME} PRIVATE
    Qt5::Core
    Qt5::DBus
    Qt5::Qml
    Qt5::Quick
    Qt5::QuickControls2
    Qt5::Multimedia
    OpenW::Parser
) 

target_include_directories(${PROJECT_NAME} PRIVATE
    ${CMAKE_CURRENT_BINARY_DIR}
 )
 
set_target_properties(${PROJECT_NAME} PROPERTIES
    CXX_STANDARD 17
    CXX_STANDARD_REQUIRED YES
    CXX_EXTENSIONS NO
)

# don't forget about -D CMAKE_INSTALL_PREFIX=/usr
install(TARGETS ${PROJECT_NAME} DESTINATION ${BIN_INSTALL_DIR})

