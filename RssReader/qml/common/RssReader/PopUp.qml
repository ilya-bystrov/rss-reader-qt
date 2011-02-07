import QtQuick 1.0

Item {
    id: container
    property alias text: button.text
    property bool show: false
    property int posX: 0
    property int posY: 0

    anchors.fill: parent
    opacity: show == true ? 1 : 0

    signal clicked

    Behavior on opacity {
        NumberAnimation {
            duration: 300
            easing.type: Easing.InOutQuad
        }
    }

    // Mouse grabber area, clicking on it will dismiss the popup.
    Item {
        anchors.fill:  parent
        MouseArea {
            enabled: container.show
            anchors.fill: parent
            onClicked: container.show = false
        }
    }

    // Clicking on the button sends a signal.
    Button {
        id: button
        x: parent.posX - width/2
        y: parent.posY - height/2
        onClicked: {
            container.show = false
            container.clicked()
        }
    }
}
