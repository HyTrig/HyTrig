/**
* @file ContentFrame.qml
* @brief GUI component for a content frame of the HyTrig GUI
* @authors 
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

        color: light_background_color
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
