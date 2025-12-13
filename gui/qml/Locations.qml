/**
* @file Locations.qml
* @brief GUI component for the location tab of the HyTrig GUI
* @authors Moritz Maas
*/

import QtQuick.Controls.Material
import QtQuick

Item {

    width: parent.width
    height: parent.height

    Rectangle {
        anchors.fill: parent
        anchors.margins: 5
        color: Material.backgroundColor
        border.width: 1
        border.color: Material.accentColor
    }

    Text {
        anchors.centerIn: parent
        text: qsTr("Location Tab - TODO")
        color: Material.accentColor
        font.pointSize: 24
    }

}
