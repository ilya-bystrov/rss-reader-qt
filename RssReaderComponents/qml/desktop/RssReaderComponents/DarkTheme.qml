// Visual style for desktop
import QtQuick 1.1

Item {
    property alias images: images

    // E6 has different screen resolution & aspect ratio (640x480), thus
    // there's some differentation for it separately.
    property bool isE6: true

    // Time used in transitions, given in milliseconds
    property int generalTransitionTime: 300
    property color windowActiveTextColor: "#f0f0f0"
    property color buttonPassiveColor: "grey"
    property color buttonActiveColor: Qt.lighter(buttonPassiveColor)
    property color buttonTextColor: "#f0f0f0"
    property color buttonBorderColor: Qt.lighter(buttonPassiveColor)
    property bool exitButtonVisible: true

    Item {
        id: images
        property string path: "DarkTheme/"

        property string arrow: path+"arrow.png"
        property string moreIcon: path+"more.png"
        property string lessIcon: path+"less.png"
        property string nextIcon: path+"next.png"
        property string backButton: path+"back_button.png"
        property string backButtonPressed: path+"back_button_pressed.png"
        property string exitButton: path+"exit_button.png"
        property string exitButtonPressed: path+"exit_button_pressed.png"
        property string favourited: path+"favourited.png"
        property string notFavourited: path+"favourited_not.png"
        property string frame: path+"frame.png"
        property string handle: path+"handle.png"
        property string rotationIcon: path+"rotation_icon.png"
        property string rssLogo: path+"rss_logo.png"
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

        // Custom ToolButtons
        property string readFullArticle: path+"qgn_indi_browser_feeds_tb_open_full.svg"
    }

    // Main window
    property color applicationBackgroundColor: "#2D2D2D"

    // Splash screen
    property int splashTimeout: 2500

    // Generic
    property int generalMargin: 4
    property int scrollBarWidth: 3*generalMargin
    property string defaultFontFamily: "Helvetica"
    property color defaultFontColor: "#f0f0f0"

    // Title bar
    property string titleBarFont: defaultFontFamily
    property int titleBarFontSize: 12
    property int titleBarSmallerFontSize: 10
    property int titleBarSmallestFontSize: 8
    property color titlebarFontColor: "white"
    property color titleBarBackgroundColor: "#478847"
    property int titleBarHeight: isE6 ? 46 : 30

    // Footer
    property int footerHeight: 60

    // AccordionList
    property int accordionItemHeight: isE6 ? 71 : 54

    // Settings view
    property string settingsViewFont: defaultFontFamily
    property int settingsViewFontSize: 12
    property color settingsViewFontColor: defaultFontColor
    property int settingHeight: 64
    property int segmentedButtonWidth: 100

    // Discovery view
    property string discoveryViewFont: defaultFontFamily
    property int discoveryViewFontSize: 12
    property color discoveryViewFontColor: defaultFontColor

    // Category view
    property string categoryViewHeaderItemFont: defaultFontFamily
    property int categoryViewHeaderItemFontSize: 14
    property color categoryViewHeaderItemFontColor: defaultFontColor

    property string categoryViewSubItemFont: defaultFontFamily
    property int categoryViewSubItemFontSize: 12
    property color categoryViewSubItemFontColor: defaultFontColor

    // Feed view
    property string feedViewFont: defaultFontFamily
    property int feedViewFontSize: 12
    property int feedViewSearchFontSize: isE6 ? 8 : 10
    property color feedViewFontColor: defaultFontColor
    property int feedViewSearchBoxHeight: isE6 ? 48 : 36

    // Feed item view
    property string feedItemViewFont: defaultFontFamily
    property int feedItemViewFontSize: 12
    property color feedItemViewFontColor: defaultFontColor
    property color feedSearchFontColor: "black"
    property color feedSearchBarBgColor: "#ffffff"

    // Busy indicator properties
    property int busyIndicatorSize: 150
}
