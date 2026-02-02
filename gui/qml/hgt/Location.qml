/**
* @file Location.qml
* @brief GUI component for a location of the HyTrig GUI
* @authors Moritz Maas
*/

import org.julialang
import QtQuick
import QtQuick.Controls.Material

import ".."

ElementFrame {

    required property var flow

    id: location_frame

    element_name: "Location"

    remove: function() {
        locationRemoved(model.name);
        hgt_models.locations.removeRow(index);
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
                }
                condition: function(x) {
                    return x == model.name || Julia.hgt_name_available(x);
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
                    return x == model.invariant || Julia.is_formula(x, "constraint");
                }
            }

        },

        Row {

            parent: location_frame.column
            width: parent.width
            height: location_invariant_field.height

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
                    spacing: 10

                    Label {
                        id: variable_label
                        width: location_invariant_label.width
                        height: parent.height
                        verticalAlignment: Text.AlignVCenter
                        text: qsTr(model.variable)
                        elide: Text.ElideRight
                    }

                    RegexField {
                        id: variable_field
                        width: parent.width - variable_label.width - parent.spacing
                        topInset: 10

                        text: qsTr(model.expression)
                        default_text: qsTr("Enter flow expression")
                        error_text: qsTr("Invalid flow expression")
                        condition_error_text: qsTr("Invalid flow expression")

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
