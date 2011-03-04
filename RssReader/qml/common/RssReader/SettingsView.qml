import QtQuick 1.0

Item {
    id: container

    property string fontName: "Helvetica"
    property int fontSize: 12
    property color fontColor: "black"
    property double margins: 8
    property int settingHeight: visual.theme.settingHeight

    signal themeChanged(string theme)

    Column {
        anchors.fill: parent
        anchors.margins: container.margins
        spacing: container.margins
        Item {
            height: container.settingHeight
            anchors.left: parent.left
            anchors.right: parent.right
            Text {
                id: switchLabel
                anchors.left: parent.left
                anchors.right: themeSwitch.left
                height: container.settingHeight
                color: container.fontColor
                font {
                    family: container.fontName
                    pointSize: container.fontSize
                }
                text: qsTr("Theme")
                verticalAlignment: Text.AlignVCenter
            }
            Switch {
                id: themeSwitch
                anchors.right: parent.right
                height: container.settingHeight
                spacing: container.margins
                fontName: container.fontName
                fontSize: container.fontSize
                fontColor: container.fontColor
                textOn: qsTr("Light")
                textOff: qsTr("Dark")
                imageOn: visual.theme.images.switchOn
                imageOff:  visual.theme.images.switchOff
                onSwitched: {
                    var theme = position ? "Visual" : "DarkTheme";
                    themeChanged(theme);
                }
            }
        }
    }
}
