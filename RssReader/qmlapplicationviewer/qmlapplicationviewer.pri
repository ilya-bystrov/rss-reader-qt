# checksum 0x89 version 0x2000a
# This file was generated by the Qt Quick Application wizard of Qt Creator.
# The code below adds the QmlApplicationViewer to the project and handles the
# activation of QML debugging.
# It is recommended not to modify this file, since newer versions of Qt Creator
# may offer an updated version of it.

QT += declarative

SOURCES += $$PWD/qmlapplicationviewer.cpp
HEADERS += $$PWD/qmlapplicationviewer.h
INCLUDEPATH += $$PWD

defineTest(minQtVersion) {
    maj = $$1
    min = $$2
    patch = $$3
    isEqual(QT_MAJOR_VERSION, $$maj) {
        isEqual(QT_MINOR_VERSION, $$min) {
            isEqual(QT_PATCH_VERSION, $$patch) {
                return(true)
            }
            greaterThan(QT_PATCH_VERSION, $$patch) {
                return(true)
            }
        }
        greaterThan(QT_MINOR_VERSION, $$min) {
            return(true)
        }
    }
    return(false)
}

contains(DEFINES, QMLJSDEBUGGER) {
    CONFIG(debug, debug|release) {
        !minQtVersion(4, 7, 1) {
            warning()
            warning("Disabling QML debugging:")
            warning()
            warning("Debugging QML requires the qmljsdebugger library that ships with Qt Creator.")
            warning("This library requires Qt 4.7.1 or newer.")
            warning()
            DEFINES -= QMLJSDEBUGGER
        } else:isEmpty(QMLJSDEBUGGER_PATH) {
            warning()
            warning("Disabling QML debugging:")
            warning()
            warning("Debugging QML requires the qmljsdebugger library that ships with Qt Creator.")
            warning("Please specify its location on the qmake command line, eg")
            warning("  qmake -r QMLJSDEBUGGER_PATH=$CREATORDIR/share/qtcreator/qmljsdebugger")
            warning()
            DEFINES -= QMLJSDEBUGGER
        } else {
            include($$QMLJSDEBUGGER_PATH/qmljsdebugger-lib.pri)
        }
    } else {
        DEFINES -= QMLJSDEBUGGER
    }
}
# This file was generated by an application wizard of Qt Creator.
# The code below handles deployment to Symbian and Maemo, aswell as copying
# of the application data to shadow build directories on desktop.
# It is recommended not to modify this file, since newer versions of Qt Creator
# may offer an updated version of it.

defineTest(qtcAddDeployment) {
for(deploymentfolder, DEPLOYMENTFOLDERS) {
    item = item$${deploymentfolder}
    itemsources = $${item}.sources
    $$itemsources = $$eval($${deploymentfolder}.source)
    itempath = $${item}.path
    $$itempath= $$eval($${deploymentfolder}.target)
    export($$itemsources)
    export($$itempath)
    DEPLOYMENT += $$item
}

MAINPROFILEPWD = $$PWD

symbian {
    ICON = $${TARGET}.svg
    TARGET.EPOCHEAPSIZE = 0x20000 0x2000000
    contains(DEFINES, ORIENTATIONLOCK):LIBS += -lavkon -leikcore -lcone
    contains(DEFINES, NETWORKACCESS):TARGET.CAPABILITY += NetworkServices
} else:win32 {
    copyCommand =
    for(deploymentfolder, DEPLOYMENTFOLDERS) {
        source = $$MAINPROFILEPWD/$$eval($${deploymentfolder}.source)
        source = $$replace(source, /, \\)
        sourcePathSegments = $$split(source, \\)
        target = $$OUT_PWD/$$eval($${deploymentfolder}.target)/$$last(sourcePathSegments)
        target = $$replace(target, /, \\)
        !isEqual(source,$$target) {
            !isEmpty(copyCommand):copyCommand += &&
            copyCommand += $(COPY_DIR) \"$$source\" \"$$target\"
        }
    }
    !isEmpty(copyCommand) {
        copyCommand = @echo Copying application data... && $$copyCommand
        copydeploymentfolders.commands = $$copyCommand
        first.depends = $(first) copydeploymentfolders
        export(first.depends)
        export(copydeploymentfolders.commands)
        QMAKE_EXTRA_TARGETS += first copydeploymentfolders
    }
} else:unix {
    maemo5 {
        installPrefix = /opt/usr
        desktopfile.path = /usr/share/applications/hildon
    } else {
        installPrefix = /usr/local
        desktopfile.path = /usr/share/applications
        copyCommand =
        for(deploymentfolder, DEPLOYMENTFOLDERS) {
            source = $$MAINPROFILEPWD/$$eval($${deploymentfolder}.source)
            source = $$replace(source, \\, /)
            macx {
                target = $$OUT_PWD/$${TARGET}.app/Contents/Resources/$$eval($${deploymentfolder}.target)
            } else {
                target = $$OUT_PWD/$$eval($${deploymentfolder}.target)
            }
            target = $$replace(target, \\, /)
            sourcePathSegments = $$split(source, /)
            targetFullPath = $$target/$$last(sourcePathSegments)
            !isEqual(source,$$targetFullPath) {
                !isEmpty(copyCommand):copyCommand += &&
                copyCommand += $(MKDIR) \"$$target\"
                copyCommand += && $(COPY_DIR) \"$$source\" \"$$target\"
            }
        }
        !isEmpty(copyCommand) {
            copyCommand = @echo Copying application data... && $$copyCommand
            copydeploymentfolders.commands = $$copyCommand
            first.depends = $(first) copydeploymentfolders
            export(first.depends)
            export(copydeploymentfolders.commands)
            QMAKE_EXTRA_TARGETS += first copydeploymentfolders
        }
    }
    for(deploymentfolder, DEPLOYMENTFOLDERS) {
        item = item$${deploymentfolder}
        itemfiles = $${item}.files
        $$itemfiles = $$eval($${deploymentfolder}.source)
        itempath = $${item}.path
        $$itempath = $${installPrefix}/share/$${TARGET}/$$eval($${deploymentfolder}.target)
        export($$itemfiles)
        export($$itempath)
        INSTALLS += $$item
    }
    icon.files = $${TARGET}.png
    icon.path = /usr/share/icons/hicolor/64x64/apps
    desktopfile.files = $${TARGET}.desktop
    target.path = $${installPrefix}/bin
    export(icon.files)
    export(icon.path)
    export(desktopfile.files)
    export(desktopfile.path)
    export(target.path)
    INSTALLS += desktopfile icon target
}

export (ICON)
export (INSTALLS)
export (DEPLOYMENT)
export (TARGET.EPOCHEAPSIZE)
export (TARGET.CAPABILITY)
export (LIBS)
export (QMAKE_EXTRA_TARGETS)
}
