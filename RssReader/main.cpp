#include <QtGui/QApplication>
#include <QtGui/QDesktopWidget>
#include <QtDeclarative/QDeclarativeContext>
#include "qmlapplicationviewer.h"

#ifdef Q_WS_MAEMO_5
#include <QtOpenGL/QGLWidget>
#endif

#if defined(Q_WS_MAEMO_5) || defined(Q_OS_SYMBIAN)
#include <QOrientationSensor>
#include "orientationfilter.h"
QTM_USE_NAMESPACE
#endif


int main(int argc, char *argv[])
{
    // Create application
    QApplication app(argc, argv);

    // Create the viewer helper
    QmlApplicationViewer viewer;

    // For Maemo 5 and Symbian use screen resolution but for desktop use different size
#if defined(Q_WS_MAEMO_5) || defined(Q_OS_SYMBIAN)
    // Get screen dimensions
    QDesktopWidget *desktop = QApplication::desktop();
    const QRect screenRect = desktop->screenGeometry();
#else
    // On desktop we use nHD
    QPoint topLeft(100,100);
    QSize size(360, 640);
    QRect screenRect(topLeft, size);
#endif


    // Set the screen size to QML context
    QDeclarativeContext* context = viewer.rootContext();
    context->setContextProperty("screenWidth", screenRect.width());
    context->setContextProperty("screenHeight", screenRect.height());

    // set viewer parameters
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/RssReader/main.qml"));
    viewer.addImportPath(QLatin1String("qml/Components"));

    // For N900 set OpenGL rendering
#ifdef Q_WS_MAEMO_5
    QGLFormat fmt = QGLFormat::defaultFormat();
    fmt.setDirectRendering(true);
    fmt.setDoubleBuffer(true);

    QGLWidget *glWidget = new QGLWidget(fmt);
    viewer.setViewport(glWidget);
#endif


#if defined(Q_WS_MAEMO_5) || defined(Q_OS_SYMBIAN)
    viewer.showFullScreen();
#else
    viewer.show();
#endif
    // Start application loop
    return app.exec();
}
