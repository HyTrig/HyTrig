/**
* @file Agents.qml
* @brief GUI component for the agent tab of the HyTrig GUI
* @authors Moritz Maas
*/

import QtQuick
import QtQuick.Controls.Material

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
        text: qsTr("Agent Tab - TODO")
        color: Material.accentColor
        font.pointSize: 24
    }

}
