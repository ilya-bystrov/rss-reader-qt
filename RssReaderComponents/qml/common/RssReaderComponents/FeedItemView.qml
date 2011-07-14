import QtQuick 1.0
import com.nokia.symbian 1.0
import "Util.js" as Util

Page {
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
        width: parent.width
        anchors.top:  parent.top
        anchors.bottom: buttonPart.top
        // Space between the bottom of the frame graphics and the button:
        anchors.bottomMargin: 14
        flickableDirection: "VerticalFlick"
        clip: true

        contentWidth: parent.width
        contentHeight: imagePart.height + textPart.height

        Text {
            id: titleText
            text: appState.selectedFeedItemTitle
            anchors {
                margins: 8
                top: parent.top
                left: parent.left
                right: parent.right
            }
            font {
                family: container.fontName
                pointSize: container.fontSize
                bold: true
            }
            color: container.fontColor
            wrapMode: Text.Wrap
            textFormat: Text.RichText
        }

        Image {
            id: imagePart
            anchors {
                top: titleText.bottom
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

    ScrollBar { flickableItem: flicker; width: container.scrollBarWidth; anchors.top: flicker.top; anchors.right: flicker.right; anchors.bottom: flicker.bottom }

    Button {
        id: buttonPart

        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
        visible: itemUrl.length > 0
        width: parent.width
        height: 61
        text: qsTr("Read full article")

        font {
            family: container.fontName
            pointSize: container.fontSize
        }

        onClicked: {
            Qt.openUrlExternally(itemUrl)
        }
    }
}
