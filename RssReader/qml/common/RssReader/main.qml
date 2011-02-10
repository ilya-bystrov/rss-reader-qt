import QtQuick 1.0
import "Util.js" as Util

// Follow http://doc.qt.nokia.com/4.7/qml-coding-conventions.html
Rectangle {
    id: mainWindow

    Visual { id: visual }

    // Properties.
    AppStateVars {
        id: appState
    }

    // Connect the the orientation sensor signal to our handler function
    Connections {
        id: orient
        property bool inLandscape: false
        target: filter // this is available only on device, on desktop you get warnings
        onOrientationChanged: {
            if (orientation === 1) {
                Util.log("Orientation TOP POINTING UP");
                orient.inLandscape = false
            } else if (orientation === 2) {
                Util.log("Orientation TOP POINTING DOWN");
                orient.inLandscape = false
            } else if (orientation === 3) {
                Util.log("Orientation LEFT POINTING UP");
                orient.inLandscape = true
            } else if (orientation === 4) {
                Util.log("Orientation RIGHT POINTING UP");
                orient.inLandscape = true
            }
        }
    }

    // Signals

    // Functions

    // Handle orientation changes

    // Object properties
    anchors.centerIn: parent
    width: visual.appWidth ? visual.appWidth: screenWidth
    height: visual.appHeight ? visual.appHeight : screenHeight
    color: visual.applicationBackgroundColor

    // We start out showing the splash screen
    state: "showingSplashScreen"

    // Child objects

    // Wait indicator is also not visible by default, only when mainWindow.loading === true
    WaitIndicator {
        id: waitIndicator
        anchors.centerIn: mainWindow
        width: 120
        height: 120
        z: 120
        show: appState.loading
    }

    // Splash screen is full screen but visible only at the start
    SplashScreen {
        id: splashScreen
        anchors.fill: mainWindow
        // Put splash screen on top of everything. Otherwise you would need to lay it out as the last objects
        // in the layout for it to be on top of all other objects. But with z-property we get same results
        z: 100
        // By default splash screen is not visible
        opacity: 0.0
        // Splash screen timeout
        timeout: visual.splashTimeout
        image: "../RssReader/gfx/splash_screen.png"
        // When splash screen times out, move to default state
        onSplashTimeout: {
            appState.currentViewName = "categoryView";
            Util.log("Splash screen finished")
        }
    }

    // All views have a title bar
    TitleBar {
        id: titleBar
        // Anchors titlebar to left,top and right. Then set height
        // Use grouping if possible.
        anchors {
            top: mainWindow.top
            left: mainWindow.left
            right: mainWindow.right
        }
        fontBold: true
        fontName: visual.titleBarFont
        fontSize: visual.titleBarFontSize
        fontColor: visual.titlebarFontColor
        color: visual.titleBarBackgroundColor
        height: visual.titleBarHeight
        text: appState.currentTitle;
        iconSource: "gfx/rss_logo.png"
        showingBackButton: appState.showBackButton
        onBackButtonClicked: {
            Util.log("Back-button clicked. Came from view: " + viewName);
            if (viewName === "feedView") {
                appState.fromLeft = true;
                appState.currentViewName = "categoryView";
            } else if (viewName === "feedItemView") {
                appState.fromLeft = true;
                appState.currentViewName = "feedView";
            } else if (viewName === "discoveryView") {
                appState.fromLeft = false;
                appState.currentViewName = "categoryView";
            } else if (viewName === "settingsView") {
                appState.fromLeft = false;
                appState.currentViewName = "categoryView";
            }
        }
        onExitButtonClicked: {
            Util.exitApp("Exit-button clicked");
        }
    }

    // This item will contain the views that we switch between
    Item {
        id: contentPane
        //clip: true
        anchors {
            top: titleBar.bottom
            left: mainWindow.left
            right: mainWindow.right
            bottom: footer.top
            margins: 8
        }

        // View switcher component, handles the view switching and animation
        ViewSwitcher {
            id: viewSwitcher
            // Rooted in contentPane
            root: contentPane
            // Start from feedListView
            currentView: categoryView
        }

        // Our views inside the contentPane

        // Settings view
        SettingsView {
            id: settingsView
            anchors.fill: parent
            opacity: 0
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
            opacity: 0
            fontName: visual.discoveryViewFont
            fontSize: visual.discoveryViewFontSize
            fontColor: visual.discoveryViewFontColor
        }

        // Main view containing your subscriptions
        CategoryView {
            id: categoryView
            anchors {
                top: parent.top
                bottom: parent.bottom
            }
            width:  parent.width
            headerItemFontName: visual.categoryViewHeaderItemFont
            headerItemFontSize: visual.categoryViewHeaderItemFontSize
            headerItemFontColor: visual.categoryViewHeaderItemFontColor

            subItemFontName: visual.categoryViewSubItemFont
            subItemFontSize: visual.categoryViewSubItemFontSize
            subItemFontColor: visual.categoryViewSubItemFontColor

            opacity: 1
            onFeedSelected: {
                Util.log("Selected feed: " + feedName)
                appState.selectedFeedTitle = feedName;
                appState.fromLeft = false;
                appState.currentViewName = "feedView";
            }
            onDiscoverFromCategory: {
                Util.log("Discover from " + categoryView.expandedCategoryTitle
                         + ", url:" + categoryView.selectedCategoryUrl);
                // Set the discovery view to show the proper category:
                discoveryView.categoryTitle = categoryView.expandedCategoryTitle
                discoveryView.discoveryUrl = categoryView.selectedCategoryUrl
                appState.selectedFeedTitle = categoryView.expandedCategoryTitle
                appState.fromLeft = true;
                appState.currentViewName = "discoveryView";
            }
        }

        // Feed view showing selected feed's items
        FeedView {
            id: feedView
            anchors {
                top: parent.top
                bottom: parent.bottom
            }
            width:  parent.width
            scrollBarWidth: visual.scrollBarWidth
            opacity: 0
            fontName: visual.feedViewFont
            fontSize: visual.feedViewFontSize
            fontColor: visual.feedViewFontColor
            feedName: categoryView.selectedCategoryTitle
            feedUrl: categoryView.selectedCategoryUrl
            onFeedItemSelected: {
                Util.log("Selected feed item");
                appState.selectedFeedItemTitle = title;
                appState.fromLeft = false;
                appState.currentViewName = "feedItemView";
            }
        }

        FeedItemView {
            id: feedItemView
            anchors {
                top: parent.top
                bottom: parent.bottom
            }
            width:  parent.width
            scrollBarWidth: visual.scrollBarWidth
            opacity: 0
            fontName: visual.feedItemViewFont
            fontSize: visual.feedItemViewFontSize
            fontColor: visual.feedItemViewFontColor

            itemTitle: feedView.itemTitle
            itemDescription: feedView.itemDescription
            itemUrl: feedView.itemUrl
            itemImageUrl: feedView.itemImageUrl
        }

        BorderImage {
            id: frame
            source: "gfx/frame.png"
            border { left: 8; top: 8; right: 8; bottom: 8 }
            width: contentPane.width
            // Adjust the background frame a bit when in feedItemView to give some
            // space for the button there.
            height: appState.currentViewName == "feedItemView" ? contentPane.height - 75  : contentPane.height
            anchors { top: contentPane.top; left: contentPane.left }
        }
    }

    Footer {
        id: footer
        height: visual.footerHeight
        property bool show: false
        state: show ? "visible" : "hidden"
        anchors {
            left: mainWindow.left
            right: mainWindow.right
        }
        states: [
            State {
                name: "visible"
                AnchorChanges { target: footer; anchors.bottom: mainWindow.bottom; anchors.top: undefined }
            },
            State {
                name: "hidden"
                AnchorChanges { target: footer; anchors.bottom: undefined; anchors.top: mainWindow.bottom }
            }
        ]

        transitions: Transition { AnchorAnimation { duration: 400;  easing.type: Easing.InOutQuad } }
        onSettingsButtonClicked: {
            appState.fromLeft = true
            appState.currentViewName = "settingsView"
        }
    }

    // States


    // Default state is implicit, all other states are defined here
    states: [
        State {
            name: "showingSplashScreen"
            PropertyChanges {
                target: splashScreen
                // We use opacity so we can animate, instead of visible
                opacity: 1.0
            }
        },
        State {
            name: "showingDiscoveryView"
            when: appState.currentViewName === "discoveryView";
            PropertyChanges {
                // Set all state variable changes to appState
                target: appState
                showBackButton: true;
                //currentTitle: appState.selectedFeedTitle
                currentTitle: qsTr("Manage news feeds")
            }
            // Animate the view switch with viewSwitcher
            StateChangeScript { script: viewSwitcher.switchView(discoveryView, appState.fromLeft, 0); }
        },
        State {
            name: "showingCategoryView"
            // Move to this state when currentView name is set to categoryView
            when: appState.currentViewName === "categoryView";
            PropertyChanges {
                // Set all state variable changes to appState
                target: appState
                showBackButton: false;
                currentTitle: qsTr("RSS Reader");
            }
            PropertyChanges { target: footer; show: true }
            // Animate the view switch with viewSwitcher
            StateChangeScript { script: viewSwitcher.switchView(categoryView, appState.fromLeft, 0); }
        },
        State {
            name: "showingFeedView"
            when: appState.currentViewName === "feedView";
            PropertyChanges {
                // Set all state variable changes to appState
                target: appState
                showBackButton: true
                currentTitle: appState.selectedFeedTitle
            }
            PropertyChanges {
                target: titleBar
                fontSize: visual.titleBarSmallerFontSize
            }
            // Animate the view switch with viewSwitcher
            StateChangeScript { script: viewSwitcher.switchView(feedView, appState.fromLeft, 0); }
        },
        State {
            name: "showingFeedItemView"
            when: appState.currentViewName === "feedItemView";
            PropertyChanges {
                // Set all state variable changes to appState
                target: appState
                showBackButton: true
                currentTitle: appState.selectedFeedItemTitle
            }
            PropertyChanges {
                target: titleBar
                fontSize: visual.titleBarSmallestFontSize
            }
            // Animate the view switch with viewSwitcher
            StateChangeScript { script: viewSwitcher.switchView(feedItemView, appState.fromLeft, 0); }
        },
        State {
            name: "showingSettingsView"
            when: appState.currentViewName === "settingsView";
            PropertyChanges {
                // Set all state variable changes to appState
                target: appState
                showBackButton: true
                currentTitle: qsTr("Settings")
            }
            // Animate the view switch with viewSwitcher
            StateChangeScript { script: viewSwitcher.switchView(settingsView, appState.fromLeft, 0); }
        }
    ]

    // Transitions
    transitions: [
        Transition {
            from: ""
            to: "showingSplashScreen"
            reversible: true
            // Animate the opacity change in 0,5s
            PropertyAnimation {
                property: "opacity"
                duration: 500
            }
        }
    ]

    Behavior on rotation { RotationAnimation { direction: RotationAnimation.Shortest; duration: 500; easing.type: Easing.OutQuint } }
    Behavior on width    { NumberAnimation   { duration: 500; } }
    Behavior on height   { NumberAnimation   { duration: 500; } }
}

