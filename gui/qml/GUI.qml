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

    TabBar {

        id: tab_bar
        width: parent.width
        anchors.top: menu_bar.bottom
        anchors.left: parent.left

        TabButton {
            text: qsTr("Agents")
        }

        TabButton {
            text: qsTr("Actions")
        }

        TabButton {
            text: qsTr("Variables")
        }

        TabButton {
            text: qsTr("Triggers")
        }

        TabButton {
            text: qsTr("Locations")
        }

        TabButton {
            text: qsTr("Edges")
        }
        
        TabButton {
            text: qsTr("Queries")
        }

    }

    StackLayout {

        width: parent.width
        height: parent.height - tab_bar.height
        anchors.top: tab_bar.bottom
        anchors.left: parent.left
        currentIndex: tab_bar.currentIndex

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
