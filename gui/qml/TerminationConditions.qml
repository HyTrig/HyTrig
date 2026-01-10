/**
* @file TerminationConditions.qml
* @brief GUI component for the termination conditions of the HyTrig GUI
* @authors Moritz Maas
*/

import org.julialang
import QtQuick
import QtQuick.Controls.Material

Rectangle {

    color: Material.background
    border.width: 1
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
                width: parent.width
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

                Row {

                    width: parent.width
                    spacing: 10

                    // TODO: reorder content to fit narrow window sizes

                    ContentFrame {

                        width: (parent.width - 2 * parent.spacing) / 3
                        content: [
                            Row {

                                width: parent.width
                                spacing: 10

                                Title {
                                    id: max_steps_title
                                    height: parent.height
                                    text: qsTr("Max Steps")
                                    horizontalAlignment: Text.AlignHCenter
                                }

                                RegexField {
                                    id: max_steps_field
                                    width: parent.width - parent.spacing - max_steps_title.width

                                    text: qsTr(config.max_steps)
                                    default_text: qsTr("Enter maximum steps")
                                    error_text: qsTr("Invalid number")
                                    condition_error_text: qsTr("Invalid number")

                                    regex: /^([1-9]\d*)|0$/

                                    action: function(x) {
                                        config.max_steps = x;
                                    }
                                    condition: function(x) {
                                        return true;
                                    }
                                }

                            }
                        ]

                    }

                    ContentFrame {

                        width: (parent.width - 2 * parent.spacing) / 3
                        content: [
                            Row {

                                width: parent.width
                                spacing: 10

                                Title {
                                    id: time_bound_title
                                    height: parent.height
                                    text: qsTr("Time Bound")
                                    horizontalAlignment: Text.AlignHCenter
                                }

                                RegexField {
                                    id: time_bound_field
                                    width: parent.width - parent.spacing - time_bound_title.width

                                    text: qsTr(config.time_bound)
                                    default_text: qsTr("Enter time bound")
                                    error_text: qsTr("Invalid decimal")
                                    condition_error_text: qsTr("Invalid decimal")

                                    regex: /^([1-9]\d*(\.\d+)?)|(0(\.\d+)?)$/

                                    action: function(x) {
                                        config.time_bound = x;
                                    }
                                    condition: function(x) {
                                        return true;
                                    }
                                }

                            }
                        ]

                    }

                    ContentFrame {

                        width: (parent.width - 2 * parent.spacing) / 3
                        content: [
                            Row {

                                width: parent.width
                                spacing: 10

                                Title {
                                    id: state_formula_title
                                    height: parent.height
                                    text: qsTr("State Formula")
                                    horizontalAlignment: Text.AlignHCenter
                                }

                                RegexField {
                                    id: state_formula_field
                                    width: parent.width - parent.spacing - state_formula_title.width

                                    text: qsTr(config.state_formula)
                                    default_text: qsTr("Enter state formula")
                                    error_text: qsTr("Invalid state formula")
                                    condition_error_text: qsTr("Invalid state formula")

                                    regex: /^.*$/

                                    action: function(x) {
                                        config.state_formula = x;
                                    }
                                    condition: function(x) {
                                        return x == config.state_formula || Julia.is_formula(x, "state");
                                    }
                                }

                            }
                        ]

                    }

                }


            }

        }

    }

}
