/**
* @file Agents.qml
* @brief GUI component for the agent tab of the HyTrig GUI
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
        height: agents_title.implicitHeight + topPadding + bottomPadding
        topPadding: 10
        bottomPadding: 10
        leftPadding: 20

        TabTitle {
            
            id: agents_title
            width: parent.width - add_button.width - 2 * parent.leftPadding
            height: parent.height
            text: qsTr("Agents")

        }

        Button {

            id: add_button
            height: parent.height
            text: qsTr("Add Agent")
            Material.background: hovered ? Material.color(Material.Blue, Material.Shade500) : Material.color(Material.Blue, Material.Shade900)
            onClicked: {
                agent_model.appendRow({name: ""});
            }

        }

    }

    Item {

        width: parent.width
        height: parent.height - title_row.height - parent.spacing

        GridView {

            id: agents
            anchors.fill: parent
            anchors.margins: 5
            anchors.rightMargin: grid_scrollBar.width + grid_scrollBar.anchors.margins
            clip: true
            cellWidth: 350
            cellHeight: currentItem ? currentItem.height : 0
            currentIndex: 0

            model: agent_model

            delegate: Item {

                width: agents.cellWidth
                height: agent_column.implicitHeight + agent_column.anchors.margins * 2 + agent_background.anchors.margins * 2
                
                Rectangle {

                    id: agent_background
                    anchors.fill: parent
                    anchors.margins: 5

                    color: Material.primary
                    border.color: Material.accent
                    border.width: 2
                    radius: 5

                    Column {

                        id: agent_column
                        anchors.fill: parent
                        anchors.margins: 15

                        spacing: 10

                        Row {

                            width: parent.width
                            spacing: 5

                            Title {
                                width: parent.width - remove_button.width - parent.spacing
                                height: parent.height
                                text: qsTr("Agent")
                                horizontalAlignment: Text.AlignHCenter
                            }

                            Button {
                                id: remove_button
                                text: qsTr("Remove")
                                Material.background: hovered ? Material.color(Material.Red, Material.Shade600) : Material.color(Material.Red, Material.Shade900)
                                onClicked: {
                                    agent_model.removeRow(index);
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
                                default_text: "Enter name"
                                error_text: "Invalid name"

                                regex: /^[A-Za-z]\w*$/

                                onFinished: function(x) {
                                    model.name = x;
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

            ScrollBar.vertical: grid_scrollBar

        }

        ScrollBar {
            id: grid_scrollBar
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.margins: 5
            policy: ScrollBar.AlwaysOn
        }

    }

}
