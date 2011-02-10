import QtQuick 1.0

Item {
    id: container
    signal switched(bool position)
    property string fontName: "Helvetica"
    property int fontSize: 12
    property color fontColor: "black"
    property string imageOn: 'gfx/switch_on.png'
    property string imageOff: 'gfx/switch_off.png'
    property bool switchedOn: true
    property alias textOn: textOn.text
    property alias textOff: textOff.text
    width: toggleSwitch.width + textOn.width + textOff.width
    height: 44

    Text {
        id: textOn
        anchors.right: toggleSwitch.left
        anchors.margins: 8
        text: "On"
        color: container.fontColor
        font {
            family: container.fontName
            pixelSize: container.fontSize
        }
        elide: Text.ElideRight
    }

    Image {
        id: toggleSwitch
        height: parent.height
        anchors.right: textOff.left
        anchors.margins: 8
        source: switchedOn ? imageOn : imageOff
        fillMode: Image.PreserveAspectFit
        smooth: true
    }

    Text {
        id: textOff
        anchors.right: container.right
        anchors.margins: 8
        text: "Off"
        color: container.fontColor
        font {
            family: container.fontName
            pixelSize: container.fontSize
        }
        elide: Text.ElideLeft
    }

    MouseArea {
        anchors.fill: parent
        onClicked: { switchedOn = !switchedOn; switched(switchedOn) }
    }

    Component.onCompleted: console.log("textOn width "+textOn.width+" textOff "+ textOff.width+" container "+container.width)
}
