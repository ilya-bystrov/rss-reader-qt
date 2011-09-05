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

    // Gradient definitions
    property variant mainGradient: Gradient {
        GradientStop { position: 0.0; color: Qt.rgba(71/255,136/255,71/255,1.0) }
        GradientStop { position: 0.6; color: Qt.rgba(104/255,164/255,78/255,1.0) }
        GradientStop { position: 1.0; color: Qt.rgba(78/255,124/255,64/255,1.0) }
    }
    property variant newsGradient: Gradient {
        GradientStop { position: 0.0; color: Qt.rgba(99/255,196/255,205/255,1.0) }
        GradientStop { position: 1.0; color: Qt.rgba(14/255,121/255,145/255,1.0) }
    }
    property variant entertainmentGradient: Gradient {
        GradientStop { position: 0.0; color: Qt.rgba(214/255,103/255,165/255,1.0) }
        GradientStop { position: 1.0; color: Qt.rgba(153/255,23/255,117/255,1.0) }
    }
    property variant sportsGradient: Gradient {
        GradientStop { position: 0.0; color: Qt.rgba(124/255,90/255,142/255,1.0) }
        GradientStop { position: 1.0; color: Qt.rgba(81/255,48/255,125/255,1.0) }
    }
    property variant techGradient: Gradient {
        GradientStop { position: 0.0; color: Qt.rgba(236/255,154/255,67/255,1.0) }
        GradientStop { position: 1.0; color: Qt.rgba(159/255,63/255,41/255,1.0) }
    }

    signal exitButtonClicked
    signal backButtonClicked(string viewName)

    // Default values, change when using
    width: 360
    height: 30

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
