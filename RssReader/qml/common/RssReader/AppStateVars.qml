import QtQuick 1.0

QtObject {
    property bool loading: false
    property bool showBackButton: false;
    property bool fromLeft: false
    property string currentViewName: ""
    property string cameFromView: ""
    // Contains the string currently shown
    property string currentTitle: ""
    // Populate this whenever you select a feed
    property string selectedFeedTitle: ""
    // Populate this whenever you select a feed item
    property string selectedFeedItemTitle: ""
}

