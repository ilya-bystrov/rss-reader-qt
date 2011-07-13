import QtQuick 1.0
import com.nokia.symbian 1.0
import "Util.js" as Util

Page {
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
                text: title
                property bool filtered: title.match(new RegExp(textEntry.text,"i")) != null
                width: container.width
                height: filtered ? 54 : 0
                fontName: container.fontName
                fontSize: container.fontSize
                fontColor: container.fontColor
                bgImage: visual.theme.images.listSubitem // Lighter than default gfx.
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

            bgImage: visual.theme.images.textField
            bgImageActive: visual.theme.images.buttonPressed

            fontName: container.fontName
            fontColor: container.fontColor
            fontSize: container.fontSize
            anchors {
                leftMargin: 8
                bottom: parent.bottom
                left: icon.right
                right: parent.right
            }
            text: ""
        }

        Image {
            id: icon
            source: visual.theme.images.searchIcon
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
            flickableItem: list
            height: list.height
            width: container.scrollBarWidth
            anchors.right: parent.right
        }

        function activationComplete() {
            // Clear textEntry focus on activation.
            list.focus = true
        }
    }
}
