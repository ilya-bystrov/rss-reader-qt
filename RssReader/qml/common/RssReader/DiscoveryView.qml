import QtQuick 1.0
import "Util.js" as Util

Item {
    id: view
    width: screenWidth
    height: screenHeight

    // Display feeds belonging to this category
    property alias categoryTitle: listModel.categoryTitle
    property alias discoveryUrl: listModel.url
    property int itemHeight: 50

    property string fontName: "Helvetica"
    property int fontSize: 12
    property color fontColor: "black"

    DiscoveryViewModel {
        id:listModel
    }

    ListView {
        id: listView
        anchors.fill: parent        
        clip: true
        delegate: listDelegate
        model: listModel
    }

    Component {
        id: listDelegate

        ListItem {
            property bool subscribed: categoryView.model.feedExists(url)
            text: title
            width: listView.width
            // ListItem is not selectable.
            icon: iconUrl
            fontName: view.fontName
            fontSize: view.fontSize
            fontColor: view.fontColor
            bgImage: './gfx/list_subitem.png' // Lighter than default gfx.
            onClicked: {
                if(subscribed) {
                    categoryView.model.removeFromCategory(categoryTitle, url)
                } else {
                    categoryView.model.addToCategory(categoryTitle, title, url)
                }
            }           
            Image {
                id: star
                fillMode: "PreserveAspectFit"
                height: parent.height*0.5
                source: parent.subscribed ? "gfx/favourited.png" : "gfx/favourited_not.png"
                smooth: true
                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                    rightMargin: 10
                }
            }
        }
    }

    Component.onCompleted: {
        Util.log("DiscoveryView completed")
    }
}

