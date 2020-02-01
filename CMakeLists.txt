cmake_minimum_required(VERSION 3.10)

project(openwallpaper-manager
    LANGUAGES CXX
    VERSION 0.1.0
)

find_package(Qt5 CONFIG REQUIRED 
    Core  
    DBus 
    Qml
    Quick
    QuickControls2
    Multimedia
)

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

add_subdirectory(Manager)
add_subdirectory(xdg)
