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
    visibility: Window.FullScreen

    Material.theme: Material.Dark
    Material.accent: Material.Blue
    Material.primary: Material.Blue

    signal agentRemoved(string name)
    signal locationRemoved(string name)
    signal variableAdded()
    signal variableRemoved(int index)
    signal variableRenamed(int index, string name)

    menuBar: MenuBar {
        
        id: menu_bar

        Menu {

            title: qsTr("File")

            Action {
                text: qsTr("New")
                onTriggered: {
                    // TODO
                }
            }

            Action {
                text: qsTr("Open")
                onTriggered: {
                    // TODO
                }
            }

            MenuSeparator {}

            Action {
                text: qsTr("Save")
                onTriggered: {
                    // TODO
                }
            }

            Action {
                text: qsTr("Save as")
                onTriggered: {
                    // TODO
                }
            }
            
        }

        Menu {

            title: qsTr("Edit")

            Action {
                text: qsTr("Clear")
                onTriggered: {
                    agent_model.clear();
                    action_model.clear();
                    variable_model.clear();
                    trigger_model.clear();
                    location_model.clear();
                    // TODO: edges and queries
                }
            }

        }

        Menu {

            title: qsTr("View")

            Action {
                text: qsTr("Toggle Fullscreen")
                shortcut: "F11"
                onTriggered: {
                    main_window.visibility = main_window.visibility == Window.FullScreen ? Window.Windowed : Window.FullScreen
                }
            }

            Action {
                text: main_window.Material.theme == Material.Dark ? qsTr("Light Theme") : qsTr("Dark Theme")
                onTriggered: {
                    main_window.Material.theme = main_window.Material.theme == Material.Dark ? Material.Light : Material.Dark
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
                    tab_bar.currentIndex = index;
                    focus = true;
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

                    id: agent_tab

                    tab_name: "Agents"
                    element_name: "Agent"

                    add: function() {
                        agent_model.appendRow({name: ""});
                    }

                    model: agent_model
                    delegate: Agent {
                        width: agent_tab.cellWidth
                    }

                }

                Tab {

                    id: action_tab

                    tab_name: "Actions"
                    element_name: "Action"

                    add: function() {
                        action_model.appendRow({name: ""});
                    }

                    model: action_model
                    delegate: Act {
                        width: action_tab.cellWidth
                    }

                }

                Tab {

                    id: variable_tab

                    tab_name: "Variables"
                    element_name: "Variable"

                    add: function() {
                        variable_model.appendRow({name: "", value: ""});
                        variableAdded();
                    }

                    model: variable_model
                    delegate: Variable {
                        width: variable_tab.cellWidth
                    }

                }

                Tab {

                    id: trigger_tab

                    tab_name: "Triggers"
                    element_name: "Trigger"

                    add: function() {
                        trigger_model.appendRow({agent: "", trigger: ""})
                    }

                    model: trigger_model
                    delegate: Trigger {
                        width: trigger_tab.cellWidth
                        
                        Connections {
                            target: main_window
                            function onAgentRemoved(name) {
                                if (model.agent == name) {
                                    model.agent = "";
                                }
                            }
                        }
                    }

                }

                Tab {

                    id: location_tab
                    cellWidth: 700

                    tab_name: "Locations"
                    element_name: "Location"

                    add: function() {
                        var flow = []
                        for (var i = 0; i < variable_model.rowCount(); i++) {
                            flow.push({
                                variable: variable_model.data(variable_model.index(i, 0), roles.variable_name),
                                expression: variable_model.data(variable_model.index(i, 0), roles.variable_name)
                            })
                        }
                        location_model.appendRow({
                            name: "",
                            initial: location_model.rowCount() == 0,
                            invariant: "",
                            flow: flow
                        });
                    }

                    model: location_model
                    delegate: Location {
                        width: location_tab.cellWidth

                        Connections {
                            target: main_window
                            function onVariableAdded() {
                                model.flow.appendRow({variable: "", expression: ""});
                            }
                            function onVariableRemoved(index) {
                                model.flow.removeRow(index);
                            }
                            function onVariableRenamed(index, name) {
                                model.flow.setData(model.flow.index(index, 0), name, roles.variable_name);
                            }
                        }
                    }

                    ButtonGroup {
                        id: initial_location_group
                    }

                }

                Tab {

                    id: edge_tab
                    cellWidth: 700

                    tab_name: "Edges"
                    element_name: "Edge"

                    add: function() {
                        var jump = []
                        for (var i = 0; i < variable_model.rowCount(); i++) {
                            jump.push({
                                variable: variable_model.data(variable_model.index(i, 0), roles.variable_name),
                                expression: variable_model.data(variable_model.index(i, 0), roles.variable_name)
                            })
                        }
                        edge_model.appendRow({
                            source: "",
                            target: "",
                            guard: "",
                            jump: jump
                        });
                    }

                    model: edge_model
                    delegate: Edge {
                        width: edge_tab.cellWidth

                        Connections {
                            target: main_window
                            function onLocationRemoved(name) {
                                if (model.source == name) {
                                    model.source = "";
                                }
                                if (model.target == name) {
                                    model.target = "";
                                }
                            }
                            function onVariableAdded() {
                                model.jump.appendRow({variable: "", expression: ""});
                            }
                            function onVariableRemoved(index) {
                                model.jump.removeRow(index);
                            }
                            function onVariableRenamed(index, name) {
                                model.jump.setData(model.jump.index(index, 0), name, roles.variable_name);
                            }
                        }
                    }

                }

                Tab {

                    id: query_tab
                    cellWidth: 700

                    tab_name: "Queries"
                    element_name: "Query"

                    add: function() {
                        query_model.appendRow({formula: ""});
                    }

                    model: query_model
                    delegate: Query {
                        width: query_tab.cellWidth
                    }

                }

            }

        }

    }

}
