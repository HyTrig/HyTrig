/**
* @file RegexField.qml
* @brief GUI component for an input field that uses a regex for validation.
* @authors Moritz Maas
*/

import QtQuick
import QtQuick.Controls.Material

TextField {

    required property var regex

    required property var action
    required property var condition

    required property string default_text
    required property string error_text
    required property string condition_error_text

    property color accepted_color: Material.color(Material.Green)
    property color error_color: Material.color(Material.Red)

    property bool edited: false

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
        Material.accent = acceptableInput ? accepted_color : error_color;
        placeholderText =  acceptableInput ? default_text : error_text;
    }

    // TODO: Fix forced focus on first list element.
    Component.onCompleted: {
        forceActiveFocus();
    }

}
