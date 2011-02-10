# Files common to all platforms
common_qml.source = qml/common/RssReader
common_qml.target = qml

# Platform specific files and configuration
symbian {
    TARGET.UID3 = 0xE1E1B70E
    HEADERS += orientationfilter.h
    platform_qml.source = qml/symbian/RssReader
    platform_qml.target = qml
    QML_IMPORT_PATH = qml/symbian/RssReader
} else:maemo5 {
    QT += opengl
    HEADERS += orientationfilter.h
    platform_qml.source = qml/maemo/RssReader
    platform_qml.target = qml
    QML_IMPORT_PATH = qml/maemo/RssReader
} else:win32{
    # Windows
    platform_qml.source = qml/desktop/RssReader
    platform_qml.target = qml
    QML_IMPORT_PATH = qml/desktop/RssReader
} else:unix {
    # OS X, Linux, Unix
    platform_qml.source = qml/desktop/RssReader
    platform_qml.target = qml
    QML_IMPORT_PATH = qml/desktop/RssReader
}

DEPLOYMENTFOLDERS = common_qml platform_qml

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# Avoid auto screen rotation, we do layout ourself with orientationsensor and animations
DEFINES += ORIENTATIONLOCK

# Needs to be defined for Symbian
DEFINES += NETWORKACCESS

# Define QMLJSDEBUGGER to allow debugging of QML in debug builds
# (This might significantly increase build time)
# DEFINES += QMLJSDEBUGGER

# If your application uses the Qt Mobility libraries, uncomment
# the following lines and add the respective components to the 
# MOBILITY variable. 
CONFIG += mobility
MOBILITY += sensors

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp


# Put generated temp-files under tmp
MOC_DIR = tmp
OBJECTS_DIR = tmp
RCC_DIR = tmp
UI_DIR = tmp

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()
