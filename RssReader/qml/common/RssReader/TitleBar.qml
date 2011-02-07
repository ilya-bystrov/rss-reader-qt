import QtQuick 1.0
import "Components.js" as Util

Rectangle {
    id: container

    signal exitButtonClicked
    signal backButtonClicked(string viewName)

    property bool showingBackButton: false
    property int margin: 8

    property string iconSource: "gfx/placeholder_icon.png"
    property string text: "TITLE"
    property string fontName: "Helvetica"
    property int fontSize: 24
    property color fontColor: "black"
    property bool fontBold: false

    // Default values, change when using
    width: 360
    height: 80
    color: "lightgray"

    Image {
        id: titleIcon
        source: parent.iconSource
        fillMode: "PreserveAspectFit"
        smooth: true
        height: container.height-2*margin
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
            margins: container.margin
        }
    }

    Text {
        id: titleText
        smooth: true
        clip: true
        anchors {
            top: titleIcon.top
            bottom: titleIcon.bottom
            left: titleIcon.right
            right: exitButton.left
            leftMargin: container.margin
            rightMargin: container.margin
        }
        color: container.fontColor

        font {
            bold: container.fontBold
            family: container.fontName
            pointSize: container.fontSize
        }

        text: container.text
        elide: Text.ElideLeft
        textFormat: Text.RichText
        wrapMode: Text.Wrap
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    TitleBarButton {
        id: exitButton
        visible: !showingBackButton        
        width: container.height
        height: container.height
        scale: 0.8
        anchors.top: container.top
        anchors.right: container.right
        anchors.margins: 0
        //x: parent.width - width - y
        bgImage: "gfx/exit_button.png"
        bgImagePressed: "gfx/exit_button_pressed.png";

        onClicked: {
            container.exitButtonClicked()
        }
    }

    TitleBarButton {
        visible: showingBackButton
        y: 10
        anchors.top: container.top
        anchors.right: container.right
        anchors.margins: 0
        width: container.height
        height: container.height
        scale: 0.8
        //x: parent.width - width - y
        bgImage: "gfx/back_button.png"
        bgImagePressed: "gfx/back_button_pressed.png";

        onClicked: {
            container.backButtonClicked(appState.currentViewName)
        }
    }
}
