/**
* @file TriggerNode.qml
* @brief GUI component for a trigger node.
* @authors Moritz Maas
*/

import QtQuick
import QtQuick.Controls.Material

Rectangle {

    required property string agent
    required property string trigger
    required property string time

    height: node_property_list.height + 2 * node_property_list.spacing
    radius: 5
    color: light_background_color
    border.color: trigger_node_color
    border.width: 2

    Column {

        id: node_property_list
        width: parent.width
        anchors.centerIn: parent
        spacing: 5

        Label {
            id: node_agent_text
            width: parent.width
            text: qsTr("Agent: " + agent)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.Wrap
        }

        Label {
            id: node_trigger_text
            width: parent.width
            text: qsTr("Trigger: " + trigger)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.Wrap
        }

        Label {
            id: node_active_time_text
            width: parent.width
            text: qsTr("Time = " + time)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

}
