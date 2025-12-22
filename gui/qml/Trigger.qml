/**
* @file Trigger.qml
* @brief GUI component for a trigger of the HyTrig GUI
* @authors Moritz Maas
*/

import org.julialang
import QtQuick
import QtQuick.Controls.Material

ElementFrame {

    id: trigger_frame

    element_name: "Trigger"

    remove: function() {
        trigger_model.removeRow(index);
    }

    content: [

        Row {

            parent: trigger_frame.column
            width: parent.width
            height: agent_name_field.height
            spacing: 5

            Label {
                id: trigger_agent_label
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                text: qsTr("Agent: ")
            }

            ComboBox {
                id: trigger_agent_box
                width: parent.width - trigger_agent_label.width - parent.spacing

                // TODO
                
            }

        }

    ]

}
