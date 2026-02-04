/**
* @file qml
* @brief Hybrid Games with Triggers type of game in the HyTrig GUI
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

    game_type_name: "HGT"

    tab_names: ListModel {
        ListElement { name: "Agents" }
        ListElement { name: "Actions" }
        ListElement { name: "Variables" }
        ListElement { name: "Triggers" }
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
                hgt_models.agents.appendRow({name: ""});
            }

            model: hgt_models.agents
            delegate: Elements.Agent {
                width: agent_tab.cellWidth
            }

        },

        ElementTab {

            id: action_tab

            tab_name: "Actions"
            element_name: "Action"

            add: function() {
                hgt_models.actions.appendRow({name: ""});
            }

            model: hgt_models.actions
            delegate: Elements.Action {
                width: action_tab.cellWidth
            }

        },

        ElementTab {

            id: variable_tab

            tab_name: "Variables"
            element_name: "Variable"

            add: function() {
                hgt_models.variables.appendRow({name: "", expression: ""});
                variableAdded();
            }

            model: hgt_models.variables
            delegate: Elements.Variable {
                width: variable_tab.cellWidth
            }

        },

        ElementTab {

            id: trigger_tab

            tab_name: "Triggers"
            element_name: "Trigger"

            add: function() {
                hgt_models.triggers.appendRow({agent: "", trigger: ""})
            }

            model: hgt_models.triggers
            delegate: Elements.Trigger {
                width: trigger_tab.cellWidth
                
                Connections {
                    target: hgt_game
                    function onAgentRemoved(name) {
                        if (model.agent == name) {
                            model.agent = "";
                        }
                    }
                }
            }

        },

        ElementTab {

            id: location_tab
            cellWidth: 700

            tab_name: "Locations"
            element_name: "Location"

            add: function() {
                var flow = []
                for (var i = 0; i < hgt_models.variables.rowCount(); i++) {
                    flow.push({
                        variable: hgt_models.variables.data(hgt_models.variables.index(i, 0), roles.name),
                        expression: hgt_models.variables.data(hgt_models.variables.index(i, 0), roles.name)
                    })
                }
                hgt_models.locations.appendRow({
                    name: "",
                    initial: hgt_models.locations.rowCount() == 0,
                    invariant: "",
                    flow: flow
                });
            }

            model: hgt_models.locations
            delegate: Elements.Location {
                width: location_tab.cellWidth

                Connections {
                    target: hgt_game
                    function onVariableAdded() {
                        model.flow.appendRow({variable: "", expression: "0"});
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
                id: hgt_initial_location_group
            }

        },

        ElementTab {

            id: edge_tab
            cellWidth: 700

            tab_name: "Edges"
            element_name: "Edge"

            add: function() {
                var jump = []
                for (var i = 0; i < hgt_models.variables.rowCount(); i++) {
                    jump.push({
                        variable: hgt_models.variables.data(hgt_models.variables.index(i, 0), roles.name),
                        expression: hgt_models.variables.data(hgt_models.variables.index(i, 0), roles.name)
                    })
                }
                hgt_models.edges.appendRow({
                    source: "",
                    target: "",
                    guard: "",
                    agent: "",
                    action: "",
                    jump: jump
                });
            }

            model: hgt_models.edges
            delegate: Elements.Edge {
                width: edge_tab.cellWidth

                Connections {
                    target: hgt_game
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
                        model.jump.appendRow({variable: "", expression: ""});
                    }
                    function onVariableRemoved(index) {
                        model.jump.removeRow(index);
                    }
                    function onVariableRenamed(index, name) {
                        if (model.jump) {
                            if (model.jump.data(model.jump.index(index, 0), roles.name) == model.jump.data(model.jump.index(index, 0), roles.expression)) {
                                model.jump.setData(model.jump.index(index, 0), name, roles.expression);
                            }
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
                hgt_models.queries.appendRow({formula: ""});
            }

            model: hgt_models.queries
            delegate: Elements.Query {
                width: query_tab.cellWidth
            }

        }
    ]

    clear: function () {
        hgt_models.agents.clear();
        hgt_models.actions.clear();
        hgt_models.variables.clear();
        hgt_models.triggers.clear();
        hgt_models.locations.clear();
        hgt_models.edges.clear();
        hgt_models.queries.clear();
        hgt_models.max_steps = "";
        hgt_models.time_bound = "";
        hgt_models.state_formula = "";
        verified = false;
    }

    save: function (file) {
        Julia.hgt_save(file);
    }

    load: function (file) {
        var error = Julia.hgt_load(file);
        current_file = file;
        // Reset view to show changes done in Julia 
        action_tab.model = [];
        action_tab.model = hgt_models.actions;
        tabs.currentIndex = 0;
        agent_tab.model = [];
        agent_tab.model = hgt_models.agents;
        tabs.currentIndex = 1;
        variable_tab.model = [];
        variable_tab.model = hgt_models.variables;
        tabs.currentIndex = 2;
        trigger_tab.model = [];
        trigger_tab.model = hgt_models.triggers;
        tabs.currentIndex = 3;
        location_tab.model = [];
        location_tab.model = hgt_models.locations;
        tabs.currentIndex = 4;
        edge_tab.model = [];
        edge_tab.model = hgt_models.edges;
        tabs.currentIndex = 5;
        termination_conditions_tab.max_steps.editingFinished();
        termination_conditions_tab.time_bound.editingFinished();
        termination_conditions_tab.state_formula.editingFinished();
        tabs.currentIndex = 6;
        query_tab.model = [];
        query_tab.model = hgt_models.queries;
        tabs.currentIndex = 7;
        tabs.currentIndex = tab_bar.currentIndex;
        verified = false;
        return error;
    }

    verify: function () {
        return Julia.hgt_verify();
    }

    verification_success: function () {
        // Open query tab on successful verification
        query_tab.model = [];
        query_tab.model = hgt_models.queries;
        tab_bar.currentIndex = 7;
        tabs.currentIndex = 7;
    }

    // Signals to notify elements of removals and changes

    signal actionRemoved(string name)
    signal agentRemoved(string name)
    signal locationRemoved(string name)
    signal variableAdded()
    signal variableRemoved(int index)
    signal variableRenamed(int index, string name)

}
