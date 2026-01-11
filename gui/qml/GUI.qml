/**
* @file GUI.qml
* @brief Main GUI component for the HyTrig GUI
* @authors Moritz Maas
*/

import org.julialang
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Dialogs
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

    property string current_file: ""

    signal actionRemoved(string name)
    signal agentRemoved(string name)
    signal locationRemoved(string name)
    signal variableAdded()
    signal variableRemoved(int index)
    signal variableRenamed(int index, string name)

    function clear() {
        models.agents.clear();
        models.actions.clear();
        models.variables.clear();
        models.triggers.clear();
        models.locations.clear();
        models.edges.clear();
        models.queries.clear();
        config.max_steps = "";
        config.time_bound = "";
        config.state_formula = "";
    }

    function load(file) {
        Julia.load(file);
        current_file = file;
        action_tab.model = [];
        action_tab.model = models.actions;
        agent_tab.model = [];
        agent_tab.model = models.agents;
        variable_tab.model = [];
        variable_tab.model = models.variables;
        trigger_tab.model = [];
        trigger_tab.model = models.triggers;
        location_tab.model = [];
        location_tab.model = models.locations;
        edge_tab.model = [];
        edge_tab.model = models.edges;
        query_tab.model = [];
        query_tab.model = models.queries;
    }

    menuBar: MenuBar {
        
        id: menu_bar

        Menu {

            title: qsTr("File")

            Action {
                id: new_action
                text: qsTr("New")
                shortcut: "Ctrl+N"
                onTriggered: {
                    new_dialog.open();
                }
            }

            Action {
                id: open_action
                text: qsTr("Open")
                shortcut: "Ctrl+O"
                onTriggered: {
                    load_dialog.open();
                }
            }

            MenuSeparator {}

            Action {
                id: save_action
                text: qsTr("Save")
                shortcut: "Ctrl+S"
                onTriggered: {
                    if (current_file == "") {
                        save_dialog.open();
                    } else {
                        Julia.save(current_file);
                    }
                }
            }

            Action {
                id: save_as_action
                text: qsTr("Save as")
                shortcut: "Ctrl+Shift+S"
                onTriggered: {
                    save_dialog.open();
                }
            }
            
        }

        Menu {

            title: qsTr("Edit")

            Action {
                id: clear_action
                text: qsTr("Clear")
                onTriggered: {
                    clear_dialog.open();
                }
            }

        }

        Menu {

            title: qsTr("View")

            Action {
                id: toggle_fullscreen_action
                text: qsTr("Toggle Fullscreen")
                shortcut: "F11"
                onTriggered: {
                    main_window.visibility = main_window.visibility == Window.FullScreen ? Window.Windowed : Window.FullScreen
                }
            }

            Action {
                id: toggle_theme_action
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

    SplitView {

        // TODO: set correct widths for children
        id: tab_content_split
        width: parent.width
        height: parent.height - menu_bar_spacer.height
        anchors.top: menu_bar_spacer.bottom
        anchors.left: parent.left

        handle: Rectangle {
            implicitWidth: 4
            implicitHeight: 4
            color: SplitHandle.pressed ? Material.accent
                : (SplitHandle.hovered ? (Material.theme == Material.Dark ? Material.color(Material.Grey, Material.Shade800)
                    : Material.color(Material.Grey, Material.Shade300)) : Material.background)
        }

        ListView {

            id: tab_bar
            SplitView.minimumWidth: 100
            SplitView.preferredWidth: 200
            SplitView.maximumWidth: 300
            height: parent.height

            model: ListModel {
                ListElement { name: "Agents" }
                ListElement { name: "Actions" }
                ListElement { name: "Variables" }
                ListElement { name: "Triggers" }
                ListElement { name: "Locations" }
                ListElement { name: "Edges" }
                ListElement { name: "Queries" }
                ListElement { name: "Term. Conditions" }
            }

            delegate: ItemDelegate {

                id: tab_selector
                width: parent.width
                text: qsTr(model.name)
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

        Item {

            height: parent.height
            SplitView.minimumWidth: 500
            SplitView.fillWidth: true

            StackLayout {

                id: tabs
                anchors.fill: parent
                anchors.margins: 5
                currentIndex: tab_bar.currentIndex

                ElementTab {

                    id: agent_tab

                    tab_name: "Agents"
                    element_name: "Agent"

                    add: function() {
                        models.agents.appendRow({name: ""});
                    }

                    model: models.agents
                    delegate: Agent {
                        width: agent_tab.cellWidth
                    }

                }

                ElementTab {

                    id: action_tab

                    tab_name: "Actions"
                    element_name: "Action"

                    add: function() {
                        models.actions.appendRow({name: ""});
                    }

                    model: models.actions
                    delegate: Act {
                        width: action_tab.cellWidth
                    }

                }

                ElementTab {

                    id: variable_tab

                    tab_name: "Variables"
                    element_name: "Variable"

                    add: function() {
                        models.variables.appendRow({name: "", expression: ""});
                        variableAdded();
                    }

                    model: models.variables
                    delegate: Variable {
                        width: variable_tab.cellWidth
                    }

                }

                ElementTab {

                    id: trigger_tab

                    tab_name: "Triggers"
                    element_name: "Trigger"

                    add: function() {
                        models.triggers.appendRow({agent: "", trigger: ""})
                    }

                    model: models.triggers
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

                ElementTab {

                    id: location_tab
                    cellWidth: 700

                    tab_name: "Locations"
                    element_name: "Location"

                    add: function() {
                        var flow = []
                        for (var i = 0; i < models.variables.rowCount(); i++) {
                            flow.push({
                                variable: models.variables.data(models.variables.index(i, 0), roles.name),
                                expression: models.variables.data(models.variables.index(i, 0), roles.name)
                            })
                        }
                        models.locations.appendRow({
                            name: "",
                            initial: models.locations.rowCount() == 0,
                            invariant: "",
                            flow: flow
                        });
                    }

                    model: models.locations
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
                                if (model.flow) {
                                    model.flow.setData(model.flow.index(index, 0), name, roles.name);
                                }
                            }
                        }
                    }

                    ButtonGroup {
                        id: initial_location_group
                    }

                }

                ElementTab {

                    id: edge_tab
                    cellWidth: 700

                    tab_name: "Edges"
                    element_name: "Edge"

                    add: function() {
                        var jump = []
                        for (var i = 0; i < models.variables.rowCount(); i++) {
                            jump.push({
                                variable: models.variables.data(models.variables.index(i, 0), roles.name),
                                expression: models.variables.data(models.variables.index(i, 0), roles.name)
                            })
                        }
                        models.edges.appendRow({
                            source: "",
                            target: "",
                            guard: "",
                            agent: "",
                            action: "",
                            jump: jump
                        });
                    }

                    model: models.edges
                    delegate: Edge {
                        width: edge_tab.cellWidth

                        Connections {
                            target: main_window
                            function onActionRemoved(name) {
                                model.action = "";
                            }
                            function onAgentRemoved(name) {
                                model.agent = "";
                            }
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
                                if (model.jump) {
                                    model.jump.setData(model.jump.index(index, 0), name, roles.name);
                                }
                            }
                        }
                    }

                }

                ElementTab {

                    id: query_tab
                    cellWidth: 700

                    tab_name: "Queries"
                    element_name: "Query"

                    add: function() {
                        models.queries.appendRow({formula: ""});
                    }

                    model: models.queries
                    delegate: Query {
                        width: query_tab.cellWidth
                    }

                }

                TerminationConditions {

                    id: termination_conditions_tab

                }

            }

        }

        Item {

            height: parent.height
            SplitView.minimumWidth: 200
            SplitView.preferredWidth: 200
            SplitView.maximumWidth: 400

            // TODO: selector title

            ComboBox {

                id: verification_mode_selector
                width: parent.width
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 10
                model: ["HyTrig", "Example2", "Example3"]

                // TODO: change content based on selection

            }

            Button {

                width: parent.width
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.margins: 10

                text: "Verify"

            }

        }

    }

    // TODO: refactor dialogs

    MessageDialog {
        id: new_dialog
        title: "Save current changes?"
        // TODO: style message dialog

        onAccepted: {
            if (current_file == "") {
                new_dialog_save.open();
            } else {
                Julia.save(current_file);
                clear();
                current_file = "";
            }
        }
        onRejected: {
            clear();
            current_file = "";
        }
    }

    SaveDialog {
        id: new_dialog_save
        
        action: function(x) {
            clear();
            current_file = "";
        }
    }

    SaveDialog {
        id: save_dialog
        
        action: function(x) {
            current_file = x;
        }
    }

    MessageDialog {
        id: load_dialog
        title: "Save current changes?"
        // TODO: style message dialog

        onAccepted: {
            if (current_file == "") {
                load_dialog_save.open();
            } else {
                Julia.save(current_file);
                load_dialog_load.open();
            }
        }
        onRejected: {
            load_dialog_load.open();
        }
    }

    SaveDialog {
        id: load_dialog_save
        
        action: function(x) {
            load_dialog_load.open();
        }
    }

    FileDialog {
        id: load_dialog_load
        title: "Select a HyTrig file to load"

        fileMode: FileDialog.OpenFile
        modality: Qt.ApplicationModal
        // TODO: load and save all existing jsons
        // nameFilters: ["HyTrig files (*.hytrig)"]
        defaultSuffix: "hytrig"
        onAccepted: {
            load(selectedFile.toString());
            current_file = selectedFile.toString();
        }
    }

    MessageDialog {
        id: clear_dialog
        title: "Are you sure?"
        // TODO: style message dialog

        onAccepted: {
            clear();
        }
    }

}
