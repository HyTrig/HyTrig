/**
* @file MHG.qml
* @brief Mono Hybrid Gametype of game in the HyTrig GUI
* @authors Moritz Maas
*/

import QtQuick

GameType {

    game_type_name: "MHG"

    tab_names: ListModel {
        ListElement { name: "Agents" }
        ListElement { name: "Actions" }
        ListElement { name: "Variables" }
        ListElement { name: "Locations" }
        ListElement { name: "Edges" }
        ListElement { name: "Term. Conditions" }
        ListElement { name: "Queries" }
    }

    tab_list: []

    clear: function () {
    }

    save: function (file) {
    }

    load: function (file) {
    }

    verify: function () {
        return "";
    }

    verification_success: function () {
    }

}
