/**
* @file Tab.qml
* @brief GUI component for a tab of the HyTrig GUI
* @authors Moritz Maas
*/

import QtQuick
import QtQuick.Controls.Material

Rectangle {

    required property string tab_name

    property list<Item> content: []

    readonly property list<Item> header: [
        
        Row {

            id: title_row
            width: parent.width
            height: tab_title.implicitHeight
            topPadding: 10
            bottomPadding: 10
            leftPadding: 10

            TabTitle {
                
                id: tab_title
                width: parent.width
                height: parent.height
                text: qsTr(tab_name)

            }

        }

    ]

    color: Material.background
    border.width: 1
    border.color: Material.accentColor

    Column {

        anchors.fill: parent
        anchors.margins: 10
        spacing: 20

        children: [
            ...header,
            ...content
        ]

    }

}
