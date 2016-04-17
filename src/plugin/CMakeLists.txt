find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED DBus)

set(plasmoidplugin_SRCS
    plasmoidplugin.cpp
    spectacledbusadaptor.cpp

    qmldir
    )

qt5_add_dbus_interface(plasmoidplugin_SRCS org.kde.Spectacle.xml Spectacle)

add_library(plasmoidplugin SHARED ${plasmoidplugin_SRCS})

target_link_libraries(plasmoidplugin Qt5::Quick Qt5::DBus KF5::Plasma)

install(TARGETS plasmoidplugin DESTINATION ${QML_INSTALL_DIR}/org/kde/private/spectacle)

install(FILES qmldir DESTINATION ${QML_INSTALL_DIR}/org/kde/private/spectacle)
