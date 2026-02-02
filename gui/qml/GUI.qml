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

    Material.theme: Material.Dark
    Material.accent: Material.Blue
    Material.primary: Material.Blue

    property string current_file: ""
    property bool verified: false

    readonly property GameType game: game_types[game_type_selector.previous_index]
    readonly property list<GameType> game_types: [
        HGT { id: hgt_game },
        MHG { id: mhg_game }
    ]

    menuBar: MenuBar {
        
        id: menu_bar

        Menu {

            title: qsTr("File")

            Action {
                id: new_action
                text: qsTr("New")
                shortcut: "Ctrl+N"
                onTriggered: {
                    save_changes_dialog.action = function(x) {
                        game.clear();
                        current_file = "";
                        verified = false;
                    };
                    save_changes_dialog.cancel = function(x) {};
                    save_changes_dialog.open();
                }
            }

            Action {
                id: open_action
                text: qsTr("Open")
                shortcut: "Ctrl+O"
                onTriggered: {
                    save_changes_dialog.action = function(x) {
                        load_dialog.open();
                    };
                    save_changes_dialog.cancel = function(x) {};
                    save_changes_dialog.open();
                }
            }

            MenuSeparator {}

            Action {
                id: save_action
                text: qsTr("Save")
                shortcut: "Ctrl+S"
                onTriggered: {
                    save_dialog.action = function(x) {};
                    if (current_file == "") {
                        save_dialog.open();
                    } else {
                        game.save(current_file);
                    }
                }
            }

            Action {
                id: save_as_action
                text: qsTr("Save as")
                shortcut: "Ctrl+Shift+S"
                onTriggered: {
                    save_dialog.action = function(x) {};
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

            Action {
                id: verify_action
                text: qsTr("Verify")
                onTriggered: {
                    var error = game.verify();
                    if (error != "") {
                        error_dialog.text = qsTr("An error occurred during verification:");
                        error_dialog.informativeText = error;
                        error_dialog.open();
                    } else {
                        verified = true;
                        game.verification_success();
                    }
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
            height: parent.height

            model: game.tab_names

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
                    tabs.currentIndex = index;
                    forceActiveFocus();
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

                children: game.tab_list

            }

        }

        Item {

            height: parent.height
            SplitView.minimumWidth: 200
            SplitView.preferredWidth: 200

            Title {

                id: game_type_title
                width: parent.width
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 10
                text: "Game Type"

            }

            ComboBox {

                id: game_type_selector

                property int previous_index: 0

                width: parent.width
                anchors.top: game_type_title.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 10
                model: ["Hybrid Game with Triggers", "Monotonic Hybrid Game"]
                
                onActivated: {
                    if (previous_index != currentIndex) {
                        save_changes_dialog.action = function(x) {
                            game.clear();
                            previous_index = currentIndex;
                            current_file = "";
                            verified = false;
                        }
                        save_changes_dialog.cancel = function(x) {
                            game_type_selector.currentIndex = previous_index;
                        }
                        save_changes_dialog.open();
                    }
                }

                Component.onCompleted: {
                    console.assert(game_types.length == game_type_selector.model.length, "Number of game types does not match number of selections");
                }

            }

            Button {

                width: parent.width
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: verified ? tree_button.top : parent.bottom
                anchors.margins: 10

                text: "Verify"

                onClicked: {
                    verify_action.trigger();
                }

            }

            Button {

                id: tree_button
                width: parent.width
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.margins: 10

                text: "View Tree"
                visible: verified

                onClicked: {
                    tree_viewer.level = 1;
                    tree_viewer.branches.model = [];
                    tree_viewer.branches.model = tree.branches;
                    tree_viewer.show();
                }

            }

        }

    }

    MessageDialog {

        id: clear_dialog
        parentWindow: main_window

        title: qsTr("Clear all data?")
        text: qsTr("Do you really want to clear all data?")
        informativeText: qsTr("This action cannot be undone.")

        buttons: MessageDialog.Yes | MessageDialog.No

        onAccepted: {
            game.clear();
        }

    }

    MessageDialog {

        id: save_changes_dialog
        parentWindow: main_window

        property var action: function(x) {}
        property var cancel: function(x) {}

        title: qsTr("Save File?")
        text: current_file == "" ? qsTr("Do you want to save changes?") : qsTr("Do you want to save changes to ") + current_file + qsTr("?")
        informativeText: qsTr("Unsaved changes will be lost.")

        buttons: MessageDialog.Save | MessageDialog.Discard | MessageDialog.Cancel

        onButtonClicked: (button, role) => {
            switch (button) {
                case MessageDialog.Save:
                    if (current_file == "") {
                        save_dialog.action = action;
                        save_dialog.open();
                    } else {
                        game.save(current_file);
                        action(current_file);
                    }
                    break;
                case MessageDialog.Discard:
                    action(current_file);
                    break;
                case MessageDialog.Cancel:
                    cancel(current_file);
                    close();
                    break;
            }
        }

    }

    FileDialog {

        id: save_dialog
        parentWindow: main_window

        property var action: function(x) {}
        
        title: qsTr("Select a location to save the HyTrig file")
        
        fileMode: FileDialog.SaveFile
        nameFilters: ["HyTrig files (*.hytrig)"]
        defaultSuffix: "hytrig"

        onAccepted: {
            game.save(selectedFile.toString());
            action(selectedFile.toString());
        }

    }

    FileDialog {

        id: load_dialog
        parentWindow: main_window

        title: qsTr("Select a HyTrig file to load")

        fileMode: FileDialog.OpenFile
        nameFilters: ["HyTrig files (*.hytrig)"]
        defaultSuffix: "hytrig"

        onAccepted: {
            var error = game.load(selectedFile.toString());
            if (error != "") {
                error_dialog.text = qsTr("An error occurred while loading " + selectedFile.toString() + ":");
                error_dialog.informativeText = error;
                error_dialog.open();
            } else {
                current_file = selectedFile.toString();
            }
        }

    }

    MessageDialog {

        id: error_dialog
        parentWindow: main_window

        title: qsTr("Error")
        text: qsTr("An error occurred:")
        informativeText: qsTr("")

        buttons: MessageDialog.Ok

    }

    TreeViewer {
        id: tree_viewer
    }

}
