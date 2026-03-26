/**
* @file GameViewer.qml
* @brief GUI component for a window dedicated to traversing a verified game tree.
* @authors Moritz Maas
*/

import QtQuick
import QtQuick.Controls.Material
import QtQuick.Dialogs

ApplicationWindow {

    // Function for resetting the game viewer, no return value
    required property var reset
    // Function for setting the game viewer to a specific query, no return value
    required property var set

    readonly property alias save_tree_dialog: save_tree_dialog
       
    width: 1500
    height: 1000
    minimumWidth: 1000
    minimumHeight: 800

    modality: Qt.ApplicationModal

    title: "Game tree viewer"

    Material.theme: main_window.Material.theme
    Material.accent: main_window.Material.accent
    Material.foreground: main_window.Material.foreground

    onClosing: {
        reset();
    }

    FileDialog {

        id: save_tree_dialog
        parentWindow: parent

        // Function executed after saving, set before opening the dialog
        property var action: function(x) {}
        
        title: qsTr("Select a location to save the game tree")
        
        fileMode: FileDialog.SaveFile
        currentFolder: Qt.resolvedUrl("../../logs/")
        nameFilters: ["Markdown files (*.md)"]
        defaultSuffix: "md"

        onAccepted: {
            var path = selectedFile.toString();
            game.save(path);
            current_file = path;
            action(path);
        }

    }

}
