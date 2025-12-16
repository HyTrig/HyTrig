/**
* @file Variable.qml
* @brief GUI component for a variable of the HyTrig GUI
* @authors Moritz Maas
*/

import org.julialang
import QtQuick
import QtQuick.Controls.Material

Item {

    height: variable_column.implicitHeight + variable_column.anchors.margins * 2 + variable_background.anchors.margins * 2
    
    Rectangle {

        id: variable_background
        anchors.fill: parent
        anchors.margins: 5

        color: Material.theme == Material.Dark ? Material.color(Material.BlueGrey, Material.Shade900) : Material.color(Material.BlueGrey, Material.Shade50)
        border.color: Material.accent
        border.width: 2
        radius: 5

        Column {

            id: variable_column
            anchors.fill: parent
            anchors.margins: 15

            spacing: 10

            Row {

                width: parent.width
                spacing: 5

                Title {
                    width: parent.width - remove_button.width - parent.spacing
                    height: parent.height
                    text: qsTr("Variable")
                    horizontalAlignment: Text.AlignHCenter
                }

                Button {
                    id: remove_button
                    text: qsTr("Remove")
                    Material.background: Material.theme == Material.Dark ? Material.color(Material.Red, Material.Shade900) : Material.color(Material.Red, Material.Shade400)
                    onClicked: {
                        variable_model.removeRow(index);
                    }
                }

            }

            Row {

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
                        model.name = x;
                    }
                    condition: function(x) {
                        return x == model.name || Julia.name_available(x);
                    }
                }

            }

            Row {

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

        }

    }

}
