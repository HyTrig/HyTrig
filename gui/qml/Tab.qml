/**
* @file Tab.qml
* @brief GUI component for a tab of the HyTrig GUI
* @authors Moritz Maas
*/

import QtQuick
import QtQuick.Controls.Material

Rectangle {

    required property string tab_name
    required property string element_name
    
    required property var add

    property alias model: elements.model
    property alias delegate: elements.delegate
    property alias cellWidth: elements.cellWidth

    color: Material.background
    border.width: 1
    border.color: Material.accentColor

    Column {

        anchors.fill: parent
        spacing: 20

        Row {

            id: title_row
            width: parent.width
            height: tab_title.implicitHeight + topPadding + bottomPadding
            topPadding: 10
            bottomPadding: 10
            leftPadding: 20

            TabTitle {
                
                id: tab_title
                width: parent.width - add_button.width - 2 * parent.leftPadding
                height: parent.height
                text: qsTr(tab_name)

            }

            Button {

                id: add_button
                height: parent.height
                text: qsTr("Add " + element_name)
                Material.background: hovered ? Material.accent : Material.primary
                onClicked: {
                    add();
                }

            }

        }

        Item {

            width: parent.width
            height: parent.height - title_row.height - parent.spacing

            GridView {

                id: elements
                anchors.fill: parent
                anchors.margins: 5
                anchors.rightMargin: grid_scrollBar.width + grid_scrollBar.anchors.margins
                clip: true
                cellWidth: 350
                cellHeight: currentItem ? currentItem.height : 0
                currentIndex: 0

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

}
