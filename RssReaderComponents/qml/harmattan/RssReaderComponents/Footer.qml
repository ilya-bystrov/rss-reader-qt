import QtQuick 1.0
import com.nokia.meego 1.0

Item {
    id: container

    signal settingsButtonClicked

    width: 360
    height: 80

    Button {
        id: settings_button

        //text: ""
        width: parent.height
        height: parent.height

        onClicked: container.settingsButtonClicked()
        anchors {
            verticalCenter: parent.verticalCenter
            right: container.right
            margins: 8
        }

        iconSource: visual.theme.images.settingsIcon
    }
}
