/**
* @file Act.qml
* @brief GUI component for an action of the HyTrig GUI
* @authors Moritz Maas
*/

import org.julialang
import QtQuick
import QtQuick.Controls.Material

import ".."

ElementFrame {

    id: action_frame

    element_name: "Action"

    remove: function() {
        actionRemoved(model.name);
        mhg_models.actions.removeRow(index);
    }

    elementContent: [

        Row {

            parent: action_frame.column
            width: parent.width
            height:action_name_field.height
            spacing: 10

            Label {
                id: action_name_label
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                text: qsTr("Name:")
            }

            RegexField {
                id: action_name_field
                width: parent.width - action_name_label.width - parent.spacing

                text: qsTr(model.name)
                default_text: qsTr("Enter action name")
                error_text: qsTr("Invalid action name")
                condition_error_text: qsTr("Name already in use")

                regex: /^[A-Za-z]\w*$/

                action: function(x) {
                    model.name = x;
                }
                condition: function(x) {
                    return x == model.name || Julia.mhg_name_available(x);
                }
            }

        }

    ]

}
