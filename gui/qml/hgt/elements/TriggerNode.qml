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

    radius: 4
    color: Material.color(Material.Green)

    Column {

        width: parent.width
        height: parent.height
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
