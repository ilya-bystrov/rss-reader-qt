# Add more folders to ship with the application, here
common_qml.source = qml/common/RssReaderComponents
common_qml.target = qml

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

symbian:TARGET.UID3 = 0xE1075E42

# Smart Installer package's UID
# This UID is from the protected range and therefore the package will
# fail to install if self-signed. By default qmake uses the unprotected
# range value if unprotected UID is defined for the application and
# 0x2002CCCF value if protected UID is given to the application
#symbian:DEPLOYMENT.installer_header = 0x2002CCCF

VERSION = 1.3.0
# Platform specific files and configuration
symbian {
    TARGET.UID3 = 0xE1E1B70E
    # Allow network access on Symbian
    TARGET.CAPABILITY += NetworkServices
    platform_qml.source = qml/symbian/RssReaderComponents
    platform_qml.target = qml
    QML_IMPORT_PATH = qml/symbian/RssReaderComponents
} else:maemo5 {
    QT += opengl
    platform_qml.source = qml/maemo/RssReaderComponents
    platform_qml.target = qml
    QML_IMPORT_PATH = qml/maemo/RssReaderComponents
} else:simulator {
    platform_qml.source = qml/symbian/RssReaderComponents
    platform_qml.target = qml
    QML_IMPORT_PATH = qml/symbian/RssReaderComponents
} else:win32{
    # Windows
    platform_qml.source = qml/desktop/RssReaderComponents
    platform_qml.target = qml
    QML_IMPORT_PATH = qml/desktop/RssReaderComponents
} else:unix {
    # Harmattan, at the moment we can't differentiate unix and Harmattan.
#    QT += opengl
    DEFINES += Q_WS_HARMATTAN
    platform_qml.source = qml/harmattan/RssReaderComponents
    platform_qml.target = qml
    QML_IMPORT_PATH = qml/harmattan/RssReaderComponents

    # Desktop & icon -files
    desktop.files = rssreadercomponents.desktop
    desktop.path = /usr/share/applications
    INSTALLS += desktop

    # TODO: Enable these, when Unix/OsX can be separated from Harmattan!
    # e.g. else:desktop {...
#    platform_qml.source = qml/desktop/RssReader
#    platform_qml.target = qml
#    QML_IMPORT_PATH = qml/desktop/RssReader
}

DEPLOYMENTFOLDERS = common_qml platform_qml

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

# Put generated temp-files under tmp
MOC_DIR = tmp
OBJECTS_DIR = tmp
RCC_DIR = tmp
UI_DIR = tmp

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    qtc_packaging/debian_harmattan/rules \
    qtc_packaging/debian_harmattan/README \
    qtc_packaging/debian_harmattan/copyright \
    qtc_packaging/debian_harmattan/control \
    qtc_packaging/debian_harmattan/compat \
    qtc_packaging/debian_harmattan/changelog \
    qtc_packaging/debian_fremantle/rules \
    qtc_packaging/debian_fremantle/README \
    qtc_packaging/debian_fremantle/copyright \
    qtc_packaging/debian_fremantle/control \
    qtc_packaging/debian_fremantle/compat \
    qtc_packaging/debian_fremantle/changelog

contains(MEEGO_EDITION,harmattan) {
    icon.files = RssReaderComponents.svg
    icon.path = /usr/share/icons/hicolor/scalable/apps
    INSTALLS += icon
}
