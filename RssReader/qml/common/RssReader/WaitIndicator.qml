import QtQuick 1.0

// This item provides waiting indicator, should some long -taking operation be in
// progress. Effectively WaitIndicator just shows some graphics, which rolls on the UI.
//
// Usage: Bind whatever model.loading -property etc. with the rotator's show property.
Item {
    id: rotator

    width: parent.width
    height: parent.height

    // Defines whether or not the RoTaToR is shown.
    property bool show: false
    // Defines the size of the rolling graphics.
    property int imageWidth: 128
    property int imageHeight: 128

    // Use opacity to hide/show the indicator. Also animate the enterance/exit
    // by using Behaviour on opacity.
    opacity: 0
    Behavior on opacity { PropertyAnimation { duration: 250 } }

    // Use the Fader to dim the background a bit and bind it also to
    // WaitIndicator's "show" -property
    Fader {
        fadingOpacity: 0.4
        // Bind our visibility status with Fader show/hide states.
        state: rotator.opacity == 1 ? "faded" : ""
        transitionDuration: 250
        color: "#f5f5f5"
    }

    // Nice, symmetric graphics that roll on the screen.
    Image {
        id: rotatorImg
        source: "gfx/rotation_icon.png"
        width: imageWidth
        height: imageHeight
        anchors.centerIn: parent
        smooth: true

        NumberAnimation on rotation {
              running: rotator.show
              from: 0; to: 360
              loops: Animation.Infinite;
              duration: 1000
          }
    }
    // Allow a small delay before displaying the rotator.
    Timer {
        interval: 1000
        running: rotator.show
        repeat: false
        onTriggered: opacity = 1
    }

    onShowChanged: {
        // Handle rotator exit.
        if(show == false) opacity = 0
    }
}
