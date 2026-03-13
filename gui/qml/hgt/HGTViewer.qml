/**
* @file HGTViewer.qml
* @brief GUI component for a window dedicated to traversing a verified game tree of HGT games.
* @authors Moritz Maas
*/

import QtQml.Models
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import QtQuick.Shapes
import org.julialang

import ".."
import "../util"
import "nodes" as Nodes

GameViewer {

    id: hgt_viewer

    property alias branches: branches
    property int level: 1
    readonly property real time_line_width: 200
    readonly property real time_line_spacing: 20
    readonly property real node_width: 400
    readonly property real node_height: 300
    readonly property color passive_node_color: "#4664aa"
    readonly property color action_node_color: main_window.Material.theme === Material.Dark ? "#004f44" : '#00ceb2'
    readonly property color end_node_color: Material.color(Material.Red)
    readonly property color trigger_node_color: "#df9b1b"

    reset: function() {
        // Reset tree viewer to root
        level = 1;
        branches.model.clear();
    }

    set: function(i) {
        // Set tree viewer to query with index i
        Julia.hgt_set_tree(i);
        branches.model = [];
        branches.model = hgt_models.branches;
    }

    /**
    * Go up one level in the tree
    * @return   void
    */
    function up() {
        if (!Julia.hgt_up_tree()) {
            return;
        }
        branches.model = [];
        branches.model = hgt_models.branches;
        level = level - 1;
    }

    
    /**
    * Go down one level in the tree
    * @param    {number}    i - index of the branch to access
    * @param    {number}    j - index of the node in the branch to access
    * @return   void
    */
    function down(i, j) {
        if (!Julia.hgt_down_tree(i, j)) {
            return;
        }
        branches.model = [];
        branches.model = hgt_models.branches;
        level = level + 1;
    }

    Column {

        id: game_viewer_page
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Row {

            id: level_row
            width: parent.width
            height: parent_button.height
            spacing: 10
            
            Title {
                id: level_text
                height: parent.height
                text: qsTr("Level " + level)
                verticalAlignment: Text.AlignVCenter
            }

            Button {
                id: parent_button
                text: qsTr("Go up")
                onClicked: {
                    hgt_viewer.up();
                }
            }

        }

        Rectangle {

            width: game_viewer_page.width
            height: game_viewer_page.height - level_row.height - legend.height - 3 * parent.spacing

            color: Material.background
            border.width: 2
            border.color: Material.accent

            Item {

                anchors.fill: parent
                anchors.margins: 10
                anchors.topMargin: 40
                anchors.bottomMargin: 40

                Shape {
                    id: time_line
                    width: time_line_width
                    height: parent.height
                    anchors.left: parent.left

                    ShapePath {
                        strokeWidth: 5
                        strokeColor: main_window.Material.theme === Material.Dark ? "#ffffff" : "#000000"
                        startX: time_line_spacing
                        startY: -15
                        PathLine {
                            x: time_line_spacing
                            y: time_line.height + 15
                        }
                        PathLine {
                            x: time_line_spacing - 10
                            y: time_line.height + 5
                        }
                        PathLine {
                            x: time_line_spacing
                            y: time_line.height + 15
                        }
                        PathLine {
                            x: time_line_spacing + 10
                            y: time_line.height + 5
                        }
                        PathLine {
                            x: time_line_spacing
                            y: time_line.height + 15
                        }
                    }
                }

                // Branches of the current node
                ListView {
                    id: branches
                    width: parent.width
                    height: parent.height
                    anchors.left: parent.left
                    spacing: 10
                    clip: true
                    ScrollBar.vertical: ScrollBar {
                        policy: ScrollBar.AlwaysOn
                    }

                    model: hgt_models.branches
                    delegate: Column {
                        
                        id: branch_column
                        width: branches.width
                        spacing: 10

                        /**
                        * Go down one node in the current branch
                        * @param    {number}    i - index of the node in the branch to access
                        * @return   void
                        */
                        function down(i) {
                            hgt_viewer.down(index, i);
                        }

                        // Passive nodes in this branch
                        ListView {
                            id: passive_list
                            width: time_line_width + node_width
                            height: contentHeight
                            spacing: 5
                            clip: true

                            model: passive_nodes
                            delegate: Nodes.PassiveNode {
                                width: passive_list.width
                            }
                        }

                        Row {

                            width: parent.width
                            height: active_list.height
                            spacing: 10

                            Nodes.TriggerNode {
                                id: trigger_node
                                width: time_line_width + node_width
                                anchors.verticalCenter: parent.verticalCenter
                                agent: model.agent
                                trigger: model.trigger
                                time: model.time
                                visible: model.trigger != "" || action_nodes.rowCount() > 0
                            }

                            Title {
                                height: parent.height
                                text: qsTr("→")
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                visible: action_nodes.rowCount() > 0
                            }
                            
                            // Active nodes in this branch
                            ListView {
                                id: active_list
                                width: contentWidth
                                height: Math.max(node_height, trigger_node.height) 
                                spacing: 5
                                clip: true
                                interactive: false

                                orientation: ListView.Horizontal

                                model: action_nodes
                                delegate: Nodes.ActionNode {
                                    width: node_width
                                    height: parent.height
                                }
                            }

                        }

                    }
                    
                }

            }

        }

        Row {

            id: legend
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 20

            Rectangle {
                id: passive_legend
                width: 200
                height: parent_button.height
                radius: 5
                color: light_background_color
                border.color: passive_node_color
                border.width: 2
                
                Title {
                    text: qsTr("Passive node")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Rectangle {
                id: trigger_legend
                width: 200
                height: parent_button.height
                radius: 5
                color: light_background_color
                border.color: trigger_node_color
                border.width: 2
                
                Title {
                    text: qsTr("Trigger")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Rectangle {
                id: active_legend
                width: passive_legend.width
                height: parent_button.height
                radius: 5
                color: action_node_color
                border.color: Material.accent
                border.width: 2
                
                Title {
                    text: qsTr("Active node")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Rectangle {
                id: leaf_legend
                width: passive_legend.width
                height: parent_button.height
                radius: 5
                color: light_background_color
                border.color: end_node_color
                border.width: 2
                
                Title {
                    text: qsTr("End node")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

        }

    }

}
