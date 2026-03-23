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

    id: action_node
    height: node_property_list.height
    radius: 5
    color: (model.terminal ? light_background_color :
        action_node_mouse_area.containsMouse ? Material.accent : action_node_color)
    border.color: Material.accent
    border.width: 2

    readonly property list<Item> node_action: [
        Label {
            id: node_action_text
            width: action_node.width
            text: qsTr("Action: " + model.action)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        },
        Label {
            id: node_arrow_text
            width: action_node.width
            text: qsTr("↓")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    ]
    readonly property list<Item> node_info: [
        Label {
            id: node_location_text
            width: action_node.width
            text: qsTr("Location: " + model.location)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        },
        ScrollView {
            id: node_valuation_text
            width: action_node.width
            height: (model.action != ""
            ? action_node.height - 4 * node_property_list.spacing - node_action_text.height - node_arrow_text.height - node_location_text.height
            : action_node.height - node_property_list.spacing - node_location_text.height)
            ScrollBar.vertical.policy: ScrollBar.AlwaysOn

            Label {
                width: node_valuation_text.width
                text: qsTr(model.valuation)
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                clip: true
            }
        }
    ]

    Column {

        id: node_property_list
        width: parent.width
        spacing: 5

        children: (model.action != "" ? [
            ...node_action,
            ...node_info
        ] : [
            ...node_info
        ])

    }

    MouseArea {

        id: action_node_mouse_area

        anchors.fill: parent
        enabled: !model.terminal
        hoverEnabled: true

        onClicked: {
            branch_column.down(index);
        }

    }

}
