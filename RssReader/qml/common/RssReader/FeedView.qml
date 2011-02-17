import QtQuick 1.0
import "Util.js" as Util

Item {
    id: container

    property string fontName: "Helvetica"
    property int fontSize: 12
    property color fontColor: "black"
    property string itemTitle: ""
    property string itemDescription: ""
    property string itemUrl: ""
    property string itemImageUrl: ""

    property string feedName: ""
    property string feedUrl: ""

    property string filter: ""

    property int scrollBarWidth: 8
    property int spacing: 10

    signal feedItemSelected(string title)

    width: screenWidth
    height: screenHeight

    FeedViewModel {
        id: listModel
        feedUrl: container.feedUrl
        onLoadingChanged: appState.loading = listModel.loading
    }

    Component {
        id: listDelegate

        ListItem {
            text: title
            property bool filtered: title.match(new RegExp(textEntry.text,"i")) != null
            width: container.width
            height: filtered ? 64 : 0
            fontName: container.fontName
            fontSize: container.fontSize
            fontColor: container.fontColor
            bgImage: './gfx/list_subitem.png' // Lighter than default gfx.
            onClicked: {
                Util.log("Clicked on "+title + " "+enclosureUrl)
                container.itemTitle = title
                container.itemDescription = description
                container.itemUrl = url
                if(enclosureType.substring(0,5) == "image") {
                    container.itemImageUrl = enclosureUrl
                } else {
                    container.itemImageUrl = ""
                }
                feedItemSelected(title)
            }
        }
    }

    ListView {
        id: list

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: textEntry.top
            bottomMargin: 14
        }

        clip: true
        model: listModel
        delegate: listDelegate
        // Hide list until loading complete to avoid showing previously loaded
        // content.
        visible: !listModel.loading
    }

    TextEntry {
        id: textEntry
        width: parent.width
        height: 61
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
        text: ""
    }

    // ScrollBar indicator. Take the bottommost search field height into account.
    ScrollBar {
        id: scrollBar
        scrollArea: list
        height: list.height
        width: container.scrollBarWidth
        anchors.right: container.right
    }
}
