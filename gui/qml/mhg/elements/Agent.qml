/**
* @file Agent.qml
* @brief GUI component for an agent of the HyTrig GUI
* @authors Moritz Maas
*/

import org.julialang
import QtQuick
import QtQuick.Controls.Material

import "../../util"

Element {

    id: agent_frame

    element_name: "Agent"
    
    remove: function() {
        var name = model.name;
        mhg_models.agents.removeRow(index);
        agentRemoved(name);
    }

    elementContent: [

        Row {
            
            parent: agent_frame.column
            width: parent.width
            height: agent_name_field.height
            spacing: 10

            Label {
                id: agent_name_label
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                text: qsTr("Name:")
            }

            RegexField {
                id: agent_name_field
                width: parent.width - agent_name_label.width - parent.spacing

                text: qsTr(model.name)
                default_text: qsTr("Enter agent name")
                error_text: qsTr("Invalid agent name")
                condition_error_text: qsTr("Name already in use")

                regex: /^[A-Za-z]\w*$/

                action: function(x) {
                    model.name = x;
                    agentRenamed(index, x);
                }
                condition: function(x) {
                    return x == model.name || Julia.mhg_name_available(x);
                }
                error_value: model.name
            }

        }

    ]

}
