import QtQuick 1.0
import com.nokia.meego 1.0
import "Components.js" as Util

Rectangle {
    id: container

    property bool showingBackButton: false
    property int margin: 8
    property string iconSource: "gfx/placeholder_icon.png"
    property string backButtonSource: "gfx/back_button.png"
    property string backButtonPressedSource: "gfx/back_button_pressed.png"
    property string exitButtonSource: "gfx/exit_button.png"
    property string exitButtonPressedSource: "gfx/exit_button_pressed.png"
    property string text: "TITLE"
    property string fontName: "Helvetica"
    property int fontSize: 24
    property color fontColor: "black"
    property bool fontBold: false
    property bool exitButtonVisible: true

    signal exitButtonClicked
    signal backButtonClicked(string viewName)

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
            right: backButton.left
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

    // In Harmattan / Meego we are only showing the back button.
    // Also, there's no need to show the exit button.
//    Button {
//        id: exitButton
//        visible: !showingBackButton

//        anchors.top: container.top
//        anchors.right: container.right
//        anchors.margins: container.margin
//        width: container.height
//        height: container.height

//        iconSource: pressed ? container.exitButtonPressedSource : container.exitButtonSource
//        enabled: container.exitButtonVisible

//        onClicked: {
//            container.exitButtonClicked()
//        }
//    }

    Button {
        id: backButton

        visible: container.showingBackButton
        anchors.top: container.top
        anchors.right: container.right
        anchors.margins: container.margin
        width: container.height-2
        height: container.height-2

        iconSource: pressed ? container.backButtonPressedSource : container.backButtonSource

        onClicked: {
            container.backButtonClicked(appState.currentViewName)
        }
    }
}
