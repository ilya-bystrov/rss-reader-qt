import QtQuick 1.0
import "Util.js" as Util

Item {
    id: item
    width: 360
    height: 640

    property int animationDuration: 100
    property int indent: 20
    property int scrollBarWidth: 8
    property string expandedTitle:  ""
    property string selectedTitle: ""
    property string selectedUrl: ""
    property alias model: mainModel

    property string bgImageSubItem: "gfx/list_subitem.png"
    property string bgImage: 'gfx/list_item.png'
    property string bgImageSelected: 'gfx/list_item_selected.png'
    property string bgImagePressed: 'gfx/list_item_pressed.png'
    property string bgImageActive: 'gfx/list_item_active.png'

    property string headerItemFontName: "Helvetica"
    property int headerItemFontSize: 12
    property color headerItemFontColor: "black"

    property string subItemFontName: "Helvetica"
    property int subItemFontSize: 10
    property color subItemFontColor: "black"

    signal itemSelected(string title)
    signal itemLongTapped(string title, string url, int mouseX, int mouseY)
    signal discoveryClicked(string title)

    AccordionListModel {
        id: mainModel
    }

    ListView {
        id: listView
        height: parent.height
        anchors {
            left: parent.left
            right: parent.right
        }
        model: mainModel
        delegate: listViewDelegate
        focus: true
        spacing: 0
    }

    // ScrollBar indicator.
    ScrollBar {
        id: scrollBar
        scrollArea: listView
        height: listView.height
        width: container.scrollBarWidth
        anchors.right: item.right
    }

    Component {
        id: listViewDelegate
        Item {
            id: container
            // Modify appearance from these properties
            property int itemHeight: 64
            property alias expandedItemCount: subItemRepeater.count

            // Flag to indicate if this delegate is expanded
            property bool expanded: false

            x: 0; y: 0;
            width: parent.width
            height: headerItemRect.height + subItemsRect.height

            property string expandedCategoryTitle: categoryTitle

            ListItem {
                id: headerItemRect
                x: 0; y: 0
                width: parent.width
                //width: delegate.ListView
                height: parent.itemHeight
                text: categoryTitle
                icon: iconUrl ? iconUrl : ""
                onClicked: {
                    Util.log("Clicked on " + categoryTitle);
                    container.expanded = !container.expanded
                    item.expandedTitle = categoryTitle
                }
                bgImage: item.bgImage
                bgImageSelected: item.bgImageSelected
                bgImagePressed: item.bgImageSelected
                bgImageActive: item.bgImageActive
                fontName: item.headerItemFontName
                fontSize: item.headerItemFontSize
                fontColor: item.headerItemFontColor
                fontBold: true

                Image {
                    id: arrow
                    fillMode: "PreserveAspectFit"
                    height: parent.height*0.3
                    source: "gfx/arrow.png"
                    rotation: container.expanded ? 90 : 0
                    smooth: true
                    anchors {
                        right: parent.right
                        verticalCenter: parent.verticalCenter
                        rightMargin: 10
                    }
                }
            }

            Item {
                id: subItemsRect
                property int itemHeight: container.itemHeight-10

                y: headerItemRect.height
                width: parent.width
                height: parent.expanded ? parent.expandedItemCount * (itemHeight) : 0
                clip: true

                opacity: 1
                Behavior on height {
                    NumberAnimation {
                        duration: item.animationDuration
                        easing.type: Easing.InOutQuad
                    }
                }

                Column {
                    width: parent.width

                    Repeater {
                        id: subItemRepeater
                        model: attributes
                        width: subItemsRect.width

                        ListItem {
                            id: subListItem
                            width: container.width
                            height: subItemsRect.itemHeight
                            text: categoryTitle
                            fontName: item.subItemFontName
                            fontSize: item.subItemFontSize
                            fontColor: item.subItemFontColor
                            textIndent: item.indent
                            bgImage: item.bgImageSubItem
                            onPressAndHold: {
                                if(type == "discover") {
                                    // No action when longtapping this button.
                                } else {
                                    // Transform tap coordinats to parent coordinates first.
                                    var obj = parent.mapToItem(item, mouseX, mouseY)
                                    item.itemLongTapped(categoryTitle, url, obj.x, obj.y)
                                }
                            }
                            onClicked: {
                                item.selectedTitle = categoryTitle
                                item.selectedUrl = url

                                if(type == "discover") {
                                    Util.log("Clicked on discovery in " + expandedCategoryTitle);
                                    item.discoveryClicked(expandedCategoryTitle);
                                } else {
                                    Util.log("Clicked on subitem "+categoryTitle)
                                    item.itemSelected(categoryTitle)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
