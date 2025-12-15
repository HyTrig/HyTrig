/**
* @file Variables.qml
* @brief GUI component for the variable tab of the HyTrig GUI
* @authors Moritz Maas
*/

import QtQuick
import QtQuick.Controls.Material

Column {

    anchors.fill: parent
    spacing: 20

    Row {

        id: title_row
        width: parent.width
        height: variables_title.implicitHeight + topPadding + bottomPadding
        topPadding: 10
        bottomPadding: 10
        leftPadding: 20

        TabTitle {
            
            id: variables_title
            width: parent.width - add_button.width - 2 * parent.leftPadding
            height: parent.height
            text: qsTr("Variables")

        }

        Button {

            id: add_button
            height: parent.height
            text: qsTr("Add Variable")
            Material.background: hovered ? Material.color(Material.Blue, Material.Shade500) : Material.color(Material.Blue, Material.Shade900)
            onClicked: {
                variable_model.appendRow({name: "", value: ""});
            }

        }

    }

    Item {

        width: parent.width
        height: parent.height - title_row.height - parent.spacing

        GridView {

            id: variables
            anchors.fill: parent
            anchors.margins: 5
            cellWidth: 350
            cellHeight: currentItem ? currentItem.height : 0
            currentIndex: 0

            model: variable_model

            delegate: Item {

                width: variables.cellWidth
                height: variable_column.implicitHeight + variable_column.anchors.margins * 2 + variable_background.anchors.margins * 2
                
                Rectangle {

                    id: variable_background
                    anchors.fill: parent
                    anchors.margins: 5

                    color: Material.primary
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
                                Material.background: hovered ? Material.color(Material.Red, Material.Shade600) : Material.color(Material.Red, Material.Shade900)
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

                            TextField {
                                id: name_field
                                width: parent.width - name_label.width - parent.spacing
                                text: model.name
                                placeholderText: "Enter name"

                                onEditingFinished: {
                                    model.name = text;
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

                            TextField {
                                id: value_field
                                width: parent.width - value_label.width - parent.spacing
                                text: model.value
                                placeholderText: "Enter value"
                                validator: RegularExpressionValidator {
                                    regularExpression: /s/
                                }

                                onEditingFinished: {
                                    model.value = text;
                                }
                            }

                        }

                    }

                }

            }

            remove: Transition {
                ParallelAnimation {
                    NumberAnimation { properties: "opacity,scale"; to: 0; duration: 200 }
                }
            }

            removeDisplaced: Transition {
                NumberAnimation { properties: "x,y"; duration: 300 }
            }

        }

    }

}
