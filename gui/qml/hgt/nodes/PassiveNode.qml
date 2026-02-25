/**
* @file PassiveNode.qml
* @brief GUI component passive game tree nodes.
* @authors Moritz Maas
*/

import QtQuick
import QtQuick.Controls.Material

Rectangle {

    height: node_property_list.height + 2 * node_property_list.spacing
    radius: 5
    color: light_background_color
    border.color: passive_node_color
    border.width: 2
    
    Column {

        id: node_property_list
        width: parent.width - 2 * spacing
        anchors.centerIn: parent
        spacing: 5

        Label {
            width: parent.width
            text: qsTr("Time: " + model.time)
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        Label {
            width: parent.width
            text: qsTr("Valuation: ")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        Label {
            width: parent.width
            text: qsTr(model.valuation)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

    }

}
