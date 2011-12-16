import QtQuick 1.1
import com.nokia.symbian 1.1
import "Util.js" as Util

Page {
    id: container

    property string fontName: "Helvetica"
    property int fontSize: 12
    property int searchFontSize: 10
    property color fontColor: "black"
    property color searchFontColor: "black"
    property string itemTitle: ""
    property string itemDescription: ""
    property string itemUrl: ""
    property string itemImageUrl: ""

    property string feedName: ""
    property string feedUrl: ""

    property string filter: ""
    property string defaultText: ""


    property int scrollBarWidth: 8
    property int spacing: 10

    signal feedItemSelected(string title)

    width: 360
    height: 640

    FocusScope {

        anchors.fill: parent
        onOpacityChanged: if (listModel.loading) appState.loading = false

        FeedViewModel {
            id: listModel
            feedUrl: container.feedUrl
            onLoadingChanged: appState.loading = listModel.loading
        }

        Component {
            id: listDelegate

            MyListItem {

                property bool filtered: title.match(new RegExp(textEntry.text,"i")) != null

                hide: textEntry.inDefaultState ? false : (filtered ? false : true)
                text: title
                width: container.width

                fontName: container.fontName
                fontSize: container.fontSize
                fontColor: container.fontColor
                bgImage: visual.theme.images.listSubitem // Lighter than default gfx.
                nextArrow: visual.theme.images.nextIcon
                onClicked: {
                    Util.log("Clicked on "+title + " "+enclosureUrl)
                    list.focus = true // Unfocus text field
                    container.itemTitle = title
                    container.itemDescription = description
                    container.itemUrl = url
                    if (enclosureType.substring(0,5) == "image") {
                        container.itemImageUrl = enclosureUrl
                    } else {
                        container.itemImageUrl = ""
                    }
                    feedItemSelected(title)
                }
            }
        }

        TextEntry {
            id: textEntry

            property bool inDefaultState: textEntry.text == container.defaultText
            height: visual.theme.feedViewSearchBoxHeight

            bgImage: visual.theme.images.textField
            bgImageActive: visual.theme.images.buttonPressed
            bgColor: visual.theme.feedSearchBarBgColor

            fontName: container.fontName
            fontColor: container.searchFontColor
            fontSize: container.searchFontSize
            anchors {
                top: parent.top
                topMargin: 8
                left: parent.left
                right: parent.right
            }
            text: active ? "" : container.defaultText
        }

        ListView {
            id: list

            anchors {
                left: parent.left
                right: parent.right
                top: textEntry.bottom
                bottom: parent.bottom
                topMargin: 10
            }

            clip: true
            model: listModel
            delegate: listDelegate
            // Hide list until loading complete to avoid showing previously loaded
            // content.
            visible: !listModel.loading
            onMovementStarted: focus = true

            BorderImage {
                source: visual.theme.images.frame
                border { left: 8; top: 8; right: 8; bottom: 8 }
                anchors.fill: parent
            }
        }

        // ScrollBar indicator. Take the bottommost search field height into account.
        ScrollDecorator {
            id: scrollBar

            height: list.height
            width: container.scrollBarWidth
            platformInverted: appState.isInverted
            anchors.top: list.top
            anchors.right: parent.right
            flickableItem: list
        }

        function activationComplete() {
            // Clear textEntry focus on activation.
            list.focus = true
        }
    }
}
