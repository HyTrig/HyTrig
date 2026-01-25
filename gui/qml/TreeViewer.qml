/**
* @file TreeWindow.qml
* @brief GUI component for a window dedicated to traversing a parsed game tree.
* @authors Moritz Maas
*/

import QtQml.Models
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import org.julialang

ApplicationWindow {

    id: tree_viewer
    width: 1500
    height: 1000
    minimumWidth: 1000
    minimumHeight: 800

    modality: Qt.ApplicationModal

    title: "Game tree viewer"

    Material.theme: window.Material.theme
    Material.accent: window.Material.accent
    Material.foreground: window.Material.foreground

    property alias branches: branches
    property int level: 1

    function up() {
        if (!Julia.up_tree()) {
            return;
        }
        branches.model = [];
        branches.model = models.branches;
        level = level - 1;
    }

    function down(i, j) {
        if (!Julia.down_tree(i, j)) {
            return;
        }
        branches.model = [];
        branches.model = models.branches;
        level = level + 1;
    }

    Column {

        id: tree_viewer_page
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Title {
            id: level_text
            width: parent.width
            text: "Level " + level
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        ListView {
            id: branches
            width: Math.min(contentWidth, tree_viewer_page.width)
            height: tree_viewer_page.height - level_text.height - legend.height - parent_button.height - 3 * parent.spacing
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10
            clip: true

            orientation: ListView.Horizontal

            model: branch_model
            delegate: Column {
                
                id: branch_column
                width: active_list.width
                height: branches.height
                spacing: 10
                function down(i) {
                    tree_viewer.down(index, i);
                }
                
                Label {
                    id: node_agent_text
                    width: parent.width
                    text: "Agent: " + model.agent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.Wrap
                }

                Label {
                    id: node_trigger_text
                    width: parent.width
                    text: "Trigger: " + model.trigger
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.Wrap
                }

                Label {
                    id: node_active_time_text
                    width: parent.width
                    text: "Time = " + model.time
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                ListView {
                    id: passive_list
                    width: parent.width
                    height: Math.min(contentHeight, branches.height - node_agent_text.height - node_trigger_text.height - node_active_time_text.height - active_list.height - 4 * parent.spacing)
                    spacing: 5
                    clip: true

                    model: passive_nodes
                    delegate: PassiveNode {}
                }
                
                ListView {
                    id: active_list
                    width: contentWidth
                    height: 300
                    spacing: 5
                    clip: true
                    interactive: false

                    orientation: ListView.Horizontal

                    model: active_nodes
                    delegate: ActiveNode {}
                }

            }
            
        }

        Row {

            id: legend
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 20

            Rectangle {
                id: active_legend
                width: passive_legend.width
                height: parent_button.height
                radius: 4
                color: Material.color(Material.Orange)
                
                Title {
                    text: "Active node"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Rectangle {
                id: passive_legend
                width: 200
                height: parent_button.height
                radius: 4
                color: Material.color(Material.Blue)
                
                Title {
                    text: "Passive node"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Rectangle {
                id: leaf_legend
                width: passive_legend.width
                height: parent_button.height
                radius: 4
                color: Material.color(Material.Orange, Material.Shade900)
                
                Title {
                    text: "End node"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

        }

        Button {

            id: parent_button
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Go up"
            
            onClicked: {
                tree_viewer.up();
            }

        }

    }

    onClosing: {
        while (Julia.up_tree()) {
            level = level - 1;
        }
        branches.model = [];
        branches.model = branch_model;
    }
    
}
