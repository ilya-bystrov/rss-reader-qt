import QtQuick 1.0

Item {
    id: container

    property string target: "NOT SET"
    property alias text: input.text
    property string fontName: "Helvetica"
    property int fontSize: 14
    property color fontColor: "black"
    property bool active: false
    property string bgImage: 'gfx/text_field.png'
    property string bgImagePressed: bgImageActive
    property string bgImageActive: 'gfx/button_pressed.png'

    width: 140
    height: 60
    opacity: enabled ? 1.0 : 0.5    

    Rectangle {
        anchors.fill: parent
        radius: 10
    }

    Image {
        id: icon

        height: input.height-6
        width: height
        source: visual.theme.images.searchIcon
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
            margins: 8
        }
        fillMode: Image.PreserveAspectFit
        smooth: true
        MouseArea {
            // Allow unfocus of text field here.
            anchors.fill: parent
            onClicked: list.focus = true
        }
    }

    TextInput {
        id: input
        text: ""

        anchors {
            //topMargin: (container.height/2 - fontSize)
            left: icon.right
            right: parent.right
            top: parent.top
            bottom: parent.bottom
            margins: 8
        }
        font {
            family: container.fontName
            pointSize: container.fontSize
        }
        horizontalAlignment: Text.AlignLeft
        color: container.fontColor
        focus: parent.focus
        cursorVisible: parent.focus
    }

    states: [
        State {
            name: 'active'; when: input.focus
            PropertyChanges { target: background; sourceComponent: bgActive; }
            PropertyChanges { target: container; active: true }
        }
    ]
}
