/**
* @file Variables.qml
* @brief GUI component for the variable tab of the HyTrig GUI
* @authors Moritz Maas
*/

import QtQuick
import QtQuick.Controls.Material

GridView {

    id: variables
    anchors.fill: parent
    anchors.margins: 5
    cellWidth: 350
    cellHeight: 230

    model: variable_model

    delegate: Item {

        width: variables.cellWidth
        height: variables.cellHeight

        Rectangle {

            anchors.fill: parent
            anchors.margins: 5

            color: Material.primary
            border.color: Material.accent
            border.width: 2
            radius: 5

            Column {

                anchors.fill: parent
                anchors.margins: 10

                spacing: 10

                Row {

                    width: parent.width
                    spacing: 5

                    Title {
                        width: parent.width - remove_button.width - parent.spacing
                        height: parent.height
                        text: qsTr("Variable")
                    }

                    Button {
                        id: remove_button
                        text: qsTr("Remove")
                        onClicked: {
                            model.remove(index)
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

                    TextField {
                        id: name_field
                        width: parent.width - name_label.width - parent.spacing
                        text: model.name
                        placeholderText: "Enter name"
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

                    TextField {
                        id: value_field
                        width: parent.width - value_label.width - parent.spacing
                        text: model.value
                        placeholderText: "Enter value"
                    }

                }

            }

        }

    }

}
