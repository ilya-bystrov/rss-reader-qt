import QtQuick 1.1
import com.nokia.symbian 1.1

Item {
    id: container

    property alias text: button.text
    property bool show: false
    property int posX: 0
    property int posY: 0
    property string fontName: "Helvetica"
    property int fontSize: 10
    property color fontColor: "black"

    signal clicked

    anchors.fill: parent
    opacity: show == true ? 1 : 0

    Behavior on opacity {
        NumberAnimation {
            duration: visual.theme.generalTransitionTime
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
        platformInverted: appState.isInverted

        font {
            family: container.fontName
            pointSize: container.fontSize
        }

        onClicked: {
            container.show = false
            container.clicked()
        }
    }
}
