import QtQuick 1.0
import com.nokia.symbian 1.0

Item {
    id: container

    signal settingsButtonClicked

    width: 360
    height: 80

    Button {
        id: settings_button

        text: ""

        onClicked: container.settingsButtonClicked()
        anchors {
            verticalCenter: parent.verticalCenter
            right: container.right
            margins: 8
        }

        iconSource: visual.theme.images.settingsIcon
    }
}
