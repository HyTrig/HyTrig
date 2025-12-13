/**
* @file GUI.qml
* @brief Main GUI component for the HyTrig GUI
* @authors Moritz Maas
*/

import org.julialang
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
                width: parent.width
                text: name
                onClicked: {
                    tabs.currentIndex = index;
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

            }

        }

        StackLayout {

            id: tabs
            width: parent.width - tab_bar.width - tab_content_splitter.width
            height: parent.height

            Agents {
                id: agent_tab
            }

            Actions {
                id: action_tab
            }

            Variables {
                id: variable_tab
            }

            Triggers {
                id: trigger_tab
            }

            Locations {
                id: location_tab
            }

            Edges {
                id: edge_tab
            }

            Queries {
                id: query_tab
            }

        }

    }

}
