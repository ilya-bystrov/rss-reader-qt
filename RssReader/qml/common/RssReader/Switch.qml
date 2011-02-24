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
    property alias spacing: row.spacing
    width: row.width
    height: 44

    Row {
        id: row
        spacing: 8
        Text {
            id: textOn
            text: "On"
            height: container.height
            color: container.fontColor
            font {
                family: container.fontName
                pointSize: container.fontSize
            }
            verticalAlignment: Text.AlignVCenter
        }
        Image {
            id: toggleSwitch
            height: container.height
            source: switchedOn ? imageOn : imageOff
            fillMode: Image.PreserveAspectFit
            smooth: true
        }
        Text {
            id: textOff
            height: container.height
            text: "Off"
            color: container.fontColor
            font {
                family: container.fontName
                pointSize: container.fontSize
            }
            verticalAlignment: Text.AlignVCenter
        }
    }
    MouseArea {
        anchors.fill: row
        onClicked: { switchedOn = !switchedOn; switched(switchedOn) }
    }
}
