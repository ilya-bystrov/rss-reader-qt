import QtQuick 1.0

// SplashScreen displays user defined graphics, e.g. during application startup.
// User can also define the maximum time SplashScreen will stay on screen, and
// handle the incoming signal if timeout is reached.
Rectangle {
    id: splashMain

    // Timeout that defines how long the Splash Screen should be shown at max.
    property int timeout: 2500  // 2,5s by default.

    // Default Splash image, user should set the correct one set when
    // instantiating the SplashScreen.
    property string image: "gfx/splash_screen.png"

    // Defines whether or not the Splash Screen is shown.
    property bool show: false

    // Emit a signal when timeout is reached
    signal splashTimeout()

    // State is being deduced from the "show" property.
    state: show ? "showingSplashScreen" : ""

    // Splash is hidden by default.
    opacity: 0.0

    // Start the splash timer when SplashScreen becomes visible.
    onStateChanged: {
        if (state == "showingSplashScreen" ){
            splashTimer.start();
        }
    }

    // Image shown.
    Image {
        source: image
        anchors.centerIn: parent
    }

    // Timer that hides the Splash after the given timeout.
    Timer {
        id: splashTimer
        interval: timeout
        running: false
        repeat: false;
        onTriggered: { splashMain.splashTimeout(); splashMain.show = false }
    }

    // Default state is implicit.
    states: [
        State {
            name: "showingSplashScreen"
            PropertyChanges {
                target: splashMain
                // We use opacity so we can animate, instead of visible
                opacity: 1.0
            }
        }
    ]

    // Transitions
    transitions: [
        Transition {
            from: "showingSplashScreen"
            to: ""
            // Set this reversible if you would like to have also fading in.
            // Though it might look bit stupid during startup.
            //reversible: true

            // Animate the opacity change in 0,5s
            PropertyAnimation {
                property: "opacity"
                duration: 500
            }
        }
    ]
}
