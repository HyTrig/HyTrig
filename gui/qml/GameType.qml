/**
* @file GameType.qml
* @brief Abstract class for types of games in the HyTrig GUI
* @authors Moritz Maas
*/

import QtQuick

Item {

    visible: false

    required property string game_type_name
    required property ListModel tab_names
    required property list<Item> tab_list
    required property var clear
    required property var save
    required property var load
    required property var verify
    required property var verification_success

    Component.onCompleted: {
        console.assert(tab_list.length == tab_names.count, "Number of tabs of " + game_type_name + " does not match number of tab names");
    }

}
