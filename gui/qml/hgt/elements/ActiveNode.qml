/**
* @file ActiveNode.qml
* @brief GUI component for an active game tree node.
* @authors Moritz Maas
*/

import QtQuick
import QtQuick.Controls.Material

Rectangle {

    required property var model
    required property int index

    width: parent.width
    height: parent.height
    radius: 4
    color: (model.clickable
    ? (active_node_mouse_area.containsMouse ? Material.color(Material.Orange, Material.Shade400) : Material.color(Material.Orange)) 
    : Material.color(Material.Orange, Material.Shade900))

    Column {

        id: node_property_list
        width: parent.width
        height: parent.height
        spacing: 5

        Label {
            id: node_action_text
            width: parent.width
            text: qsTr("Action: " + model.action)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Label {
            id: node_arrow_text
            width: parent.width
            text: qsTr("↓")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Label {
            id: node_location_text
            width: parent.width
            text: qsTr("Location: " + model.location)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        ScrollView {
            id: node_valuation_text
            width: parent.width
            height: parent.height - 4 * parent.spacing - node_action_text.height - node_arrow_text.height - node_location_text.height

            Label {
                width: node_valuation_text.width
                text: qsTr(model.valuation)
                horizontalAlignment: Text.AlignHCenter
                clip: true
            }
        }

    }

    MouseArea {

        id: active_node_mouse_area

        anchors.fill: parent
        hoverEnabled: true

        onClicked: {
            // Only allow navigation if the node is not terminal
            if(model.clickable) {
                branch_column.down(index);
            }
        }

    }

}
