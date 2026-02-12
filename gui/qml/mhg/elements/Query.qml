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
        mhg_models.queries.removeRow(index);
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
                width: verified ? parent.width - query_formula_label.width - query_verified_checkbox.width - 2 * parent.spacing : parent.width - query_formula_label.width - parent.spacing

                text: qsTr(model.formula)
                default_text: qsTr("Enter strategy")
                error_text: qsTr("Invalid strategy")
                condition_error_text: qsTr("Invalid strategy")

                regex: /^.*$/

                action: function(x) {
                    model.formula = x;
                }
                condition: function(x) {
                    return x == model.formula || Julia.mhg_is_formula(x, "strategy");
                }
                error_value: model.formula
            }

            CheckBox {
                id: query_verified_checkbox
                height: parent.height
                visible: verified
                checked: model.verified
                enabled: false
            }

        }

    ]

}
