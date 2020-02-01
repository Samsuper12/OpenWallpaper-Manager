set(METAINFO_DIR ${CMAKE_INSTALL_PREFIX}/share/metainfo)
set(XDG_APPS_INSTALL_DIR ${CMAKE_INSTALL_PREFIX}/share/applications)

configure_file(
    openwallpaper-manager.desktop
    ${CMAKE_CURRENT_BINARY_DIR}/openwallpaper-manager.desktop
)

install(FILES openwallpaper-manager.appdata.xml DESTINATION ${METAINFO_DIR})
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/openwallpaper-manager.desktop DESTINATION ${XDG_APPS_INSTALL_DIR})
