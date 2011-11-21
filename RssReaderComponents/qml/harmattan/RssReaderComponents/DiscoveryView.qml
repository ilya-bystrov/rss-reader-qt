import QtQuick 1.1
import com.nokia.meego 1.0
import "Util.js" as Util

Page {
    id: view

    // Display feeds belonging to this category
    property alias categoryTitle: listModel.categoryTitle
    property int itemHeight: 54

    property string fontName: "Helvetica"
    property int fontSize: 12
    property color fontColor: "black"

    width: 480
    height: 854

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

        MyListItem {
            property bool subscribed: categoryView.model.feedExists(url)

            text: title
            width: listView.width
            // ListItem is not selectable.
            icon: iconUrl
            fontName: view.fontName
            fontSize: view.fontSize
            fontColor: view.fontColor
            bgImage: visual.theme.images.listSubitem // Lighter than default gfx.
            nextArrowVisible: false
            onClicked: {
                if (subscribed) {
                    categoryView.model.removeFromCategory(categoryTitle, url)
                } else {
                    categoryView.model.addToCategory(categoryTitle, title, url)
                }
            }

            Image {
                id: star

                fillMode: "PreserveAspectFit"
                height: parent.height*0.5
                source: parent.subscribed ? visual.theme.images.favourited : visual.theme.images.notFavourited
                smooth: true
                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                    rightMargin: 10
                }
            }
        }
    }
}
