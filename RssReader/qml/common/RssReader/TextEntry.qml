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
    property Component bg: defaultBackground
    property Component bgPressed: defaultPressedBackground
    property Component bgActive: defaultActiveBackground

    width: 140
    height: 60
    opacity: enabled ? 1.0 : 0.5    

    Loader {
        id: background
        sourceComponent: container.bg
        anchors.fill: parent
    }

    Component {
        id: defaultBackground
        BorderImage {
            border { top: 11; bottom: 40; left: 38; right: 38 }
            source: bgImage
        }
    }
    Component {
        id: defaultPressedBackground
        BorderImage {
            border { left: 38; top: 37; right: 38; bottom: 15 }
            source: bgImagePressed
        }
    }

    Component {
        id: defaultActiveBackground
        BorderImage {
            border { top: 11; bottom: 40; left: 38; right: 38; }
            source: bgImageActive
        }
    }

    TextInput {
        id: input
        text: ""

        anchors {
            topMargin: (container.height/2 - fontSize)
            fill: parent
            margins: 8
        }
        font {
            family: container.fontName
            pointSize: container.fontSize
        }
        horizontalAlignment: Text.AlignHCenter
        color: container.fontColor
        focus: parent.focus
        cursorVisible: parent.focus
    }



    states: [
        State {
            name: 'active'; when: input.focus
            PropertyChanges { target: background; sourceComponent: bgActive; }
        }
    ]
}
