/**
* @file Act.qml
* @brief GUI component for an action of the HyTrig GUI
* @authors Moritz Maas
*/

import org.julialang
import QtQuick
import QtQuick.Controls.Material

ElementFrame {

    id: action_frame

    element_name: "Action"

    remove: function() {
        action_model.removeRow(index);
    }

    content: [

        Row {

            parent: action_frame.column
            width: parent.width
            height:action_name_field.height
            spacing: 5

            Label {
                id: action_name_label
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                text: qsTr("Name: ")
            }

            RegexField {
                id: action_name_field
                width: parent.width - action_name_label.width - parent.spacing

                text: model.name
                default_text: "Enter action name"
                error_text: "Invalid action name"
                condition_error_text: "Name already in use"

                regex: /^[A-Za-z]\w*$/

                action: function(x) {
                    model.name = x;
                }
                condition: function(x) {
                    return x == model.name || Julia.name_available(x);
                }
            }

        }

    ]

}
