/**
* @file ContentFrame.qml
* @brief GUI component for a content frame of the HyTrig GUI
* @authors Moritz Maas
*/

import QtQuick
import QtQuick.Controls.Material

Item {

    height: column.implicitHeight + column.anchors.margins * 2 + back.anchors.margins * 2

    // Items to be displayed in a column inside the content frame
    required property list<Item> content
    
    Rectangle {

        id: back
        anchors.fill: parent
        anchors.margins: 5

        color: Material.theme == Material.Dark ? Material.color(Material.BlueGrey, Material.Shade900) : Material.color(Material.BlueGrey, Material.Shade50)
        border.color: Material.accent
        border.width: 2
        radius: 5

        Column {

            id: column
            anchors.fill: parent
            anchors.margins: 15
            spacing: 10

            children: content

        }

    }

}
