/**
* @file Trigger.qml
* @brief GUI component for a trigger of the HyTrig GUI
* @authors Moritz Maas
*/

import org.julialang
import QtQuick
import QtQuick.Controls.Material

Item {

    height: trigger_column.implicitHeight + trigger_column.anchors.margins * 2 + trigger_background.anchors.margins * 2
    
    Rectangle {

        id: trigger_background
        anchors.fill: parent
        anchors.margins: 5

        color: Material.theme == Material.Dark ? Material.color(Material.BlueGrey, Material.Shade900) : Material.color(Material.BlueGrey, Material.Shade50)
        border.color: Material.accent
        border.width: 2
        radius: 5

        Column {

            id: trigger_column
            anchors.fill: parent
            anchors.margins: 15

            spacing: 10

            Row {

                width: parent.width
                spacing: 5

                Title {
                    width: parent.width - trigger_remove_button.width - parent.spacing
                    height: parent.height
                    text: qsTr("Trigger")
                    horizontalAlignment: Text.AlignHCenter
                }

                Button {
                    id: trigger_remove_button
                    text: qsTr("Remove")
                    Material.background: Material.theme == Material.Dark ? Material.color(Material.Red, Material.Shade900) : Material.color(Material.Red, Material.Shade400)
                    onClicked: {
                        trigger_model.removeRow(index);
                    }
                }

            }

            Row {

                width: parent.width
                height: agent_name_field.height
                spacing: 5

                Label {
                    id: agent_name_label
                    height: parent.height
                    verticalAlignment: Text.AlignVCenter
                    text: qsTr("Name: ")
                }

                RegexField {
                    id: agent_name_field
                    width: parent.width - agent_name_label.width - parent.spacing

                    text: model.name
                    default_text: "Enter agent name"
                    error_text: "Invalid agent name"
                    condition_error_text: "Name already in use"

                    regex: /^[A-Za-z]\w*$/

                    action: function(x) {
                        model.name = x;
                    }
                    condition: function(x) {
                        return x == model.name || Julia.name_available(x);
                    }
                }

            }

        }

    }

}
