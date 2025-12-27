/**
* @file Location.qml
* @brief GUI component for a location of the HyTrig GUI
* @authors Moritz Maas
*/

import org.julialang
import QtQuick
import QtQuick.Controls.Material

ElementFrame {

    required property var flow

    id: location_frame

    element_name: "Location"

    remove: function() {
        location_model.removeRow(index);
    }

    content: [

        Row {
            
            parent: location_frame.column
            width: parent.width
            height: location_name_field.height
            spacing: 5

            Label {
                id: location_name_label
                width: location_invariant_label.width
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                text: qsTr("Name: ")
            }

            RegexField {
                id: location_name_field
                width: parent.width - location_name_label.width - location_initial_button.width - 2 * parent.spacing

                text: model.name
                default_text: "Enter location name"
                error_text: "Invalid location name"
                condition_error_text: "Name already in use"

                regex: /^[A-Za-z]\w*$/

                action: function(x) {
                    model.name = x;
                }
                condition: function(x) {
                    return x == model.name || Julia.name_available(x);
                }
            }

            RadioButton {
                id: location_initial_button
                height: parent.height
                checked: model.initial
                text: qsTr("Initial")

                ButtonGroup.group: initial_location_group

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
            spacing: 5

            Label {
                id: location_invariant_label
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                text: qsTr("Invariant: ")
            }

            RegexField {
                id: location_invariant_field
                width: parent.width - location_invariant_label.width - parent.spacing

                text: model.invariant
                default_text: "Enter invariant"
                error_text: "Invalid invariant"
                condition_error_text: "Invalid invariant"

                regex: /^.*$/

                action: function(x) {
                    model.invariant = x;
                }
                condition: function(x) {
                    return x == model.invariant || Julia.is_formula(x, "constraint");
                }
            }

        },

        Row {

            parent: location_frame.column
            width: parent.width
            height: location_invariant_field.height
            spacing: 5

            Title {
                
                id: flow_title
                width: parent.width
                height: parent.height
                text: qsTr("Flow")
                font.pointSize: 20

            }

        },

        Row {

            parent: location_frame.column
            width: parent.width
            height: location_flow_list.height

            ListView {

                id: location_flow_list
                width: parent.width
                height: contentHeight
                clip: true
                interactive: false

                model: flow
                delegate: Row {

                    width: location_flow_list.width
                    height: variable_field.height + variable_field.topInset
                    spacing: 5

                    Label {
                        id: variable_label
                        width: location_invariant_label.width
                        height: parent.height
                        verticalAlignment: Text.AlignVCenter
                        text: model.variable
                    }

                    RegexField {
                        id: variable_field
                        width: parent.width - variable_label.width - parent.spacing
                        topInset: 10

                        text: model.expression
                        default_text: "Enter flow expression"
                        error_text: "Invalid flow expression"
                        condition_error_text: "Invalid flow expression"

                        regex: /^.*$/

                        action: function(x) {
                            model.expression = x;
                        }
                        condition: function(x) {
                            return x == model.expression || Julia.is_formula(x, "expression");
                        }
                    }

                }

            }

        }

    ]

}
