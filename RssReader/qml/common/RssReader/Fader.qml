import QtQuick 1.0

// This rectangle acts as a dimming rect. It also captures key presses.
Rectangle {
    id: faderRect

    // Fader assumes that "screenWidth/Height" is declared as a context property
    // (e.g. at main.cpp). This is because it needs to catch the (touch) events
    // all around the UI, when it's being faded.
    width: screenWidth      // Take control over the full screen.
    height: screenHeight
    opacity: 0
    color: "black"

    // Used to define how fast the fade in / fade out will be done (in milliseconds)
    property int transitionDuration: 300
    // Change this, if you want to have deeper/lighter fade
    property double fadingOpacity: 0.7

    // This rectangle captures all of the key events so that underlying buttons
    // etc. can't be pressed.
    Rectangle {
        id: keyCapturer

        MouseArea {
            id: mouseArea
            width: screenWidth
            height: screenHeight
            z: 100 // Make sure that this is on top of everything.
            onClicked: console.log("Click captured by Fader!")
        }
    }

    states: [
        State {
            name: ""    // This could actually be implicit...
            PropertyChanges {
                target: faderRect
                opacity: 0
            }
        },
        State {
            name: "faded"
            PropertyChanges {
                target: faderRect
                opacity: fadingOpacity
            }
        }
    ]

    transitions: [
        Transition {
            from: ""
            to: "faded"
            SequentialAnimation {
                NumberAnimation { properties: "opacity"; easing.type: Easing.Linear; duration: transitionDuration }
            }
        },
        Transition {
            from: "faded"
            to: ""
            NumberAnimation { properties: "opacity"; easing.type: Easing.Linear; duration: transitionDuration }
        }
    ]
}
