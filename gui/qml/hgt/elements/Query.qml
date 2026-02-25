/**
* @file Query.qml
* @brief GUI component for a query of the HyTrig GUI
* @authors Moritz Maas
*/

import org.julialang
import QtQuick
import QtQuick.Controls.Material

import "../../util"

Element {

    id: query_frame

    element_name: "Query"

    remove: function() {
        hgt_models.queries.removeRow(index);
    }

    elementContent: [

        Row {
            
            parent: query_frame.column
            width: parent.width
            height: query_formula_field.height
            spacing: 10

            Label {
                id: query_formula_label
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                text: qsTr("Formula:")
            }

            RegexField {
                id: query_formula_field
                width: parent.width - query_formula_label.width - query_verified_checkmark.width - 2 * parent.spacing

                text: qsTr(model.formula)
                default_text: qsTr("Enter strategy")
                error_text: qsTr("Invalid strategy")
                condition_error_text: qsTr("Invalid strategy")

                regex: /^.*$/

                action: function(x) {
                    model.formula = x;
                }
                condition: function(x) {
                    return Julia.hgt_is_formula(x, "strategy");
                }
                error_value: text

                Connections {
                    target: hgt_game
                    function onAgentRenamed(index, name) {
                        query_formula_field.textChanged();
                        query_formula_field.editingFinished();
                    }
                    function onAgentRemoved(name) {
                        query_formula_field.textChanged();
                        query_formula_field.editingFinished();
                    }
                    function onLocationRenamed(index, name) {
                        query_formula_field.textChanged();
                        query_formula_field.editingFinished();
                    }
                    function onLocationRemoved(name) {
                        query_formula_field.textChanged();
                        query_formula_field.editingFinished();
                    }
                    function onVariableRenamed(index, name) {
                        query_formula_field.textChanged();
                        query_formula_field.editingFinished();
                    }
                    function onVariableRemoved(index) {
                        query_formula_field.textChanged();
                        query_formula_field.editingFinished();
                    }
                }
            }

            CheckMark {
                id: query_verified_checkmark
                height: parent.height
                width: height
                enabled: verified
                checked: model.verified
            }

        }

    ]

}
