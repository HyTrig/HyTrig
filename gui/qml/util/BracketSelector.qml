/**
* @file BracketSelector.qml
* @brief GUI component for selecting an interval bracket of the HyTrig GUI
* @authors 
*/

import QtQuick
import QtQuick.Controls.Material

ComboBox {
    
    required property bool is_left
    // Function executed when a bracket is selected, receives a boolean indicating whether an opening bracket was selected
    required property var action

    property ListModel left_model: ListModel {
        ListElement { bracket: "(" }
        ListElement { bracket: "[" }
    }
    property ListModel right_model: ListModel {
        ListElement { bracket: ")" }
        ListElement { bracket: "]" }
    }

    model: is_left ? left_model : right_model

    textRole: "bracket"
    valueRole: "bracket"

    onActivated: {
        var open = (currentValue == "(" || currentValue == ")");
        action(open);
    }

}
