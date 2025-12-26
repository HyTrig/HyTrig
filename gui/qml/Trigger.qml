/**
* @file Trigger.qml
* @brief GUI component for a trigger of the HyTrig GUI
* @authors Moritz Maas
*/

import org.julialang
import QtQuick
import QtQuick.Controls.Material

ElementFrame {

    id: trigger_frame

    element_name: "Trigger"

    remove: function() {
        trigger_model.removeRow(index);
    }

    content: [

        Row {

            parent: trigger_frame.column
            width: parent.width
            height: trigger_agent_box.height
            spacing: 5

            Label {
                id: trigger_agent_label
                height: parent.height
                width: trigger_label.width
                verticalAlignment: Text.AlignVCenter
                text: qsTr("Agent: ")
            }

            ComboBox {
                id: trigger_agent_box
                width: parent.width - trigger_agent_label.width - parent.spacing

                model: agent_model
                textRole: "name"
                valueRole: "name"

                currentIndex: -1

                onActivated: {
                    trigger_frame.model.agent = currentValue;
                }
            }

        },

        Row {

            parent: trigger_frame.column
            width: parent.width
            height: trigger_field.height
            spacing: 5

            Label {
                id: trigger_label
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                text: qsTr("Trigger: ")
            }

            RegexField {
                id: trigger_field
                width: parent.width - trigger_label.width - parent.spacing

                text: model.trigger
                default_text: "Enter trigger"
                error_text: "Invalid trigger"
                condition_error_text: "Invalid trigger"

                regex: /^.*$/

                action: function(x) {
                    model.trigger = x;
                }
                condition: function(x) {
                    return x == model.trigger || Julia.is_formula(x, "constraint");
                }
            }

        }

    ]

}
