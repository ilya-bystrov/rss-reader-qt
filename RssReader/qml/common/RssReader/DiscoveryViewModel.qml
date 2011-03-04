import QtQuick 1.0

import "Util.js" as Util

XmlListModel {
    id: model

    property string categoryTitle: ""
    property string url: ""

    // Where the feed discovery OPML is located.
    // Url property above is currently ignored.

    // The discovery.xml file is located on ruthenium in path:
    // /var/www/ruthenium.futurice.com/discovery.xml
    //source: "http://ruthenium.futurice.com:8080/discovery.xml"

    // Alternatively, use local:
    source: "discovery.xml"

    query: "/opml/body/outline[@title='" +  categoryTitle + "']/outline"

    XmlRole { name: "title"; query: "@title/string()" }
    XmlRole { name: "url"; query: "@xmlUrl/string()" }
    XmlRole { name: "iconUrl"; query: "@iconUrl/string()" }
    XmlRole { name: "description"; query: "description/string()" }

    onStatusChanged: {
        if (status == XmlListModel.Ready) {
            Util.log("DiscoveryModel status: ready")
        } else if (status == XmlListModel.Error) {
            Util.log("DiscoveryModel Status: error")
        } else if (status == XmlListModel.Loading) {
            Util.log("DiscoveryModel Status: loading")
        }
    }


}
