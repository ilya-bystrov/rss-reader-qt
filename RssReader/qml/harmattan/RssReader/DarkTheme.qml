// Visual style for Harmattan
import QtQuick 1.0

Item {
    property alias images: images
    property color windowActiveTextColor: "#f0f0f0"
    property color buttonPassiveColor: "grey"
    property color buttonActiveColor: Qt.lighter(buttonPassiveColor)
    property color buttonTextColor: "#f0f0f0"
    property color buttonBorderColor: Qt.lighter(buttonPassiveColor)
    property bool exitButtonVisible: false

    Item {
        id: images
        property string path: "DarkTheme/"

        property string arrow: path+"arrow.png"
        property string backButton: path+"back_button.png"
        property string backButtonPressed: path+"back_button_pressed.png"
        property string exitButton: ""
        property string exitButtonPressed: ""
        property string favourited: path+"favourited.png"
        property string notFavourited: path+"favourited_not.png"
        property string frame: path+"frame.png"
        property string handle: path+"handle.png"
        property string rotationIcon: path+"rotation_icon.png"
        property string rssLogo: path+"rss_logo.png"
        property string scrollbar: path+"scrollbar.png"
        property string searchIcon: path+"search_icon.png"
        property string settingsIcon: path+"settings_icon.png"
        property string switchOff: path+"switch_off.png"
        property string switchOn: path+"switch_on.png"
        property string textField: path+"text_field.png"

        // Border images
        property string button: path+"button.png"
        property string buttonActive: path+"button_active.png"
        property string buttonPressed: path+"button_pressed.png"

        property string listItem: path+"list_item.png"
        property string listItemActive: path+"list_item_active.png"
        property string listItemPressed: path+"list_item_pressed.png"
        property string listItemSelected: path+"list_item_selected.png"
        property string listSubitem: path+"list_subitem.png"

        // Category icons
        property string entertainmentIcon: path+"entertainment_icon.png"
        property string newsIcon: path+"news_icon.png"
        property string sporstsIcon: path+"sports_icon.png"
        property string techIcon: path+"tech_icon.png"
    }

    // Main window
    property color applicationBackgroundColor: "#333333"

    // Splash screen
    property int splashTimeout: 2500

    // Generic
    property int generalMargin: 8
    property int scrollBarWidth: 2*generalMargin
    property string defaultFontFamily: "Helvetica"
    property color defaultFontColor: "#f0f0f0"

    // Title bar
    property string titleBarFont: defaultFontFamily
    property int titleBarFontSize: 22
    property int titleBarSmallerFontSize: 22
    property int titleBarSmallestFontSize: 18
    property color titlebarFontColor: "#c0da07"
    property color titleBarBackgroundColor: "transparent"
    property int titleBarHeight: 80

    // Footer
    property int footerHeight: 80

    // Settings view
    property string settingsViewFont: defaultFontFamily
    property int settingsViewFontSize: 18
    property color settingsViewFontColor: defaultFontColor
    property int settingHeight: 60

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