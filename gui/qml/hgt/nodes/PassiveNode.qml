/**
* @file PassiveNode.qml
* @brief GUI component passive game tree nodes.
* @authors Moritz Maas
*/

import QtQuick
import QtQuick.Controls.Material

Rectangle {

    height: node_time_text.height + node_valuation_text.height + node_property_list.spacing
    radius: 4
    color: Material.color(Material.Blue)
    
    Column {

        id: node_property_list
        width: parent.width
        height: parent.height
        spacing: 5

        Label {
            id: node_time_text
            width: parent.width
            text: qsTr("Time = " + model.time)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Label {
            id: node_valuation_text
            width: parent.width
            text: qsTr(model.valuation)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
}
