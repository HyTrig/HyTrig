/**
* @file Variable.qml
* @brief GUI component for a variable of the HyTrig GUI
* @authors Moritz Maas
*/

import org.julialang
import QtQuick
import QtQuick.Controls.Material

ElementFrame {

    id: variable_frame

    element_name: "Variable"

    remove: function() {
        variableRemoved(index);
        variable_model.removeRow(index);
    }

    elementContent: [

        Row {

            parent: variable_frame.column
            width: parent.width
            height: name_field.height
            spacing: 5

            Label {
                id: name_label
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                text: qsTr("Name: ")
            }

            RegexField {
                id: name_field
                width: parent.width - name_label.width - parent.spacing

                text: model.name
                default_text: "Enter variable name"
                error_text: "Invalid variable name"
                condition_error_text: "Name already in use"

                regex: /^[A-Za-z]\w*$/

                action: function(x) {
                    variableRenamed(index, x);
                    location_tab.model = [];
                    location_tab.model = location_model;
                    edge_tab.model = [];
                    edge_tab.model = edge_model;
                }
                condition: function(x) {
                    return x == model.name || Julia.name_available(x);
                }
            }

        },

        Row {

            parent: variable_frame.column
            width: parent.width
            height: value_field.height
            spacing: 5

            Label {
                id: value_label
                width: name_label.width
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                text: qsTr("Value: ")
            }

            RegexField {
                id: value_field
                width: parent.width - value_label.width - parent.spacing
                
                text: model.value
                default_text: "Enter decimal"
                error_text: "Invalid decimal"
                condition_error_text: ""

                regex: /(^-?(([1-9]\d*(\.\d+)?$)|(0\.\d*[1-9])$))|(^0$)/

                action: function(x) {
                    model.value = x;
                }
                condition: function(x) {
                    return true;
                }
            }

        }

    ]

}
