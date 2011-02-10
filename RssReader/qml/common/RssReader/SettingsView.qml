import QtQuick 1.0

Item {
    id: container

    property string fontName: "Helvetica"
    property int fontSize: 12
    property color fontColor: "black"
    property double margins: 8
    Column {
        anchors.fill: parent
        spacing: container.margins

        Row {
            anchors {
                left: parent.left
                right: parent.right
                margins: container.margins
            }
            spacing: container.margins

            Text {
                id: switchLabel
                anchors.left:  parent.left
                anchors.right: themeSwitch.left
                anchors.margins: container.margins
                color: container.fontColor
                font {
                    family: container.fontName
                    pixelSize: container.fontSize
                }
                text: qsTr("Theme")
            }

            Switch {
                id: themeSwitch
                anchors.right: parent.right
                anchors.margins: container.margins
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
}
