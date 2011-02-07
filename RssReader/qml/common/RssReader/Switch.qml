import QtQuick 1.0

Item {
    id: container
    signal switched(bool position)
    property string imageOn: 'gfx/switch_on.png'
    property string imageOff: 'gfx/switch_off.png'
    property bool switchedOn: true
    width: 98
    height: 44
    Image {
        id: toggleSwitch
        source: switchedOn ? imageOn : imageOff
        fillMode: Image.PreserveAspectFit
        smooth: true
        anchors.fill: parent
    }

    MouseArea {
        anchors.fill: parent
        onClicked: switched(switchedOn)
    }
}
