QML RSS Reader v.1.4
====================

This RSS Reader example application demonstrates the use of RSS feed resources.
It presents the content of feed in a rich UI with view navigation, search,
accordion list, and animations. The UI components are designed to be reusable
in other  applications. RSS Reader uses the QML local storage to store the
feeds that the user has subscribed to. The application also demonstrates how
a graphical theme can be switched, from the settings view.

This example application is hosted in Nokia Developer Projects:
- http://projects.developer.nokia.com/QMLRSSReader

For more information on implementation visit the wiki page:
- http://projects.developer.nokia.com/QMLRSSReader/wiki


IMPORTANT CLASSES AND QML ELEMENTS
-------------------------------------------------------------------------------

Qt:
- QmlApplicationViewer, QDeclarativeView, QTimer

Standard QML elements used:
- Component
- Item
- Rectangle
- Text
- TextEntry
- Image
- BorderImage
- ListView
- Grid
- Column
- FocusScope
- Gradient
- GradientStop
- MouseArea

- State
- Transition
- Behavior
- PropertyChanges
- PropertyAnimation
- NumberAnimation
- ParallelAnimation
- SequentialAnimation

QML elements from Qt Quick Components used:
- Window
- Page
- PageStack
- StatusBar
- ToolBar
- ToolBarLayout
- ToolButton / ToolIcon
- ToolTip
- ButtonRow
- Button


FILES
-------------------------------------------------------------------------------

design/*

- UI design files

RssReader/*

- The application itself. Contains a PRO file that can be opened in 
  Qt SDK 1.1.4

screenhots/*

- Screenshots for the wiki page


INSTALLATION INSTRUCTIONS
-------------------------------------------------------------------------------

Symbian^3 phone
~~~~~~~~~~~~~~~

There are two ways to install the application on a phone.

1. a) Drag the RssReaderComponenets_1.4.0_installer.sis file to the Nokia Suite
      while your phone is connected with a USB cable.
   
   OR
   
   b) Send the application directly to the Messaging Inbox (for example,
      over a Bluetooth connection).

2. After the installation is complete, return to the application menu and
   open the Applications folder.
   
3. Locate the RssReader icon and select it to launch the application.


Nokia N9
~~~~~~~~

1. Copy the rssreadercomponents_1.4.0_armel.deb file into a specific folder
   on the phone (for example, 'MyDocs').

2. Start XTerm. Type 'sudo gainroot' to get root access.

3. 'cd' to the directory in to which you copied the package
   (for example, 'cd MyDocs').

4. As root, install the package:
   dpkg -i rssreadercomponents_1.4.0_armel.deb

5. Launch the Applications menu.

6. Locate the RssReader icon and select it to launch the application.


COMPATIBILITY
-------------------------------------------------------------------------------

- Symbian^3 with Qt version 4.7.4 or higher

- Nokia N9 or N950 with Qt 4.7.4

Tested on:

- Nokia E6
- Nokia E7-00
- Nokia N9

Developed with:

- Qt SDK 1.1.4


VERSION HISTORY
-------------------------------------------------------------------------------
v1.5    Added Nokia Conversations feed and done few bug fixes.
v1.4    Added E6 support, UI fine tuning, some refactoring.
v1.3    Version published on the Nokia Developer website.
v1.1    Added MeeGo/Harmattan 1.2 support.
v1.0    Initial release.
v0.1.7  Initial version published in Forum Nokia Projects.
