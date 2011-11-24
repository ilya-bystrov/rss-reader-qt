/**
 * Copyright (c) 2011 Nokia Corporation.
 */

#include <QtCore/QTimer>
#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include "loadhelper.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QmlApplicationViewer viewer;
    // Set this attribute in order to avoid drawing the system
    // background unnecessary.
    // TODO: If need be to variate this between S^3 and 5.0 devices, this will
    // need to be variated run-time (e.g. with QDeviceInfo::Version())!
    viewer.setAttribute(Qt::WA_NoSystemBackground);

    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);

    // First set a QML file that's quick to load and show it as a splash screen.
    viewer.setMainQmlFile(QLatin1String("qml/RssReaderComponents/SplashScreen.qml"));
    // Then trigger loading the *real* main.qml file, which can take longer to load.
    LoadHelper loadHelper(&viewer);
    QTimer::singleShot(1, &loadHelper, SLOT(loadMainQML()));

    viewer.showExpanded();
    return app.exec();
}
