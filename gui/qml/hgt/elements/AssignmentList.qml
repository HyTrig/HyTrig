/**
* @file AssignmentList.qml
* @brief GUI component for the flow of a location or the jump of an edge of the HyTrig GUI
* @authors
*/

import org.julialang
import QtQml
import QtQuick
import QtQuick.Controls.Material

import "../../util"

Column {

    // Item model of the assignments with roles variable and expression, in the order they are applied
    required property var assignments

    required property string title
    // Kind of assignment used in texts, e.g. "flow" or "jump"
    required property string kind
    // Text displayed when no variable is assigned
    required property string empty_text

    property real selector_width: 150

    // Names of the variables that are assigned, each variable can only be assigned once
    property var used_variables: []

    id: assignment_list

    function update_used_variables() {
        var names = [];
        if (assignments) {
            for (var i = 0; i < assignments.rowCount(); i++) {
                names.push(assignments.data(assignments.index(i, 0), roles.variable));
            }
        }
        used_variables = names;
    }

    function first_unused_variable() {
        for (var i = 0; i < hgt_models.variables.rowCount(); i++) {
            var name = hgt_models.variables.data(hgt_models.variables.index(i, 0), roles.name);
            if (used_variables.indexOf(name) < 0) {
                return name;
            }
        }
        return "";
    }

    function add_assignment() {
        var name = first_unused_variable();
        if (name != "") {
            assignments.appendRow({variable: name, expression: ""});
            update_used_variables();
        }
    }

    function remove_assignment(i) {
        assignments.removeRow(i);
        update_used_variables();
    }

    function move_assignment(from, to) {
        if (0 <= to && to < assignments.rowCount()) {
            assignments.moveRow(from, to, 1);
        }
    }

    function set_variable(i, name) {
        assignments.setData(assignments.index(i, 0), name, roles.variable);
        update_used_variables();
    }

    onAssignmentsChanged: {
        update_used_variables();
    }

    Component.onCompleted: {
        update_used_variables();
    }

    // Keeps track of the number of variables to know whether another one can be added
    Instantiator {
        id: variable_counter
        model: hgt_models.variables
        delegate: QtObject {}
    }

    Row {

        width: parent.width
        height: Material.textFieldHeight
        spacing: 5

        Title {
            width: parent.width - add_button.width - parent.spacing
            height: parent.height
            text: qsTr(assignment_list.title)
            font.pointSize: 20
        }

        Button {
            id: add_button
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr("Add Variable")
            enabled: assignment_list.used_variables.length < variable_counter.count
            Material.foreground: "#ffffff"
            Material.background: hovered ? Material.accent : Material.primary
            onClicked: {
                add_assignment();
            }
        }

    }

    Label {
        width: parent.width
        visible: assignment_view.count == 0
        text: qsTr(assignment_list.empty_text)
        color: Material.hintTextColor
        wrapMode: Text.WordWrap
    }

    ListView {

        id: assignment_view
        width: parent.width
        height: contentHeight
        clip: true
        interactive: false

        model: assignments
        delegate: Row {

            required property var model
            required property int index

            id: assignment_row
            width: assignment_view.width
            height: expression_field.height + expression_field.topInset
            spacing: 10

            Selector {
                id: variable_selector
                width: assignment_list.selector_width
                anchors.verticalCenter: parent.verticalCenter

                model: hgt_models.variables
                textRole: "name"
                valueRole: "name"

                // Depend on count to find the variable again when variables are added or removed
                currentIndex: {
                    count;
                    return find(assignment_row.model.variable);
                }

                // Variables that are already assigned in another row cannot be selected
                delegate: MenuItem {
                    required property var model
                    required property int index

                    width: ListView.view.width
                    text: model.name
                    enabled: index == variable_selector.currentIndex || assignment_list.used_variables.indexOf(model.name) < 0
                    Material.foreground: variable_selector.currentIndex === index ? ListView.view.contentItem.Material.accent : ListView.view.contentItem.Material.foreground
                    highlighted: variable_selector.highlightedIndex === index
                    hoverEnabled: variable_selector.hoverEnabled
                }

                action: function(x) {
                    assignment_list.set_variable(assignment_row.index, x);
                }
            }

            RegexField {
                id: expression_field
                width: parent.width - variable_selector.width - up_button.width - down_button.width - remove_button.width - 4 * parent.spacing
                topInset: 10

                text: qsTr(assignment_row.model.expression)
                default_text: qsTr("Enter " + assignment_list.kind + " expression")
                error_text: qsTr("Invalid " + assignment_list.kind + " expression")
                condition_error_text: qsTr("Invalid " + assignment_list.kind + " expression")

                regex: /^.*$/

                action: function(x) {
                    assignment_row.model.expression = x;
                }
                condition: function(x) {
                    return Julia.hgt_is_formula(x, "expression");
                }
                error_value: text

                Connections {
                    target: hgt_game
                    function onVariableRenamed(index, name) {
                        expression_field.textChanged();
                        expression_field.editingFinished();
                    }
                    function onVariableRemoved(index) {
                        expression_field.textChanged();
                        expression_field.editingFinished();
                    }
                }
            }

            ToolButton {
                id: up_button
                anchors.verticalCenter: parent.verticalCenter
                text: "▲"
                enabled: assignment_row.index > 0
                ToolTip.visible: hovered
                ToolTip.delay: 500
                ToolTip.text: qsTr("Move up")
                onClicked: {
                    assignment_list.move_assignment(assignment_row.index, assignment_row.index - 1);
                }
            }

            ToolButton {
                id: down_button
                anchors.verticalCenter: parent.verticalCenter
                text: "▼"
                enabled: assignment_row.index < assignment_view.count - 1
                ToolTip.visible: hovered
                ToolTip.delay: 500
                ToolTip.text: qsTr("Move down")
                onClicked: {
                    assignment_list.move_assignment(assignment_row.index, assignment_row.index + 1);
                }
            }

            Button {
                id: remove_button
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Remove")
                onClicked: {
                    assignment_list.remove_assignment(assignment_row.index);
                }
            }

        }

    }

    Connections {
        target: hgt_game
        function onVariableRemoved(index, name) {
            if (!assignments) {
                return;
            }
            for (var i = assignments.rowCount() - 1; i >= 0; i--) {
                if (assignments.data(assignments.index(i, 0), roles.variable) == name) {
                    assignments.removeRow(i);
                }
            }
            update_used_variables();
        }
        function onVariableRenamed(index, name, old_name) {
            if (!assignments || name == old_name) {
                return;
            }
            for (var i = 0; i < assignments.rowCount(); i++) {
                var row = assignments.index(i, 0);
                if (assignments.data(row, roles.variable) == old_name) {
                    // Keep identity assignments such as x := x up to date
                    if (assignments.data(row, roles.expression) == old_name) {
                        assignments.setData(row, name, roles.expression);
                    }
                    assignments.setData(row, name, roles.variable);
                }
            }
            update_used_variables();
        }
    }

}
