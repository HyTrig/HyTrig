/**
* @file MHG.qml
* @brief Mono Hybrid Gametype of game in the HyTrig GUI
* @authors Moritz Maas
*/

import org.julialang
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

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

    tab_list: [
        // TODO: Implement MHG tabs
    ]

    clear: function () {
        mhg_models.agents.clear();
        mhg_models.actions.clear();
        mhg_models.variables.clear();
        mhg_models.locations.clear();
        mhg_models.edges.clear();
        mhg_models.queries.clear();
        mhg_models.max_steps = "";
        mhg_models.time_bound = "";
        mhg_models.state_formula = "";
        verified = false;
    }

    save: function (file) {
        Julia.mhg_save(file);
    }

    load: function (file) {
        var error = Julia.mhg_load(file);
        current_file = file;
        action_tab.model = [];
        action_tab.model = mhg_models.actions;
        tabs.currentIndex = 0;
        agent_tab.model = [];
        agent_tab.model = mhg_models.agents;
        tabs.currentIndex = 1;
        variable_tab.model = [];
        variable_tab.model = mhg_models.variables;
        tabs.currentIndex = 2;
        location_tab.model = [];
        location_tab.model = mhg_models.locations;
        tabs.currentIndex = 3;
        edge_tab.model = [];
        edge_tab.model = mhg_models.edges;
        tabs.currentIndex = 4;
        termination_conditions_tab.max_steps.editingFinished();
        termination_conditions_tab.time_bound.editingFinished();
        termination_conditions_tab.state_formula.editingFinished();
        tabs.currentIndex = 5;
        query_tab.model = [];
        query_tab.model = mhg_models.queries;
        tabs.currentIndex = 6;
        tabs.currentIndex = tab_bar.currentIndex;
        verified = false;
        return error;
    }

    verify: function () {
        return Julia.mhg_verify();
    }

    verification_success: function () { 
        query_tab.model = [];
        query_tab.model = mhg_models.queries;
        tab_bar.currentIndex = 6;
        tabs.currentIndex = 6;
    }

}
