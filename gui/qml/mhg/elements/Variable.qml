/**
* @file Variable.qml
* @brief GUI component for a variable of the HyTrig GUI
* @authors Moritz Maas
*/

import org.julialang
import QtQuick
import QtQuick.Controls.Material

import "../../util"

Element {

    id: variable_frame

    element_name: "Variable"

    remove: function() {
        var i = index;
        mhg_models.variables.removeRow(index);
        variableRemoved(i);
    }

    elementContent: [

        Row {

            parent: variable_frame.column
            width: parent.width
            height: name_field.height
            spacing: 10

            Label {
                id: name_label
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                text: qsTr("Name:")
            }

            RegexField {
                id: name_field
                width: parent.width - name_label.width - parent.spacing

                text: qsTr(model.name)
                default_text: qsTr("Enter variable name")
                error_text: qsTr("Invalid variable name")
                condition_error_text: qsTr("Name already in use")

                regex: /^[A-Za-z]\w*$/

                action: function(x) {
                    model.name = x;
                    variableRenamed(index, x);
                }
                condition: function(x) {
                    return x == model.name || Julia.mhg_name_available(x);
                }
                error_value: model.name
            }

        },

        Interval {
            parent: variable_frame.column
            width: parent.width
            interval_model: variable_frame.model
            monotonic: false
        }

    ]

}
