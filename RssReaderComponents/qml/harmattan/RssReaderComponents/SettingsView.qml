import QtQuick 1.0
import com.nokia.meego 1.0

Page {
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
                verticalAlignment: Text.AlignVCenter
                font {
                    family: container.fontName
                    pointSize: container.fontSize
                }

                text: themeSwitch.checked ? qsTr("Theme: Dark") : qsTr("Theme: Light")
                // WORKAROUND FOR THERE'S NO clicked() SIGNAL
                // for "Switch" component ON HARMATTAN / MEEGO!
                onTextChanged: {
                    var theme = themeSwitch.checked ? "DarkTheme" : "Visual";
                    themeChanged(theme);
                }
            }

            Switch {
                id: themeSwitch

                anchors.right: parent.right
                height: container.settingHeight
                // NOTE: There's no clicked() signal on Harmattan/Meego
                // QtQuick Components!
//                onClicked: {
//                    var theme = checked ? "Visual" : "DarkTheme";
//                    themeChanged(theme);
//                }
            }
        }
    }
}
