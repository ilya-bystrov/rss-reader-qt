// Visual style for Maemo 5
import QtQuick 1.0

Item {
    property color windowActiveTextColor: "black"
    property color buttonPassiveColor: "grey"
    property color buttonActiveColor: Qt.darker(buttonPassiveColor)
    property color buttonTextColor: "black"
    property color buttonBorderColor: Qt.darker(buttonPassiveColor)

    // Main window
    property color applicationBackgroundColor: "#f8f8f8"

    // Splash screen
    property int splashTimeout: 2500

    // Generic
    property int generalMargin: 4
    property int scrollBarWidth: 2*generalMargin
    property string defaultFontFamily: "Helvetica"
    property color defaultFontColor: "black"

    // Title bar
    property string titleBarFont: defaultFontFamily
    property int titleBarFontSize: 22
    property int titleBarSmallerFontSize: 22
    property int titleBarSmallestFontSize: 18
    property color titlebarFontColor: "#44aa33"
    property color titleBarBackgroundColor: "transparent"
    property int titleBarHeight: 60

    // Footer
    property int footerHeight: 60

    // Settings view
    property string settingsViewFont: defaultFontFamily
    property int settingsViewFontSize: 14
    property color settingsViewFontColor: "red"

    // Discovery view
    property string discoveryViewFont: defaultFontFamily
    property int discoveryViewFontSize: 18
    property color discoveryViewFontColor: defaultFontColor

    // Category view
    property string categoryViewHeaderItemFont: defaultFontFamily
    property int categoryViewHeaderItemFontSize: 18
    property color categoryViewHeaderItemFontColor: defaultFontColor

    property string categoryViewSubItemFont: defaultFontFamily
    property int categoryViewSubItemFontSize: 16
    property color categoryViewSubItemFontColor: defaultFontColor

    // Feed view
    property string feedViewFont: defaultFontFamily
    property int feedViewFontSize: 18
    property color feedViewFontColor: defaultFontColor

    // Feed item view
    property string feedItemViewFont: defaultFontFamily
    property int feedItemViewFontSize: 18
    property color feedItemViewFontColor: defaultFontColor
}
