/**
* @file SaveDialog.qml
* @brief GUI component for a save dialog of the HyTrig GUI
* @authors Moritz Maas
*/

import org.julialang
import QtQuick
import QtQuick.Controls.Material
import QtQuick.Dialogs

FileDialog {

    property var action: function(x) {}
    
    title: "Select a location to save the HyTrig file"
    
    fileMode: FileDialog.SaveFile
    modality: Qt.ApplicationModal
    nameFilters: ["HyTrig files (*.hytrig)"]
    defaultSuffix: "hytrig"
    onAccepted: {
        Julia.save(selectedFile.toString());
        action(selectedFile.toString());
    }

}
