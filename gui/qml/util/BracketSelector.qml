/**
* @file BracketSelector.qml
* @brief GUI component for selecting an interval bracket of the HyTrig GUI
* @authors Moritz Maas
*/

import QtQuick
import QtQuick.Controls.Material

ComboBox {
    
    required property bool is_left
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
