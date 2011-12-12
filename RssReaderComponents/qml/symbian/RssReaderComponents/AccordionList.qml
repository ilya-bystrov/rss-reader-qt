import QtQuick 1.1
import com.nokia.symbian 1.1
import "Util.js" as Util

Item {
    id: item

    property int animationDuration: 100
    property int indent: 20
    property int scrollBarWidth: 8
    property string expandedTitle: ""
    property string selectedTitle: ""
    property string selectedUrl: ""
    property alias model: mainModel

    property string bgImageSubItem: './gfx/list_subitem.png'
    property string bgImage: './gfx/list_item.png'
    property string bgImageSelected: './gfx/list_item_selected.png'
    property string bgImagePressed: './gfx/list_item_pressed.png'
    property string bgImageActive: './gfx/list_item_active.png'

    property string settingsIcon: './gfx/settings_icon.png'
    property string arrow: './gfx/arrow.png'
    property string moreIcon: './gfx/more.png'
    property string lessIcon: './gfx/less.png'

    property string headerItemFontName: "Helvetica"
    property int headerItemFontSize: 12
    property color headerItemFontColor: "black"

    property string subItemFontName: "Helvetica"
    property int subItemFontSize: 10
    property color subItemFontColor: "black"

    signal itemSelected(string title, string expandedCategory)
    signal itemLongTapped(string title, string url, int mouseX, int mouseY)
    signal discoveryClicked(string title)

    width: 360
    height: 640

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

    ScrollBar { flickableItem: listView; width: item.scrollBarWidth; anchors.top: listView.top; anchors.right: listView.right; anchors.bottom: listView.bottom; z: 100 }

    Component {
        id: listViewDelegate
        Item {
            id: container
            // Modify appearance from these properties
            property int itemHeight: visual.theme.accordionItemHeight
            property alias expandedItemCount: subItemRepeater.count

            // Flag to indicate if this delegate is expanded
            property bool expanded: false
            property string expandedCategoryTitle: categoryTitle

            x: 0; y: 0;
            width: parent.width
            height: headerItemRect.height + subItemsRect.height

            MyListItem {
                id: headerItemRect
                x: 0; y: 0
                width: parent.width
                height: parent.itemHeight
                text: categoryTitle
                icon: iconUrl ? iconUrl : ""
                bgImage: item.bgImage
                bgImageSelected: item.bgImageSelected
                bgImagePressed: item.bgImageSelected
                bgImageActive: item.bgImageActive
                fontName: item.headerItemFontName
                fontSize: item.headerItemFontSize
                fontColor: item.headerItemFontColor
                fontBold: true
                nextArrowVisible: false

                onClicked: {
                    Util.log("Clicked on " + categoryTitle + " at " +index);
                    container.expanded = !container.expanded
                    item.expandedTitle = categoryTitle
                }

                Image {
                    id: arrow
                    fillMode: "PreserveAspectFit"
                    height: parent.height*0.3
                    source: container.expanded ? item.lessIcon : item.moreIcon
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
                    // Animate subitem expansion. After the final height is reached,
                    // ensure that it is visible to the user.
                    SequentialAnimation {
                        NumberAnimation { duration: item.animationDuration; easing.type: Easing.InOutQuad }
                        ScriptAction { script: ListView.view.positionViewAtIndex(index, ListView.Contain) }
                    }
                }

                Column {
                    width: parent.width

                    Repeater {
                        id: subItemRepeater

                        model: attributes
                        width: subItemsRect.width

                        MyListItem {
                            id: subListItem

                            width: container.width
                            height: subItemsRect.itemHeight
                            text: categoryTitle
                            bgImage: item.bgImageSubItem
                            fontName: item.subItemFontName
                            fontSize: item.subItemFontSize
                            fontColor: item.subItemFontColor
                            // When the item is Manage/Discover button, alter
                            // the look a little.
                            textIndent: type == "discover" ? 0 : item.indent
                            icon: type == "discover" ? item.settingsIcon : ""
                            iconOpacity: type == "discover" ? 0.5 : 1.0
                            iconIndent: type == "discover" ? item.indent : 0
                            alignBottom: true
                            nextArrow: visual.theme.images.nextIcon

                            onPressAndHold: {
                                if (type == "discover") {
                                    // No action when longtapping this button.
                                } else {
                                    // Transform tap coordinates to parent coordinates first.
                                    var obj = parent.mapToItem(item, mouseX, y)
                                    item.itemLongTapped(categoryTitle, url, obj.x, obj.y+mouseY)
                                }
                            }
                            onClicked: {
                                item.selectedTitle = categoryTitle
                                item.selectedUrl = url
                                item.expandedTitle = expandedCategoryTitle

                                if (type == "discover") {
                                    Util.log("Clicked on discovery in " + expandedCategoryTitle);
                                    item.discoveryClicked(expandedCategoryTitle);
                                } else {
                                    Util.log("Clicked on subitem "+categoryTitle+ ", the expCatTitle was: "+expandedCategoryTitle)
                                    item.itemSelected(categoryTitle, expandedCategoryTitle)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
