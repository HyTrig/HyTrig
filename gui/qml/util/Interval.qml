/**
* @file Interval.qml
* @brief GUI component for an interval of the HyTrig GUI
* @authors Moritz Maas
*/

import QtQuick
import QtQuick.Controls.Material

Row {

    height: lower_field.height
    spacing: 10

    // Data model of the interval, with properties lower, upper, lower_open, upper_open
    required property var interval_model

    property real bracket_width: 70
    property real inset: 0

    BracketSelector {
        id: left_bracket_selector
        width: bracket_width
        height: parent.height
        topInset: inset

        currentIndex: find(interval_model.lower_open ? "(" : "[")

        is_left: true
        action: function (open) {
            interval_model.lower_open = open;
        }
    }

    RegexField {
        id: lower_field
        width: (parent.width - left_bracket_selector.width - right_bracket_selector.width - comma_label.width - 4 * parent.spacing) / 2
        topInset: inset
        
        text: qsTr(interval_model.lower.toString())
        default_text: qsTr("Enter decimal")
        error_text: qsTr("Invalid decimal")
        condition_error_text: qsTr("Interval not monotonic")

        regex: /(^-?(([1-9]\d*(\.\d+)?$)|(0\.\d*[1-9])$))|(^0$)/

        action: function(x) {
            interval_model.lower = parseFloat(x);
        }
        condition: function(x) {
            if (interval_model.upper > 0) {
                return parseFloat(x) >= 0;
            } else if (interval_model.upper < 0) {
                return parseFloat(x) <= 0;
            } else {
                return true;
            }
        }
        error_value: 0
    }

    Label {
        id: comma_label
        height: parent.height
        verticalAlignment: Text.AlignVCenter
        text: qsTr(",")
    }

    RegexField {
        id: upper_field
        width: (parent.width - left_bracket_selector.width - right_bracket_selector.width - comma_label.width - 4 * parent.spacing) / 2
        topInset: inset
        
        text: qsTr(interval_model.upper.toString())
        default_text: qsTr("Enter decimal")
        error_text: qsTr("Invalid decimal")
        condition_error_text: qsTr("Interval not monotonic")

        regex: /(^-?(([1-9]\d*(\.\d+)?$)|(0\.\d*[1-9])$))|(^0$)/

        action: function(x) {
            interval_model.upper = parseFloat(x);
        }
        condition: function(x) {
            if (interval_model.lower > 0) {
                return parseFloat(x) >= 0;
            } else if (interval_model.lower < 0) {
                return parseFloat(x) <= 0;
            } else {
                return true;
            }
        }
        error_value: 0
    }

    BracketSelector {
        id: right_bracket_selector
        width: bracket_width
        height: parent.height
        topInset: inset

        currentIndex: find(interval_model.upper_open ? ")" : "]")

        is_left: false
        action: function (open) {
            interval_model.upper_open = open;
        }
    }

}
