import QtQuick 1.0
import "Util.js" as Util

FocusScope {
    id: container

    property string fontName: visual.defaultFontFamily
    property int fontSize: visual.defaultFontSize
    property color fontColor: visual.defaultFontColor
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
                list.focus = true // Unfocus text field
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
            bottom: icon.top
            bottomMargin: 24
        }

        clip: true
        model: listModel
        delegate: listDelegate
        // Hide list until loading complete to avoid showing previously loaded
        // content.
        visible: !listModel.loading
        onMovementStarted: focus = true
    }

    TextEntry {
        id: textEntry
        height: 61
        fontName: container.fontName
        fontColor: container.fontColor
        fontSize: container.fontSize
        anchors {
            leftMargin: 8
            bottom: parent.bottom
            left: icon.horizontalCenter
            right: parent.right
        }
        text: ""
    }

    Image {
        id: icon
        source: 'gfx/search_icon.png'
        anchors {
            left: parent.left
            bottom: parent.bottom
        }
        anchors.margins: 8
        fillMode: Image.PreserveAspectFit
        smooth: true
        MouseArea {
            // Allow unfocus of text field here.
            anchors.fill: parent
            onClicked: list.focus = true
        }
    }

    // ScrollBar indicator. Take the bottommost search field height into account.
    ScrollBar {
        id: scrollBar
        scrollArea: list
        height: list.height
        width: container.scrollBarWidth
        anchors.right: container.right
    }

    function activationComplete() {
        // Clear textEntry focus on activation.
        list.focus = true
    }
}
