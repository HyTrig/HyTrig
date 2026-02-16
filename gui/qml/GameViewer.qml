/**
* @file GameViewer.qml
* @brief GUI component for a window dedicated to traversing a verified game tree.
* @authors Moritz Maas
*/

import QtQuick
import QtQuick.Controls.Material

ApplicationWindow {

    /// Function for resetting the game viewer, no return value
    required property var reset
       
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

}
