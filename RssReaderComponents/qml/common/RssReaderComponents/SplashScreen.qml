import QtQuick 1.1

Item {
    id: splash

    property bool landscape: width > height
    property int transitionTime: 300

    width: 360
    height: 640
    opacity: 1

    Image {
        id: bgImg
        anchors.fill: parent
        source: landscape ? "gfx/splash_screen_landscape.png" : "gfx/splash_screen.png"
    }

    Behavior on opacity {
        NumberAnimation {
            duration: splash.transitionTime
            easing.type: Easing.InOutQuad
        }
    }

    Component.onDestruction: {
        splash.opacity = 0;
    }
}
