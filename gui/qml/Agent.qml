/**
* @file Agent.qml
* @brief GUI component for an agent of the HyTrig GUI
* @authors Moritz Maas
*/

import org.julialang
import QtQuick
import QtQuick.Controls.Material

ElementFrame {

    id: agent_frame

    element_name: "Agent"

    remove: function() {
        agent_model.removeRow(index);
    }

    content: [

        Row {
            
            parent: agent_frame.column
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

    ]

}
