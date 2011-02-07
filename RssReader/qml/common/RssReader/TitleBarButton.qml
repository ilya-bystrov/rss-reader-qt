import QtQuick 1.0

Item {
    id: button

    property string buttonName: "NOT SET"
    property string text: ""

    property bool active: false
    property string bgImage: "gfx/exit_button.png"
    property string bgImagePressed: "gfx/exit_button_pressed.png"

    signal clicked(string button)

    width: 50
    height: 50

    opacity: enabled ? 1.0 : 0.5
    onActiveChanged: state = active ? '' :'active'

    Image {
        id: background
        source: bgImage;
        fillMode: "PreserveAspectFit"
        anchors.fill: parent
        smooth: true
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: button.clicked(buttonName);
    }

    states: [
        State {
            name: 'pressed'; when: mouseArea.pressed
            PropertyChanges { target: background; source: bgImagePressed; }
        }
    ]
}
