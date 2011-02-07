import QtQuick 1.0

Rectangle {
    // Id for reference inside this component. Own id is set when instantiated in main.qml
    id: splashMain

    // Emit a signal when timeout is reached
    signal splashTimeout()

    // Public properties i.e. the "public interface" to the component
    property int timeout: 2500  // 2,5s timout by default
    // could be made an alias property as well but now we can have a default value, otherwise users would
    // have to specify it always
    property string image: "" // by default no image, must be set when instantiated/used

    // Start the splash timer when we become visible
    //onVisibleChanged: splashTimer.start();
    onOpacityChanged: {
        if (opacity > 0.99) {
            splashTimer.start();
        }
    }

     // Object properties
    width: screenWidth
    height: screenHeight
    opacity: 0.0
    color: "green"

    Image {
        source: image
        anchors.centerIn: parent
    }

    // Child objects
    Timer {
        id: splashTimer
        interval: timeout
        running: false
        repeat: false;
        onTriggered: { splashMain.splashTimeout(); splashMain.opacity = 0 }
    }
}
