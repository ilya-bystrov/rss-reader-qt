import QtQuick 1.0
import "Util.js" as Util

Item {
    id: container

    property string fontName: "Helvetica"
    property int fontSize: 10
    property color fontColor: "black"
    property string itemTitle
    property string itemDescription
    property string itemUrl
    property string itemImageUrl
    property int scrollBarWidth: 8

    width: 360
    height: 640

    Flickable {
        id: flicker
        //anchors.fill: parent
        width: parent.width
        anchors.top:  parent.top
        anchors.bottom: buttonPart.top
        // Space between the bottom of the frame graphics and the button:
        anchors.bottomMargin: 14
        flickableDirection: "VerticalFlick"
        clip: true

        contentWidth: parent.width
        contentHeight: imagePart.height + textPart.height

        Image {
            id: imagePart
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                margins: 8
            }
            fillMode: Image.PreserveAspectFit
            source: itemImageUrl
            visible: itemImageUrl != ""
            onStatusChanged: {
                Util.log("image status "+status)
            }
        }

        /*
        WebView {
            id: textPart
            anchors {
                margins: 8
                top: imagePart.bottom
                left: parent.left
                right: parent.right
            }
            html: itemDescription

        }
        */

        Text {
            id: textPart
            anchors {
                margins: 8
                top: imagePart.bottom
                left: parent.left
                right: parent.right
            }
            font {
                family: container.fontName
                pointSize: container.fontSize
            }
            color: container.fontColor
            text: itemDescription
            wrapMode: Text.Wrap
            textFormat: Text.RichText
        }
    }

    ScrollBar { scrollArea: flicker; width: container.scrollBarWidth; anchors.top: flicker.top; anchors.right: flicker.right; anchors.bottom: flicker.bottom }

    Button {
        id: buttonPart
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
        width: parent.width
        height: 61
        text: qsTr("Read full article")
        fontName: container.fontName
        fontSize: container.fontSize
        fontColor: container.fontColor
        visible: itemUrl.length > 0

        onClicked: {
            Qt.openUrlExternally(itemUrl)
        }
    }

}
