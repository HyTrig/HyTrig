/**
* @file RegexField.qml
* @brief GUI component for an input field that uses a regex for validation.
* @authors Moritz Maas
*/

import QtQuick
import QtQuick.Controls.Material

TextField {

    // Regular expression for validating the input
    required property var regex

    // Function executed when the input is valid and condition is met, receives the input text
    required property var action
    // Function that checks an additional condition on the input, receives the input text and returns a boolean
    required property var condition

    required property string default_text
    required property string error_text
    required property string condition_error_text

    property color accepted_color: Material.color(Material.Green)
    property color error_color: Material.color(Material.Red)

    property bool edited: true

    Material.accent: error_color

    placeholderText: default_text

    validator: RegularExpressionValidator {
        regularExpression: regex
    }

    onEditingFinished: {
        if (edited) {
            edited = false;
            if (condition(text)) {
                action(text);
                Material.foreground = accepted_color;
                focus = false;
            } else {
                action("");
                placeholderText = condition_error_text;
            }
        } else {
            focus = false;
        }
    }

    onTextChanged: {
        edited = true;
        Material.foreground = parent.Material.foreground;
        let valid = acceptableInput && condition(text);
        Material.accent = valid ? accepted_color : error_color;
        placeholderText =  valid ? default_text : error_text;
    }

    // On component load, trigger editingFinished to validate initial text
    Component.onCompleted: {
        editingFinished();
    }

}
