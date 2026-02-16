/**
* @file qml
* @brief Mono Hybrid Gametype of game in the HyTrig GUI
* @authors Moritz Maas
*/

import org.julialang
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

import ".."
import "../util"
import "elements" as Elements

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
        ElementTab {

            id: agent_tab

            tab_name: "Agents"
            element_name: "Agent"

            add: function() {
                mhg_models.agents.appendRow({name: ""});
            }

            model: mhg_models.agents
            delegate: Elements.Agent {
                width: agent_tab.cellWidth
            }

        },

        ElementTab {

            id: action_tab

            tab_name: "Actions"
            element_name: "Action"

            add: function() {
                mhg_models.actions.appendRow({name: ""});
            }

            model: mhg_models.actions
            delegate: Elements.Action {
                width: action_tab.cellWidth
            }

        },

        ElementTab {

            id: variable_tab
            cellWidth: 700

            tab_name: "Variables"
            element_name: "Variable"

            add: function() {
                mhg_models.variables.appendRow({name: "", lower_open: true, upper_open: true, lower: 0.0, upper: 0.0});
                variableAdded();
            }

            model: mhg_models.variables
            delegate: Elements.Variable {
                width: variable_tab.cellWidth
            }

        },

        ElementTab {

            id: location_tab
            cellWidth: 700

            tab_name: "Locations"
            element_name: "Location"

            add: function() {
                var flow = []
                for (var i = 0; i < mhg_models.variables.rowCount(); i++) {
                    flow.push({
                        variable: mhg_models.variables.data(mhg_models.variables.index(i, 0), roles.name),
                        lower_open: true,
                        upper_open: true,
                        lower: 0.0,
                        upper: 0.0
                    })
                }
                mhg_models.locations.appendRow({
                    name: "",
                    initial: mhg_models.locations.rowCount() == 0,
                    invariant: "",
                    flow: flow
                });
            }

            model: mhg_models.locations
            delegate: Elements.Location {
                width: location_tab.cellWidth

                Connections {
                    target: mhg_game
                    function onVariableAdded() {
                        model.flow.appendRow({variable: "", lower_open: true, upper_open: true, lower: 0.0, upper: 0.0});
                    }
                    function onVariableRemoved(index) {
                        model.flow.removeRow(index);
                    }
                    function onVariableRenamed(index, name) {
                        if (model.flow) {
                            model.flow.setData(model.flow.index(index, 0), name, roles.name);
                        }
                    }
                }
            }

            ButtonGroup {
                id: mhg_initial_location_group
            }

        },

        ElementTab {

            id: edge_tab
            cellWidth: 700

            tab_name: "Edges"
            element_name: "Edge"

            add: function() {
                var jump = []
                for (var i = 0; i < mhg_models.variables.rowCount(); i++) {
                    jump.push({
                        variable: mhg_models.variables.data(mhg_models.variables.index(i, 0), roles.name),
                        lower_open: true,
                        upper_open: true,
                        lower: 0.0,
                        upper: 0.0
                    })
                }
                mhg_models.edges.appendRow({
                    source: "",
                    target: "",
                    guard: "",
                    agent: "",
                    action: "",
                    jump: jump
                });
            }

            model: mhg_models.edges
            delegate: Elements.Edge {
                width: edge_tab.cellWidth

                Connections {
                    target: mhg_game
                    function onActionRemoved(name) {
                        if (model.action == name) {
                            model.action = "";
                        }
                    }
                    function onAgentRemoved(name) {
                        if (model.agent == name) {
                            model.agent = "";
                        }
                    }
                    function onLocationRemoved(name) {
                        if (model.source == name) {
                            model.source = "";
                        }
                        if (model.target == name) {
                            model.target = "";
                        }
                    }
                    function onVariableAdded() {
                        model.jump.appendRow({variable: "", lower_open: true, upper_open: true, lower: 0.0, upper: 0.0});
                    }
                    function onVariableRemoved(index) {
                        model.jump.removeRow(index);
                    }
                    function onVariableRenamed(index, name) {
                        if (model.jump) {
                            model.jump.setData(model.jump.index(index, 0), name, roles.name);
                        }
                    }
                }
            }

        },

        Elements.TerminationConditions {

            id: termination_conditions_tab

        },

        ElementTab {

            id: query_tab
            cellWidth: 700

            tab_name: "Queries"
            element_name: "Query"

            add: function() {
                mhg_models.queries.appendRow({formula: ""});
            }

            model: mhg_models.queries
            delegate: Elements.Query {
                width: query_tab.cellWidth
            }

        }
    ]

    game_viewer: GameViewer {
        // TODO: add MHG viewer
        reset: function() {
            // Remove when MHG viewer is implemented
        }
    }

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
        // Reset view to show changes done in Julia 
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
        // Open query tab on successful verification
        query_tab.model = [];
        query_tab.model = mhg_models.queries;
        tab_bar.currentIndex = 6;
        tabs.currentIndex = 6;
    }

    // Signals to notify elements of removals and changes

    signal actionRemoved(string name)
    signal agentRemoved(string name)
    signal locationRemoved(string name)
    signal variableAdded()
    signal variableRemoved(int index)
    signal variableRenamed(int index, string name)

}
