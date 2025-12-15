/**
* @file RegexField.qml
* @brief GUI component for an input field that uses a regex for validation.
* @authors Moritz Maas
*/

import QtQuick
import QtQuick.Controls.Material

TextField {
    
    required property var onFinished
    required property var regex

    validator: RegularExpressionValidator {
        regularExpression: regex
    }

    onEditingFinished: {
        onFinished(text);
        focus = false;
    }

    onActiveFocusChanged: {
        if (!activeFocus && !acceptableInput) {
            text = "";
        }
    }

}
