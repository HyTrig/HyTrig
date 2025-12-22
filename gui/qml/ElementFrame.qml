/**
* @file ElementFrame.qml
* @brief GUI component for an agent of the HyTrig GUI
* @authors Moritz Maas
*/

import QtQuick
import QtQuick.Controls.Material

Item {

    required property var model
    required property int index

    required property string element_name
    required property list<Item> content

    required property var remove

    property alias column: column

    height: column.implicitHeight + column.anchors.margins * 2 + back.anchors.margins * 2
    
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

            children: [

                Row {

                    width: parent.width
                    spacing: 5

                    Title {
                        width: parent.width - remove_button.width - parent.spacing
                        height: parent.height
                        text: qsTr(element_name)
                        horizontalAlignment: Text.AlignHCenter
                    }

                    Button {
                        id: remove_button
                        text: qsTr("Remove")
                        Material.background: Material.theme == Material.Dark ? Material.color(Material.Red, Material.Shade900) : Material.color(Material.Red, Material.Shade400)
                        onClicked: {
                            remove();
                        }
                    }

                }

            ]

        }

    }

}
