find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED DBus)

set(plasmoidplugin_SRCS
    plasmoidplugin.cpp
    spectacledbusadaptor.cpp

    qmldir
    )

# System install dbus spec
# set(SPECTACLE_DBUS_SPEC /usr/share/dbus-1/interfaces/org.kde.Spectacle.xml)

# Own dbus spec
set(SPECTACLE_DBUS_SPEC org.kde.Spectacle.xml)
    
qt5_add_dbus_interface(plasmoidplugin_SRCS ${SPECTACLE_DBUS_SPEC} Spectacle)

add_library(plasmoidplugin SHARED ${plasmoidplugin_SRCS})

target_link_libraries(plasmoidplugin Qt5::Quick Qt5::DBus KF5::Plasma)

install(TARGETS plasmoidplugin DESTINATION ${QML_INSTALL_DIR}/org/kde/private/spectacle)

install(FILES qmldir DESTINATION ${QML_INSTALL_DIR}/org/kde/private/spectacle)
