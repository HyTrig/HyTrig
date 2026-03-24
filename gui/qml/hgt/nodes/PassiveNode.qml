/**
* @file PassiveNode.qml
* @brief GUI component passive game tree nodes.
* @authors Moritz Maas
*/

import QtQuick
import QtQuick.Controls.Material
import QtQuick.Shapes

Item {

    required property var model
    required property int index

    height: node.height

    Shape {
        id: time_line_connector
        width: time_line_width
        height: parent.height
        anchors.left: parent.left

        ShapePath {
            strokeWidth: 4
            strokeColor: model.is_end ? end_node_color : passive_node_color
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
        border.color: model.is_end ? end_node_color : passive_node_color
        border.width: 2

        Label {
            id: time_stamp
            anchors.centerIn: parent
            text: qsTr("" + model.time)
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }

    Rectangle {

        id: node
        width: node_width
        height: node_property_list.height + 2 * node_property_list.spacing
        anchors.left: time_line_connector.right
        radius: 5
        color: light_background_color
        border.color: model.is_end ? end_node_color : passive_node_color
        border.width: 2
        
        Column {

            id: node_property_list
            width: parent.width - 2 * spacing
            anchors.centerIn: parent
            spacing: 5

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

}
