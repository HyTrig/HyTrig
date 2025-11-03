import QtQml.Models
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import org.julialang

ApplicationWindow {

    id: window

    visible: true
    width: 1920
    minimumWidth: 1920
    maximumWidth: 1920
    height: 1080
    minimumHeight: 1080
    maximumHeight: 1080

    function has_name(name) {
        for (var i = 0; i < agents.agent_model.count; i++) {
            if (agents.agent_model.get(i).name === name)
                return true
        }
        for (var i = 0; i < actions.action_model.count; i++) {
            if (actions.action_model.get(i).name === name)
                return true
        }
        for (var i = 0; i < variables.variable_model.count; i++) {
            if (variables.variable_model.get(i).name === name)
                return true
        }
        for (var i = 0; i < locations.location_model.count; i++) {
            if (locations.location_model.get(i).name === name)
                return true
        }
        for (var i = 0; i < edges.edge_model.count; i++) {
            if (edges.edge_model.get(i).name === name)
                return true
        }
        return false
    }

    function get_variables() {
        var variables = []
        for (var i = 0; i < variables.variable_model.count; i++) {
            variables.push(variables.variable_model.get(i).name)
        }
        return variables
    }

    function get_locations() {
        var locations = []
        for (var i = 0; i < locations.location_model.count; i++) {
            if (locations.location_model.get(i).name != "") {
                locations.push(locations.location_model.get(i).name)
            }
        }
        return locations
    }

    Row {

        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Column {

            id: left_column
            width: (parent.width - 2 * parent.spacing - page_separator.width) / 2
            height: parent.height
            spacing: 20

            Row {

                width: parent.width
                spacing: 20
                
                Agents {
                    id: agents
                    width: (parent.width - parent.spacing) / 2
                }

                Actions {
                    id: actions
                    width: (parent.width - parent.spacing) / 2
                }

            }

            Rectangle {
                width: parent.width
                height: 5
                radius: 4
                color: "black"
            }

            Variables {
                id: variables
                width: parent.width
            }

            Rectangle {
                width: parent.width
                height: 5
                visible: agents.agent_model.count > 0
                radius: 4
                color: "black"
            }

            Triggers {
                id: triggers
                width: parent.width
                visible: agents.agent_model.count > 0
            }

            Rectangle {
                width: parent.width
                height: 5
                radius: 4
                color: "black"
            }

            TerminationConditions {
                id: terminations
                width: parent.width
            }

            Rectangle {
                width: parent.width
                height: 5
                radius: 4
                color: "black"
            }

        }

        Rectangle {
            id: page_separator
            width: 5
            height: parent.height
            radius: 4
            color: "black"
        }

        Column {

            width: (parent.width - 2 * parent.spacing - page_separator.width) / 2
            height: parent.height
            spacing: 20

            Locations {
                id: locations
                width: parent.width
            }

            Rectangle {
                width: parent.width
                height: 5
                radius: 4
                color: "black"
            }

            Edges {
                id: edges
                width: parent.width
            }

        }

    }

}
