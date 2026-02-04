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

    // Function for clearing the current game, no return value
    required property var clear

    // Function for saving the current game, no return value
    required property var save

    // Function for loading a saved game, returns "" on success, error message otherwise
    required property var load

    // Function for verifying the current game, returns "" on success, error message otherwise
    required property var verify

    // Function called after successful verification, no retrun value
    required property var verification_success

    Component.onCompleted: {
        console.assert(tab_list.length == tab_names.count, "Number of tabs of " + game_type_name + " does not match number of tab names");
    }

}
