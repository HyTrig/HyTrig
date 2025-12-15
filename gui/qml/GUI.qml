/**
* @file GUI.qml
* @brief Main GUI component for the HyTrig GUI
* @authors Moritz Maas
*/

import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Window

// HyTrig application window
ApplicationWindow {

    id: main_window

    width: 1920
    minimumWidth: 1000
    height: 1080
    minimumHeight: 800

    title: qsTr("HyTrig")
    visible: true

    Material.theme: Material.Dark
    Material.accent: Material.Blue
    Material.primary: Material.color(Material.Grey, Material.Shade800)

    

    menuBar: MenuBar {
        
        id: menu_bar

        Menu {

            title: qsTr("File")

            MenuItem {
                text: qsTr("New")
                onTriggered: {
                    // TODO
                }
            }

            MenuItem {
                text: qsTr("Open")
                onTriggered: {
                    // TODO
                }
            }

            MenuSeparator {}

            MenuItem {
                text: qsTr("Save")
                onTriggered: {
                    // TODO
                }
            }

            MenuItem {
                text: qsTr("Save as")
                onTriggered: {
                    // TODO
                }
            }
            
        }

        Menu {

            title: qsTr("Edit")

        }

        Menu {

            title: qsTr("View")

            MenuItem {
                text: qsTr("Toggle Fullscreen")
                onTriggered: {
                    main_window.visibility = main_window.visibility === Window.FullScreen ? Window.Windowed : Window.FullScreen
                }
            }

            MenuItem {
                text: main_window.Material.theme === Material.Dark ? qsTr("Light Theme") : qsTr("Dark Theme")
                onTriggered: {
                    main_window.Material.theme = main_window.Material.theme === Material.Dark ? Material.Light : Material.Dark
                }
            }
            
        }

    }

    Rectangle {

        id: menu_bar_spacer
        width: parent.width
        height: 2
        anchors.top: parent.top
        anchors.left: parent.left
        color: Material.accent

    }

    Row {

        id: tab_content_row
        width: parent.width
        height: parent.height - menu_bar_spacer.height
        anchors.top: menu_bar_spacer.bottom
        anchors.left: parent.left

        ListView {

            id: tab_bar
            width: Math.max(100, tab_content_splitter.x)
            height: parent.height

            model: ListModel {
                ListElement { name: "Agents" }
                ListElement { name: "Actions" }
                ListElement { name: "Variables" }
                ListElement { name: "Triggers" }
                ListElement { name: "Locations" }
                ListElement { name: "Edges" }
                ListElement { name: "Queries" }
            }

            delegate: ItemDelegate {

                id: tab_selector
                width: parent.width
                text: name
                highlighted: ListView.isCurrentItem
            
                background: Row {

                    width: parent.width
                    height: parent.height

                    Rectangle {
                        width: parent.width - selection_indicator.width
                        height: parent.height
                        color: Material.foreground
                        opacity: tab_selector.highlighted || tab_selector.hovered ? 0.1 : 0
                    }

                    Rectangle {
                        id: selection_indicator
                        width: tab_selector.highlighted ? 5 : 0
                        height: parent.height
                        color: tab_selector.highlighted ? Material.accent : Material.background
                    }

                }

                onClicked: {
                    tab_bar.currentIndex = index
                }

            }

        }

        Rectangle {

            id: tab_content_splitter
            x: 200
            width: 2
            height: parent.height
            color: Material.accent

            MouseArea {

                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.SplitHCursor
                drag.target: tab_content_splitter
                drag.axis: Drag.XAxis
                drag.minimumX: 100
                drag.maximumX: main_window.width / 2

            }

        }

        Item {

            width: parent.width - tab_bar.width - tab_content_splitter.width
            height: parent.height

            StackLayout {

                id: tabs
                anchors.fill: parent
                anchors.margins: 5
                currentIndex: tab_bar.currentIndex

                Tab {
                    Agents {
                        id: agent_tab
                    }
                }

                Tab {
                    Actions {
                        id: action_tab
                    }
                }

                Tab {
                    Variables {
                        id: variable_tab
                    }
                }

                Tab {
                    Triggers {
                        id: trigger_tab
                    }
                }

                Tab {
                    Locations {
                        id: location_tab
                    }
                }

                Tab {
                    Edges {
                        id: edge_tab
                    }
                }

                Tab {
                    Queries {
                        id: query_tab
                    }
                }

            }

        }

    }

}
