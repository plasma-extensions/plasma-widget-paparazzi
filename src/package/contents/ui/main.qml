import QtQuick 2.0
import QtQuick.Layouts 1.0

import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0

import org.kde.private.spectacle 1.0

// import "data.js" as Data

Item {
    id: root

    property string displayName: i18n("Take an screenshot!")

    Layout.minimumHeight: units.gridUnit * 12
    Layout.minimumWidth: units.gridUnit * 12
    Layout.preferredHeight: units.gridUnit * 20
    Layout.preferredWidth: units.gridUnit * 20

    Plasmoid.switchWidth: units.gridUnit * 12
    Plasmoid.switchHeight: units.gridUnit * 12
    Plasmoid.toolTipMainText: displayName
    Plasmoid.toolTipSubText: ""

    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation

    Plasmoid.compactRepresentation: PlasmaCore.IconItem {
        property int iconSize: Math.min(parent.width, parent.height)

        width: iconSize
        height: iconSize
        source: plasmoid.icon

        active: mouseArea.containsMouse
        colorGroup: PlasmaCore.ColorScope.colorGroup


        MouseArea {
            id: mouseArea

            property bool wasExpanded: false

            anchors.fill: parent
            hoverEnabled: true
            acceptedButtons: Qt.LeftButton
            onPressed: {
                    wasExpanded = plasmoid.expanded;
            }

            onClicked: {
                    plasmoid.expanded = !wasExpanded;
            }

        }

    }

    Plasmoid.fullRepresentation:  actionsDialog



    function clickHandler() {
    }

    DbusAdaptor {
        id: spectacleDbusAdaptor
    }

    Component {
        id: actionsDialog
        ColumnLayout {
            spacing : 20.0
            Label {
                text: "Take an screenshot!"
            }

            RowLayout {
                spacing : 10.0

                id: actionsBox
                ColumnLayout {
                    Layout.alignment: Qt.AlignHCenter
                    Label {
                        text: "Full screen"
                        Layout.alignment: Qt.AlignHCenter

                    }
                    Button {
                        iconSource: "view-fullscreen"
                        Layout.alignment: Qt.AlignHCenter
                        tooltip : "Full screen capture."

                        onClicked: spectacleDbusAdaptor.captureScreen(0)
                    }
                }
                ColumnLayout {

                    Label {
                        text: "Window"
                        Layout.alignment: Qt.AlignHCenter
                    }
                    Button {
                        iconSource: "window"
                        Layout.alignment: Qt.AlignHCenter
                        tooltip : "Only the active window."

                        onClicked: spectacleDbusAdaptor.captureWindow(0)
                    }
                }
                ColumnLayout {

                    Label {
                        text: "Custom"
                        Layout.alignment: Qt.AlignHCenter
                    }
                    Button {
                        iconSource: "select-rectangular"
                        Layout.alignment: Qt.AlignHCenter
                        tooltip : "From a rectangular area."

                        onClicked: spectacleDbusAdaptor.captureArea(0)
                    }
                }
            }
        }
    }
}

