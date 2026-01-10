/**
* @file Selector.qml
* @brief GUI component for a selector of the HyTrig GUI
* @authors Moritz Maas
*/

import QtQuick
import QtQuick.Controls.Material

ComboBox {

    required property var action

    Material.foreground: Material.color(Material.Green)

    onActivated: {
        action(currentValue);
    }

}
