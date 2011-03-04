import QtQuick 1.0
import "Util.js" as Util

Item {
    id: container
    // Feed model holds my subscriptions
    property alias expandedCategoryTitle: accordionList.expandedTitle
    property alias selectedCategoryTitle: accordionList.selectedTitle
    property alias selectedCategoryUrl: accordionList.selectedUrl
    property alias model: accordionList.model

    property string longTappedFeedName
    property string longTappedFeedUrl

    property string headerItemFontName: "Helvetica"
    property int headerItemFontSize: 12
    property color headerItemFontColor: "black"

    property string subItemFontName: "Helvetica"
    property int subItemFontSize: 10
    property color subItemFontColor: "black"

    // Signals emitted from this component
    signal feedSelected(string feedName)
    signal discoverFromCategory(string category);

    width: 360
    height: 640

    // Layout of the feed view.
    AccordionList {
        id: accordionList
        // Anchor so that fills up all the rest of the space above the searchfield
        anchors.fill: parent
        clip: true

        bgImage: visual.theme.images.listItem
        bgImageSelected: visual.theme.images.listItemSelected
        bgImagePressed: visual.theme.images.listItemPressed
        bgImageActive: visual.theme.images.listItemActive
        bgImageSubItem: visual.theme.images.listSubitem

        settingsIcon: visual.theme.images.settingsIcon
        arrow: visual.theme.images.arrow

        headerItemFontName: container.headerItemFontName
        headerItemFontSize: container.headerItemFontSize
        headerItemFontColor: container.headerItemFontColor

        subItemFontName: container.subItemFontName
        subItemFontSize: container.subItemFontSize
        subItemFontColor: container.subItemFontColor

        // model: feedListCategoriesModel
        onItemSelected: {
            container.feedSelected(title)
        }
        onDiscoveryClicked: {
            container.discoverFromCategory(title);
        }

        onItemLongTapped: {
            Util.log("Long tapped on "+title + ", url:" + url)
            longTappedFeedName = title
            longTappedFeedUrl = url
            unfollowPopUp.posX = mouseX
            unfollowPopUp.posY = mouseY
            unfollowPopUp.show = true
        }

        PopUp {
            id: unfollowPopUp
            text: "Unfollow"
            fontName:  container.subItemFontName
            fontColor: container.subItemFontColor
            fontSize: container.subItemFontSize
            onClicked: {
                model.removeFromCategory(expandedCategoryTitle, longTappedFeedUrl)
            }
        }
    }
}
