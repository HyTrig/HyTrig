/**
* @file CheckMark.qml
* @brief GUI component for displaying a tristate checkbox
* @authors 
*/

import QtQml
import QtQuick
import QtQuick.Controls.Material

Image {

    required property bool enabled
    required property bool checked

    readonly property string state: enabled ? (checked ? "_true" : "_false") : ""
    readonly property url source_url: Qt.resolvedUrl("../" + icon_path + "checkbox" + state + ".png")

    source: source_url
    fillMode: Image.PreserveAspectFit

    MouseArea {
        enabled: parent.enabled
        anchors.fill: parent
        onClicked: {
            show_tree(index);
        }
    }

}
