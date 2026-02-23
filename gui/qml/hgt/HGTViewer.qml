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
import org.julialang

import ".."
import "../util"
import "elements" as Elements

GameViewer {

    id: hgt_viewer

    property alias branches: branches
    property int level: 1

    reset: function() {
        // Reset tree viewer to root
        while (Julia.hgt_up_tree()) {
            level = level - 1;
        }
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

        Title {
            id: level_text
            width: parent.width
            text: qsTr("Level " + level)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        // Branches of the current node
        ListView {
            id: branches
            width: game_viewer_page.width
            height: game_viewer_page.height - level_text.height - legend.height - parent_button.height - 3 * parent.spacing
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10
            clip: true
            ScrollBar.vertical: ScrollBar {}

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
                    width: 400
                    height: contentHeight
                    spacing: 5
                    clip: true

                    model: passive_nodes
                    delegate: Elements.PassiveNode {
                        width: passive_list.width
                    }
                }

                Row {

                    width: parent.width
                    height: active_list.height
                    spacing: 10

                    Elements.TriggerNode {
                        width: 400
                        height: active_list.height
                        agent: model.agent
                        trigger: model.trigger
                        time: model.time
                    }

                    Title {
                        height: parent.height
                        text: qsTr("→")
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    
                    // Active nodes in this branch
                    ListView {
                        id: active_list
                        width: contentWidth
                        height: 300
                        spacing: 5
                        clip: true
                        interactive: false

                        orientation: ListView.Horizontal

                        model: active_nodes
                        delegate: Elements.ActiveNode {
                            width: 300
                            height: parent.height
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
                id: active_legend
                width: passive_legend.width
                height: parent_button.height
                radius: 4
                color: Material.color(Material.Orange)
                
                Title {
                    text: qsTr("Active node")
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
                    text: qsTr("Passive node")
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
                    text: qsTr("End node")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

        }

        Button {

            id: parent_button
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Go up")
            
            onClicked: {
                hgt_viewer.up();
            }

        }

    }
    
}
