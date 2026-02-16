/**
* @file CheckMark.qml
* @brief GUI component for displaying a tristate checkbox
* @authors Moritz Maas
*/

import QtQml
import QtQuick
import QtQuick.Controls.Material

Image {

    required property bool enabled
    required property bool checked

    readonly property string icons: "../icons/"
    readonly property string mode: main_window.Material.theme == Material.Dark ? "dark/" : "light/"
    readonly property string state: enabled ? (checked ? "_true" : "_false") : ""
    readonly property url source_url: Qt.resolvedUrl(icons + mode + "checkbox" + state + ".png")

    source: source_url
    fillMode: Image.PreserveAspectFit

}
