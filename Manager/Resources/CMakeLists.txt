set(ICON_INSTALL_DIR ${CMAKE_INSTALL_DATAROOTDIR}/icons)

install(DIRECTORY icons DESTINATION share/${PROJECT_NAME})

#install(FILES ico.svgz DESTINATION ${ICON_INSTALL_DIR}) #plasma icon...
#icon=/share/@PROJECT_NAME@/icons/ico.svgz in .desktop file
