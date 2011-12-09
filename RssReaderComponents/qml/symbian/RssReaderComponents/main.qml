import QtQuick 1.1
import com.nokia.symbian 1.1
import "Util.js" as Util

// Follow http://doc.qt.nokia.com/4.7/qml-coding-conventions.html
Window {
    id: mainWindow

    width: 360
    height: 640
    anchors.centerIn: parent

    // We start out showing the splash screen
    state: "start"

    Component.onCompleted: {
        console.log("RssReader: main.qml loading completed!")
        pageStack.push(categoryView);
        mainWindow.state = "end"
    }

    // Background color rectangle.
    Rectangle {
        anchors.fill: parent
        color: visual.theme.applicationBackgroundColor
    }

    // Shows the StatusBar!
    StatusBar {
        id: statusBar
        platformInverted: appState.isInverted
    }

    // Change the Visual stuff into use here!
    Loader {
        id: visual
        property alias theme: visual.item
        // Use the "Dark" theme by default
        source: "DarkTheme.qml"
    }

    // Properties.
    AppStateVars {
        id: appState
    }

    // Wait indicator is also not visible by default, only when mainWindow.loading === true
    WaitIndicator {
        id: waitIndicator
        anchors.centerIn: contentPane
        width: contentPane.width
        height: contentPane.height
        z: 120
        show: appState.loading
    }

    // All views have a title bar
    TitleBar {
        id: titleBar

        enabled: true
        // Anchors titlebar to left,top and right. Then set height
        // Use grouping if possible.
        anchors {
            top: statusBar.bottom
            left: parent.left
            right: parent.right
        }

        backButtonSource: visual.theme.images.backButton
        backButtonPressedSource: visual.theme.images.backButtonPressed
        exitButtonSource: visual.theme.images.exitButton
        exitButtonPressedSource: visual.theme.images.exitButtonPressed
        exitButtonVisible: visual.theme.exitButtonVisible

        fontName: visual.theme.titleBarFont
        fontSize: visual.theme.titleBarFontSize
        fontColor: visual.theme.titlebarFontColor
//        color: visual.theme.titleBarBackgroundColor
        height: visual.theme.titleBarHeight
        text: appState.currentTitle
        iconSource: visual.theme.images.rssLogo
    }

    ToolBarLayout {
        id: defaultTools

        property string previousViewName: "categoryView"

        ToolButton {
            id: backButton
            iconSource: "toolbar-back"

            onPlatformReleased: backButtonTip.opacity = 0;
            onPlatformPressAndHold: backButtonTip.opacity = 1;
            onClicked: {
                if (appState.showBackButton) {
                    var viewName = appState.currentViewName;
                    Util.log("Back-button clicked. Came from view: " + viewName);
                    if (viewName === "feedView") {
                        appState.currentViewName = "categoryView";
                    } else if (viewName === "feedItemView") {
                        appState.currentViewName = "feedView";
                    } else if (viewName === "discoveryView") {
                        appState.currentViewName = "categoryView";
                    } else if (viewName === "settingsView") {
                        // Return to the previous view.
                        appState.currentViewName = defaultTools.previousViewName;
                    }
                    pageStack.pop();
                } else {
                    Util.exitApp("Exit-button clicked");
                }
            }
        }

        // Button for launching the browser for reading the full article.
        // Show/hide whenever the FeedItemView is visible.
        ToolButton {
            id: articleButton
            iconSource: visual.theme.images.readFullArticle
            opacity: appState.rssItemUrl !== "" ? 1 : 0

            onPlatformReleased: articleButtonTip.opacity = 0;
            onPlatformPressAndHold: articleButtonTip.opacity = 1;
            onClicked: {
                console.log("Read Article clicked, appState.rssItemUrl: "
                            + appState.rssItemUrl);
                if (appState.rssItemUrl !== "") {
                    Qt.openUrlExternally(appState.rssItemUrl);
                }
            }

            // Subtle fade in/out animation for the button appear/disappear.
            Behavior on opacity {
                NumberAnimation { duration: visual.theme.generalTransitionTime; easing.type: Easing.InOutQuad }
            }
        }

        ToolButton {
            id: settingsButton
            iconSource: visual.theme.images.settingsIcon

            onPlatformReleased: settingsButtonTip.opacity = 0;
            onPlatformPressAndHold: settingsButtonTip.opacity = 1;
            onClicked: {
                if (appState.currentViewName != "settingsView") {
                    // Save the previous view name so that we can return
                    // back to the correct one.
                    defaultTools.previousViewName = appState.currentViewName;
                    appState.currentViewName = "settingsView"
                    pageStack.push(settingsView);
                }
            }
        }
    }

    ToolBar {
        id: commonTools
        anchors.bottom: parent.bottom
        tools: defaultTools
        platformInverted: appState.isInverted
    }

    // PageStack for navigation between the views. Animation between the views
    // is performed by the PageStack, when views are pushed / popped.
    PageStack {
        id: pageStack

        clip: true
        anchors {
            top: titleBar.bottom
            left: parent.left
            right: parent.right
            bottom: commonTools.top
            margins: 2
        }
    }

    // This item will contain the views that we switch between
    Item {
        id: contentPane

        clip: true
        anchors {
            top: titleBar.bottom
            left: parent.left
            right: parent.right
            bottom: commonTools.top
            margins: 2
        }


        // Views inside the contentPane:
        // Settings view
        SettingsView {
            id: settingsView

            anchors.fill: parent
            fontName: visual.theme.settingsViewFont
            fontSize: visual.theme.settingsViewFontSize
            fontColor: visual.theme.settingsViewFontColor

            onThemeChanged: {
                visual.source = theme+".qml";
                // Also invert the platform color scheme.
                appState.isInverted = !appState.isInverted
            }
        }

        // Discovery view to add more subscriptions
        DiscoveryView {
            id: discoveryView

            anchors {
                top: parent.top
                bottom: parent.bottom
            }
            // Must use width and not anchor to left&right for left/right animations to work
            width:  parent.width
            // The views that are not visible should be set to 0 opacity or visible: false
            fontName: visual.theme.discoveryViewFont
            fontSize: visual.theme.discoveryViewFontSize
            fontColor: visual.theme.discoveryViewFontColor
        }

        // Main view containing your subscriptions
        CategoryView {
            id: categoryView

            function setTitleBarGradient(category) {
                // Select, which gradient to show behind the TitleBar
                if (category == "News") {
                    titleBar.currentGradientStart = titleBar.newsGradientStart;
                    titleBar.currentGradientEnd = titleBar.newsGradientEnd;
                } else if (category== "Entertainment") {
                    titleBar.currentGradientStart = titleBar.entertainmentGradientStart;
                    titleBar.currentGradientEnd = titleBar.entertainmentGradientEnd;
                } else if (category== "Sports") {
                    titleBar.currentGradientStart = titleBar.sportsGradientStart;
                    titleBar.currentGradientEnd = titleBar.sportsGradientEnd;
                } else if (category== "Tech" ) {
                    titleBar.currentGradientStart = titleBar.techGradientStart;
                    titleBar.currentGradientEnd = titleBar.techGradientEnd;
                } else {
                    titleBar.currentGradientStart = titleBar.mainGradientStart;
                    titleBar.currentGradientEnd = titleBar.mainGradientEnd;
                }
            }

            anchors {
                top: parent.top
                topMargin: 2
                bottom: parent.bottom
            }

            width: parent.width
            headerItemFontName: visual.theme.categoryViewHeaderItemFont
            headerItemFontSize: visual.theme.categoryViewHeaderItemFontSize
            headerItemFontColor: visual.theme.categoryViewHeaderItemFontColor

            subItemFontName: visual.theme.categoryViewSubItemFont
            subItemFontSize: visual.theme.categoryViewSubItemFontSize
            subItemFontColor: visual.theme.categoryViewSubItemFontColor

            onFeedSelected: {
                Util.log("Selected feed: " + feedName + " from " + expandedCategory + " category.")
                appState.selectedFeedTitle = feedName;
                appState.fromLeft = false;
                appState.currentViewName = "feedView";
                // Move onwards to show the FeedView.
                pageStack.push(feedView);

                setTitleBarGradient(expandedCategoryTitle);
            }
            onDiscoverFromCategory: {
                Util.log("Discover from " + category
                                         + ", url:" + categoryView.selectedCategoryUrl);
                // Set the discovery view to show the proper category:
                discoveryView.categoryTitle = category;
                appState.selectedFeedTitle = categoryView.expandedCategoryTitle;
                appState.fromLeft = true;
                appState.currentViewName = "discoveryView";
                appState.currentTitle = "Manage "+category+" Feeds";
                // Show the DiscoveryView.
                pageStack.push(discoveryView);

                setTitleBarGradient(category);
            }
        }

        // Feed view showing selected feed's items.
        FeedView {
            id: feedView

            anchors {
                top: parent.top
                bottom: parent.bottom
            }
            width: parent.width
            scrollBarWidth: visual.theme.scrollBarWidth
            fontName: visual.theme.feedViewFont
            fontSize: visual.theme.feedViewFontSize
            fontColor: visual.theme.feedViewFontColor
            feedName: categoryView.selectedCategoryTitle
            feedUrl: categoryView.selectedCategoryUrl
            defaultText: "Tap to search"

            onFeedItemSelected: {
                Util.log("Selected feed item");
                appState.selectedFeedItemTitle = title;
                appState.fromLeft = false;
                appState.currentViewName = "feedItemView";
                // Move into the single feedItemView.
                pageStack.push(feedItemView);
            }
        }

        // FeedItemView shows selected item's content in rich text.
        FeedItemView {
            id: feedItemView

            anchors {
                top: parent.top
                bottom: parent.bottom
            }
            width:  parent.width
            scrollBarWidth: visual.theme.scrollBarWidth
            fontName: visual.theme.feedItemViewFont
            fontSize: visual.theme.feedItemViewFontSize
            fontColor: visual.theme.feedItemViewFontColor

            itemTitle: feedView.itemTitle
            itemDescription: feedView.itemDescription
            itemUrl: feedView.itemUrl
            itemImageUrl: feedView.itemImageUrl
        }
    }

    // The ToolTips have to appear above every view, thus defined here.
    ToolTip {
        id: backButtonTip
        text: qsTr("Back")
        target: backButton
        visible: false
        platformInverted: appState.isInverted
    }

    ToolTip {
        id: articleButtonTip
        text: qsTr("Read full article")
        target: articleButton
        visible: false
        platformInverted: appState.isInverted
    }

    ToolTip {
        id: settingsButtonTip
        text: qsTr("Settings")
        target: settingsButton
        visible: false
        platformInverted: appState.isInverted
    }

    // States
    // Default state is implicit, all other states are defined here.
    states: [
        State {
            name: "start"
            PropertyChanges { target: mainWindow; x: width / 2; opacity: 0 }
            PropertyChanges { target: appState; currentTitle: qsTr("RSS Reader")}
        },
        State {
            name: "end"
            PropertyChanges { target: mainWindow; x: 0; opacity: 1 }
            PropertyChanges { target: appState; currentTitle: qsTr("RSS Reader")}
        },
        State {
            name: "showingDiscoveryView"
            when: appState.currentViewName === "discoveryView";
            PropertyChanges {
                // Set all state variable changes to appState
                target: appState
                showBackButton: true;
            }
            PropertyChanges {
                target: titleBar
                fontSize: visual.theme.titleBarFontSize
            }
        },
        State {
            name: "showingCategoryView"
            // Move to this state when currentView name is set to categoryView.
            when: appState.currentViewName === "categoryView";
            PropertyChanges {
                // Set all state variable changes to appState
                target: appState
                showBackButton: false;
                currentTitle: qsTr("RSS Reader");
            }
            PropertyChanges {
                target: titleBar
                currentGradientStart: titleBar.mainGradientStart
                currentGradientEnd: titleBar.mainGradientEnd
            }
            StateChangeScript { script: console.log("Changing Page to: CategoryView"); }
        },
        State {
            name: "showingFeedView"
            when: appState.currentViewName === "feedView";
            PropertyChanges {
                // Set all state variable changes to appState.
                target: appState
                showBackButton: true
                currentTitle: appState.selectedFeedTitle
            }
            PropertyChanges {
                target: titleBar
                fontSize: visual.theme.titleBarFontSize
            }
            StateChangeScript { script: console.log("Changing Page to: FeedView"); }
        },
        State {
            name: "showingFeedItemView"
            when: appState.currentViewName === "feedItemView";
            PropertyChanges {
                // Set all state variable changes to appState.
                target: appState
                showBackButton: true
                currentTitle: appState.selectedFeedTitle
            }
            PropertyChanges {
                target: titleBar
                fontSize: visual.theme.titleBarFontSize
            }
            StateChangeScript { script: console.log("Changing Page to: FeedItemView"); }
        },
        State {
            name: "showingSettingsView"
            when: appState.currentViewName === "settingsView";
            PropertyChanges {
                // Set all state variable changes to appState.
                target: appState
                showBackButton: true
                currentTitle: qsTr("Settings")
            }
            PropertyChanges {
                target: titleBar
                currentGradientStart: titleBar.mainGradientStart
                currentGradientEnd: titleBar.mainGradientEnd
            }
            StateChangeScript { script: console.log("Changing Page to: SettingsView"); }
        }
    ]
    transitions: Transition {
        from: "start"; to: "end"
        ParallelAnimation {
            PropertyAnimation { properties: "x"; easing.type: Easing.OutQuad; duration: visual.theme.generalTransitionTime }
            PropertyAnimation { properties: "opacity"; easing.type: Easing.Linear; duration: visual.theme.generalTransitionTime }
        }
    }
}

