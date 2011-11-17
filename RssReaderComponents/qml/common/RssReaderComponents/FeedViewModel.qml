import QtQuick 1.1

import "Util.js" as Util

XmlListModel {
    id: model

    property string feedUrl: ""
    property bool loading: status == XmlListModel.Loading

    source: feedUrl
    query: "/rss/channel/item"
    XmlRole { name: "title"; query: "title/string()" }
    XmlRole { name: "description"; query: "description/string()" }
    XmlRole { name: "url"; query: "link/string()" }
    XmlRole { name: "enclosureUrl"; query: "enclosure/@url/string()" }
    XmlRole { name: "enclosureType"; query: "enclosure/@type/string()" }

    onStatusChanged: {
        if (status == XmlListModel.Ready) {
            Util.log("FeedViewModel Status: ready")
        } else if (status == XmlListModel.Error) {
            Util.log("FeedViewModel Status: error")
        } else if (status == XmlListModel.Loading) {
            Util.log("FeedViewModel Status: loading")
        }
    }

    onFeedUrlChanged: {
        Util.log("Feed url changed: "+feedUrl)
    }
}
