/**
* @file Location.qml
* @brief GUI component for a location of the HyTrig GUI
* @authors 
*/

import org.julialang
import QtQuick
import QtQuick.Controls.Material

import "../../util"

Element {

    required property var flow

    id: location_frame

    element_name: "Location"

    remove: function() {
        var name = model.name;
        hgt_models.locations.removeRow(index);
        locationRemoved(name);
    }

    elementContent: [

        Row {
            
            parent: location_frame.column
            width: parent.width
            height: location_name_field.height
            spacing: 10

            Label {
                id: location_name_label
                width: location_invariant_label.width
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                text: qsTr("Name:")
            }

            RegexField {
                id: location_name_field
                width: parent.width - location_name_label.width - location_initial_button.width - 2 * parent.spacing

                text: qsTr(model.name)
                default_text: qsTr("Enter location name")
                error_text: qsTr("Invalid location name")
                condition_error_text: qsTr("Name already in use")

                regex: /^[A-Za-z]\w*$/

                action: function(x) {
                    model.name = x;
                    locationRenamed(index, x);
                }
                condition: function(x) {
                    return x == model.name || Julia.hgt_name_available(x);
                }
                error_value: model.name
            }

            RadioButton {
                id: location_initial_button
                height: parent.height
                checked: model.initial
                text: qsTr("Initial")

                ButtonGroup.group: hgt_initial_location_group

                onCheckedChanged: {
                    if (model.initial != checked) {
                        model.initial = checked;
                    }
                }
            }

        },

        Row {

            parent: location_frame.column
            width: parent.width
            height: location_invariant_field.height
            spacing: 10

            Label {
                id: location_invariant_label
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                text: qsTr("Invariant:")
            }

            RegexField {
                id: location_invariant_field
                width: parent.width - location_invariant_label.width - parent.spacing

                text: qsTr(model.invariant)
                default_text: qsTr("Enter invariant")
                error_text: qsTr("Invalid invariant")
                condition_error_text: qsTr("Invalid invariant")

                regex: /^.*$/

                action: function(x) {
                    model.invariant = x;
                }
                condition: function(x) {
                    return Julia.hgt_is_formula(x, "constraint");
                }
                error_value: text

                Connections {
                    target: hgt_game
                    function onVariableRenamed(index, name) {
                        location_invariant_field.textChanged();
                        location_invariant_field.editingFinished();
                    }
                    function onVariableRemoved(index) {
                        location_invariant_field.textChanged();
                        location_invariant_field.editingFinished();
                    }
                }
            }

        },

        AssignmentList {

            parent: location_frame.column
            width: parent.width

            assignments: flow
            title: "Flow"
            kind: "flow"
            empty_text: "No flow, all variables are constant in this location."

        }

    ]

}
