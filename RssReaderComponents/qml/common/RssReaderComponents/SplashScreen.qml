import QtQuick 1.1

Item {
    id: splash

    property bool landscape: width > height
    property bool isE6: height == 480
    property int transitionTime: 300

    opacity: 1

    Image {
        id: bgImg
        anchors.fill: parent
        source: landscape ? (isE6 ? "gfx/splash_screen_e6.png"
                                  : "gfx/splash_screen_landscape.png" )
                          : "gfx/splash_screen.png"
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
