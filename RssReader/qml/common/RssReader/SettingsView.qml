import QtQuick 1.0

Item {
    id: container

    property string fontName: "Helvetica"
    property int fontSize: 8
    property color fontColor: "black"

    Column {
        anchors {
            fill: parent
            margins: 10
        }

        spacing: 10
        Text {
            id: switchLabel
            text: qsTr("Settings: TBD")
            font {
                family: container.fontName
                pointSize: container.fontSize
            }
            color: container.fontColor
        }

        Switch {
            id: refreshSwitch
            x: 0

        }

    }
    /*
    Slider {
        anchor {
            left: parent.left
            right: parent.right
        }
    }*/
}
