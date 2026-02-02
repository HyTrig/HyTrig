/**
* @file Edge.qml
* @brief GUI component for an edge of the HyTrig GUI
* @authors Moritz Maas
*/

import org.julialang
import QtQuick
import QtQuick.Controls.Material

import ".."

ElementFrame {

    required property var jump

    id: edge_frame

    element_name: "Edge"

    remove: function() {
        hgt_models.edges.removeRow(index);
    }

    elementContent: [

        Row {
            
            parent: edge_frame.column
            width: parent.width
            height: edge_source_selector.height
            spacing: 10

            Label {
                id: edge_source_label
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                text: qsTr("Source:")
            }

            Selector {
                id: edge_source_selector
                width: (parent.width - edge_source_label.width - edge_target_label.width - 3 * parent.spacing) / 2

                model: hgt_models.locations
                textRole: "name"
                valueRole: "name"

                currentIndex: find(edge_frame.model.source)

                action: function(x) {
                    edge_frame.model.source = x;
                }
            }

            Label {
                id: edge_target_label
                width: edge_action_label.width
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                text: qsTr("Target:")
            }

            Selector {
                id: edge_target_selector
                width: (parent.width - edge_source_label.width - edge_target_label.width - 3 * parent.spacing) / 2

                model: hgt_models.locations
                textRole: "name"
                valueRole: "name"

                currentIndex: find(edge_frame.model.target)

                action: function(x) {
                    edge_frame.model.target = x;
                }
            }

        },

        Row {

            parent: edge_frame.column
            width: parent.width
            height: edge_guard_field.height
            spacing: 10

            Label {
                id: edge_guard_label
                width: edge_source_label.width
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                text: qsTr("Guard:")
            }

            RegexField {
                id: edge_guard_field
                width: parent.width - edge_guard_label.width - parent.spacing

                text: qsTr(model.guard)
                default_text: qsTr("Enter guard")
                error_text: qsTr("Invalid guard")
                condition_error_text: qsTr("Invalid guard")

                regex: /^.*$/

                action: function(x) {
                    model.guard = x;
                }
                condition: function(x) {
                    return x == model.guard || Julia.is_formula(x, "constraint");
                }
            }

        },

        Row {

            parent: edge_frame.column
            width: parent.width
            height: edge_agent_selector.height
            spacing: 10

            Label {
                id: edge_agent_label
                width: edge_source_label.width
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                text: qsTr("Agent:")
            }

            Selector {
                id: edge_agent_selector
                width: (parent.width - edge_agent_label.width - edge_action_label.width - 3 * parent.spacing) / 2

                model: hgt_models.agents
                textRole: "name"
                valueRole: "name"

                currentIndex: find(edge_frame.model.agent)

                action: function(x) {
                    edge_frame.model.agent = x;
                }
            }

            Label {
                id: edge_action_label
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                text: qsTr("Action:")
            }

            Selector {
                id: edge_action_selector
                width: (parent.width - edge_agent_label.width - edge_action_label.width - 3 * parent.spacing) / 2

                model: hgt_models.actions
                textRole: "name"
                valueRole: "name"

                currentIndex: find(edge_frame.model.action)

                action: function(x) {
                    edge_frame.model.action = x;
                }
            }

        },

        Row {

            parent: edge_frame.column
            width: parent.width
            height: edge_guard_field.height

            Title {
                
                id: flow_title
                width: parent.width
                height: parent.height
                text: qsTr("Jump")
                font.pointSize: 20

            }

        },

        Row {

            parent: edge_frame.column
            width: parent.width
            height: edge_jump_list.height

            ListView {

                id: edge_jump_list
                width: parent.width
                height: contentHeight
                clip: true
                interactive: false

                model: jump
                delegate: Row {

                    width: edge_jump_list.width
                    height: variable_field.height + variable_field.topInset
                    spacing: 10

                    Label {
                        id: variable_label
                        width: edge_guard_label.width
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
                        default_text: qsTr("Enter jump expression")
                        error_text: qsTr("Invalid jump expression")
                        condition_error_text: qsTr("Invalid jump expression")

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
