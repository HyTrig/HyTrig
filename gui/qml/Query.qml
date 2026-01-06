/**
* @file Query.qml
* @brief GUI component for a query of the HyTrig GUI
* @authors Moritz Maas
*/

import org.julialang
import QtQuick
import QtQuick.Controls.Material

ElementFrame {

    id: query_frame

    element_name: "Query"

    remove: function() {
        models.queries.removeRow(index);
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
                width: parent.width - query_formula_label.width - parent.spacing

                text: qsTr(model.formula)
                default_text: qsTr("Enter strategy")
                error_text: qsTr("Invalid strategy")
                condition_error_text: qsTr("Invalid strategy")

                regex: /^.*$/

                action: function(x) {
                    model.formula = x;
                }
                condition: function(x) {
                    return x == model.formula || Julia.is_formula(x, "strategy");
                }
            }

        }

    ]

}
