/**
* @file Location.qml
* @brief GUI component for a location of the HyTrig GUI
* @authors Moritz Maas
*/

import org.julialang
import QtQuick
import QtQuick.Controls.Material

ElementFrame {

    id: location_frame

    element_name: "Location"

    remove: function() {
        location_model.removeRow(index);
    }

    content: [

        Row {
            
            parent: location_frame.column
            width: parent.width
            height: location_name_field.height
            spacing: 5

            Label {
                id: location_name_label
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                text: qsTr("Name: ")
            }

            RegexField {
                id: location_name_field
                width: parent.width - location_name_label.width - location_initial_button.width - 2 * parent.spacing

                text: model.name
                default_text: "Enter location name"
                error_text: "Invalid location name"
                condition_error_text: "Name already in use"

                regex: /^[A-Za-z]\w*$/

                action: function(x) {
                    model.name = x;
                }
                condition: function(x) {
                    return x == model.name || Julia.name_available(x);
                }
            }

            RadioButton {
                id: location_initial_button
                height: parent.height
                checked: model.initial
                text: qsTr("Initial")

                ButtonGroup.group: initial_location_group

                onCheckedChanged: {
                    if (model.initial != checked) {
                        model.initial = checked;
                    }
                }
            }

        }

    ]

}
