import QtQuick 1.0

Item {
    id: container

    property string fontName: "Helvetica"
    property int fontSize: 12
    property color fontColor: "black"

    Column {
        anchors {
            fill: parent
            margins: 10
        }

        spacing: 10
        Text {
            id: switchLabel
            text: qsTr("Refresh on background")
            font {
                family: container.fontName
                pointSize: container.fontSize
            }
            color: container.fontColor
        }

        Switch {
            id: refreshSwitch
            anchors.right: container.right

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
