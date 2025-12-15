/**
* @file RegexField.qml
* @brief GUI component for an input field that uses a regex for validation.
* @authors Moritz Maas
*/

import QtQuick
import QtQuick.Controls.Material

TextField {
    
    required property alias data
    required property var regex

    text: data
    placeholderText: "Default placeholder"

    validator: RegularExpressionValidator {
        regularExpression: regex
    }

    onEditingFinished: {
        data = text;
        focus = false;
    }

    onActiveFocusChanged: {
        if (!activeFocus && !acceptableInput) {
            text = ""
        }
    }

}
