/**
* @file ActionNode.qml
* @brief GUI component for an active game tree node.
* @authors Moritz Maas
*/

import QtQuick
import QtQuick.Controls.Material

Rectangle {

    required property var model
    required property int index

    id: active_node
    width: parent.width
    height: parent.height
    radius: 5
    color: (model.clickable
    ? (active_node_mouse_area.containsMouse ? Material.accent : active_node_color) 
    : light_background_color)
    border.color: (model.clickable ? Material.accent : end_node_color)
    border.width: 2

    readonly property list<Item> node_action: [
        Label {
            id: node_action_text
            width: active_node.width
            text: qsTr("Action: " + model.action)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        },
        Label {
            id: node_arrow_text
            width: active_node.width
            text: qsTr("↓")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    ]
    readonly property list<Item> node_info: [
        Label {
            id: node_location_text
            width: active_node.width
            text: qsTr("Location: " + model.location)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        },
        ScrollView {
            id: node_valuation_text
            width: active_node.width
            height: (model.action != ""
            ? active_node.height - 4 * node_property_list.spacing - node_action_text.height - node_arrow_text.height - node_location_text.height
            : active_node.height - node_property_list.spacing - node_location_text.height)
            ScrollBar.vertical.policy: ScrollBar.AlwaysOn

            Label {
                width: node_valuation_text.width
                text: qsTr(model.valuation)
                horizontalAlignment: Text.AlignHCenter
                clip: true
            }
        }
    ]

    Column {

        id: node_property_list
        width: parent.width
        height: parent.height
        spacing: 5

        children: (model.action != "" ? [
            ...node_action,
            ...node_info
        ] : [
            ...node_info
        ])

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
