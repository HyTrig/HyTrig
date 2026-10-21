/**
* @file Trigger.qml
* @brief GUI component for a trigger of the HyTrig GUI
* @authors 
*/

import org.julialang
import QtQuick
import QtQuick.Controls.Material

import "../../util"

Element {

    id: trigger_frame

    element_name: "Trigger"

    remove: function() {
        hgt_models.triggers.removeRow(index);
    }

    elementContent: [

        Row {

            parent: trigger_frame.column
            width: parent.width
            height: trigger_agent_selector.height
            spacing: 10

            Label {
                id: trigger_agent_label
                height: parent.height
                width: trigger_label.width
                verticalAlignment: Text.AlignVCenter
                text: qsTr("Agent:")
            }

            Selector {
                id: trigger_agent_selector
                width: parent.width - trigger_agent_label.width - parent.spacing

                model: hgt_models.agents
                textRole: "name"
                valueRole: "name"

                currentIndex: find(trigger_frame.model.agent)

                action: function(x) {
                    trigger_frame.model.agent = x;
                }
            }

        },

        Row {

            parent: trigger_frame.column
            width: parent.width
            height: trigger_field.height
            spacing: 10

            Label {
                id: trigger_label
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                text: qsTr("Trigger:")
            }

            RegexField {
                id: trigger_field
                width: parent.width - trigger_label.width - parent.spacing

                text: qsTr(model.trigger)
                default_text: qsTr("Enter trigger")
                error_text: qsTr("Invalid trigger")
                condition_error_text: qsTr("Invalid trigger")

                regex: /^.*$/

                action: function(x) {
                    model.trigger = x;
                }
                condition: function(x) {
                    return Julia.hgt_is_formula(x, "constraint");
                }
                error_value: text

                Connections {
                    target: hgt_game
                    function onVariableRenamed(index, name) {
                        trigger_field.textChanged();
                        trigger_field.editingFinished();
                    }
                    function onVariableRemoved(index) {
                        trigger_field.textChanged();
                        trigger_field.editingFinished();
                    }
                }
            }

        }

    ]

    Connections {
        target: hgt_game
        function onAgentRemoved(name) {
            if (model.agent == name) {
                model.agent = "";
            }
        }
    }

}
