/**
* @file TerminationConditions.qml
* @brief GUI component for the termination conditions of the HyTrig GUI
* @authors Moritz Maas
*/

import org.julialang
import QtQuick
import QtQuick.Controls.Material

import "../../util"

Rectangle {

    property alias max_steps: max_steps_field
    property alias time_bound: time_bound_field
    property alias state_formula: state_formula_field

    color: Material.background
    border.width: 2
    border.color: Material.accent

    Column {

        anchors.fill: parent
        spacing: 20

        Row {

            id: title_row
            width: parent.width
            height: tab_title.implicitHeight + topPadding + bottomPadding
            topPadding: 10
            bottomPadding: 10
            leftPadding: 20

            TabTitle {
                
                id: tab_title
                width: parent.widthFTO
                height: parent.height
                text: qsTr("Termination Conditions")

            }

        }

        Item {

            width: parent.width
            height: parent.height - title_row.height - parent.spacing

            Column {

                anchors.fill: parent
                anchors.margins: 5
                spacing: 10

                ContentFrame {

                    width: parent.width
                    content: [
                        Row {

                            width: parent.width

                            Title {
                                id: max_steps_title
                                width: parent.width
                                height: max_steps_field.height
                                text: qsTr("Max Steps")
                            }

                        },
                        
                        Row {

                            width: parent.width

                            RegexField {
                                id: max_steps_field
                                width: parent.width

                                text: qsTr(mhg_models.max_steps)
                                default_text: qsTr("Enter maximum steps")
                                error_text: qsTr("Invalid number")
                                condition_error_text: qsTr("Invalid number")

                                regex: /^([1-9]\d*)|0$/

                                action: function(x) {
                                    mhg_models.max_steps = x;
                                }
                                condition: function(x) {
                                    return true;
                                }
                                error_value: mhg_models.max_steps
                            }

                        }
                    ]

                }

                ContentFrame {

                    width: parent.width
                    content: [
                        Row {

                            width: parent.width
                            spacing: 10

                            Title {
                                id: time_bound_title
                                width: parent.width
                                height: time_bound_field.height
                                text: qsTr("Time Bound")
                            }
                        
                        },
                        
                        Row {

                            width: parent.width

                            RegexField {
                                id: time_bound_field
                                width: parent.width

                                text: qsTr(mhg_models.time_bound)
                                default_text: qsTr("Enter time bound")
                                error_text: qsTr("Invalid decimal")
                                condition_error_text: qsTr("Invalid decimal")

                                regex: /^([1-9]\d*(\.\d+)?)|(0(\.\d+)?)$/

                                action: function(x) {
                                    mhg_models.time_bound = x;
                                }
                                condition: function(x) {
                                    return true;
                                }
                                error_value: mhg_models.time_bound
                            }

                        }
                    ]

                }

                ContentFrame {

                    width: parent.width
                    content: [
                        Row {

                            width: parent.width
                            spacing: 10

                            Title {
                                id: state_formula_title
                                width: parent.width
                                height: state_formula_field.height
                                text: qsTr("State Formula")
                            }

                        },
                        
                        Row {

                            width: parent.width

                            RegexField {
                                id: state_formula_field
                                width: parent.width

                                text: qsTr(mhg_models.state_formula)
                                default_text: qsTr("Enter state formula")
                                error_text: qsTr("Invalid state formula")
                                condition_error_text: qsTr("Invalid state formula")

                                regex: /^.*$/

                                action: function(x) {
                                    mhg_models.state_formula = x;
                                }
                                condition: function(x) {
                                    return x == mhg_models.state_formula || Julia.mhg_is_formula(x, "state");
                                }
                                error_value: mhg_models.state_formula
                            }

                        }
                    ]

                }

            }

        }

    }

}
