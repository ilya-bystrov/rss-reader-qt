import QtQuick 1.1
import com.nokia.symbian 1.1
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

    // The start and stop colors for the current gradient.
    property color currentGradientStart: mainGradientStart
    property color currentGradientEnd: mainGradientEnd

    // Gradient color definitions.
    property color mainGradientStart: Qt.rgba(104/255,164/255,78/255,1.0)
    property color mainGradientEnd: Qt.rgba(78/255,124/255,64/255,1.0)
    property color newsGradientStart: Qt.rgba(99/255,196/255,205/255,1.0)
    property color newsGradientEnd: Qt.rgba(14/255,121/255,145/255,1.0)
    property color entertainmentGradientStart: Qt.rgba(214/255,103/255,165/255,1.0)
    property color entertainmentGradientEnd: Qt.rgba(153/255,23/255,117/255,1.0)
    property color sportsGradientStart: Qt.rgba(124/255,90/255,142/255,1.0)
    property color sportsGradientEnd: Qt.rgba(81/255,48/255,125/255,1.0)
    property color techGradientStart: Qt.rgba(236/255,154/255,67/255,1.0)
    property color techGradientEnd: Qt.rgba(159/255,63/255,41/255,1.0)

    signal exitButtonClicked
    signal backButtonClicked(string viewName)

    // Default values, change when using
    width: 360
    height: 30

    gradient: Gradient {
        GradientStop {
            id: startGrad
            position: 0.0;
            color: container.currentGradientStart
            Behavior on color {
                ColorAnimation {
                    duration: visual.generalTransitionTime
                }
            }
        }
        GradientStop {
            id: endGrad
            position: 1.0;
            color: container.currentGradientEnd
            Behavior on color {
                ColorAnimation {
                    duration: visual.generalTransitionTime
                }
            }
        }
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
