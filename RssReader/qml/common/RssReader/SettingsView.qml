import QtQuick 1.0

Item {
    id: container

    property string fontName: "Helvetica"
    property int fontSize: 12
    property color fontColor: "black"
    property double margins: 8
    signal themeChanged(string theme)
    Column {
        anchors.fill: parent
        anchors.margins: container.margins
        spacing: container.margins

        Row {
            width: parent.width
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
                imageOn: visual.theme.images.switchOn
                imageOff:  visual.theme.images.switchOff
                onSwitched: {
                    var theme = position ? "Visual" : "DarkTheme";
                    themeChanged(theme);
                }
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
