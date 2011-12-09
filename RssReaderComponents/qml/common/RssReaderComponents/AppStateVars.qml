import QtQuick 1.1

QtObject {
    property bool loading: false
    property bool showBackButton: false
    property bool fromLeft: false
    property string currentViewName: ""
    property string cameFromView: ""
    // Contains the string currently shown
    property string currentTitle: qsTr("RSS Reader")
    // Populate this whenever you select a feed
    property string selectedFeedTitle: ""
    // Populate this whenever you select a feed item
    property string selectedFeedItemTitle: ""
    // theme-dir name
    property string themeDir: ""
    property bool isInverted: false
    // Current titlebar bg gradient
    property variant currentGradient: visual.item.mainGradient
    // URL to the RSS feed item
    property string rssItemUrl: ""
}

