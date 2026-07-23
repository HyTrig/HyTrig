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
        mhg_models.locations.removeRow(index);
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
                    return x == model.name || Julia.mhg_name_available(x);
                }
                error_value: model.name
            }

            RadioButton {
                id: location_initial_button
                height: parent.height
                checked: model.initial
                text: qsTr("Initial")

                ButtonGroup.group: mhg_initial_location_group

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
                    return Julia.mhg_is_formula(x, "constraint");
                }
                error_value: text

                Connections {
                    target: mhg_game
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
                    height: flow_interval.height + flow_interval.inset
                    spacing: 10

                    Label {
                        id: variable_label
                        width: location_invariant_label.width
                        height: parent.height
                        verticalAlignment: Text.AlignVCenter
                        text: qsTr(model.variable)
                        elide: Text.ElideRight
                    }

                    Interval {
                        id: flow_interval
                        width: parent.width - variable_label.width - parent.spacing
                        inset: 10
                        interval_model: model
                        monotonic: true
                    }

                }

            }

        }

    ]

    Connections {
        target: mhg_game
        function onVariableAdded() {
            model.flow.appendRow({variable: "", lower_open: false, upper_open: false, lower: 0.0, upper: 0.0});
        }
        function onVariableRemoved(index) {
            model.flow.removeRow(index);
        }
        function onVariableRenamed(index, name) {
            if (model.flow) {
                model.flow.setData(model.flow.index(index, 0), name, roles.name);
            }
        }
    }

}
