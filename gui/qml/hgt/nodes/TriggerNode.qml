/**
* @file TriggerNode.qml
* @brief GUI component for a trigger node.
* @authors 
*/

import QtQuick
import QtQuick.Controls.Material
import QtQuick.Shapes

Item {

    required property string agent
    required property string trigger
    required property string valuation
    required property string time

    Shape {
        id: time_line_connector
        width: time_line_width
        height: parent.height
        anchors.left: parent.left

        ShapePath {
            strokeWidth: 4
            strokeColor: trigger_node_color
            startX: 0
            startY: time_line_connector.height / 2
            PathLine {
                x: time_line_connector.width
                y: time_line_connector.height / 2
            }
        }
    }

    Rectangle {
        width: Math.max(time_stamp.width + 4 * node_property_list.spacing, 2 * time_line_spacing)
        height: time_stamp.height + 2 * node_property_list.spacing
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        radius: 5
        color: light_background_color
        border.color: trigger_node_color
        border.width: 2

        Label {
            id: time_stamp
            anchors.centerIn: parent
            text: qsTr("" + time)
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }

    Rectangle {

        id: node
        width: node_width
        height: node_property_list.height + 2 * node_property_list.spacing
        anchors.left: time_line_connector.right
        anchors.verticalCenter: parent.verticalCenter
        radius: 5
        color: light_background_color
        border.color: trigger_node_color
        border.width: 2

        readonly property list<Item> node_info: [
            Label {
                id: node_agent_text
                width: node.width
                text: qsTr("Agent: " + agent)
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.Wrap
            },
            Label {
                id: node_trigger_text
                width: node.width
                text: qsTr("Trigger: " + trigger)
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.Wrap
            },
            ScrollView {
                id: node_valuation_text
                width: node.width
                height: node_height - 4 * node_property_list.spacing - node_agent_text.height - node_trigger_text.height
                ScrollBar.vertical.policy: ScrollBar.AlwaysOn

                Label {
                    width: node.width
                    text: qsTr(valuation)
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    clip: true
                }
            }
        ]
        readonly property list<Item> initial_node_info: [
            Label {
                width: node.width
                text: qsTr("Initial Configuration")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.Wrap
            }
        ]

        Column {

            id: node_property_list
            width: parent.width
            anchors.centerIn: parent
            spacing: 5

            children: (agent != "" ? [
                ...node.node_info
            ] : [
                ...node.initial_node_info
            ])

        }

    }

}

