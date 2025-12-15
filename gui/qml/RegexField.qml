/**
* @file RegexField.qml
* @brief GUI component for an input field that uses a regex for validation.
* @authors Moritz Maas
*/

import QtQuick
import QtQuick.Controls.Material

TextField {

    required property var regex
    
    required property var onFinished

    required property string default_text
    required property string error_text

    property color accepted_color: Material.color(Material.Green)
    property color error_color: Material.color(Material.Red)

    Material.accent: error_color

    placeholderText: default_text

    validator: RegularExpressionValidator {
        regularExpression: regex
    }

    onEditingFinished: {
        onFinished(text);
        Material.foreground = accepted_color;
        focus = false;
    }

    onActiveFocusChanged: {
        if (!activeFocus && !acceptableInput) {
            text = "";
            onFinished(text);
        }
    }

    onTextChanged: {
        Material.foreground = parent.Material.foreground;
        Material.accent = acceptableInput ? accepted_color : error_color;
        placeholderText =  acceptableInput ? default_text : error_text;
    }

}
