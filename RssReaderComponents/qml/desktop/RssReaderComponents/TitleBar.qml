import QtQuick 1.0
import com.nokia.symbian 1.0
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
    height: 30

    // VKN TODO: GRADIENT TO BE DEFINED FROM OUTSIDE???
    gradient: Gradient {
        GradientStop { position: 0.0; color: Qt.rgba(71/255,136/255,71/255,1.0) }
        GradientStop { position: 0.6; color: Qt.rgba(104/255,164/255,78/255,1.0) }
        GradientStop { position: 1.0; color: Qt.rgba(78/255,124/255,64/255,1.0) }
    }

    Image {
        id: titleIcon
        source: parent.iconSource
        fillMode: "PreserveAspectFit"
        smooth: true
        height: container.height-margin
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
            right: parent.right
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
        horizontalAlignment: Text.AlignLeft
    }
}
