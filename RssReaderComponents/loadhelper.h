/**
 * Copyright (c) 2011 Nokia Corporation.
 */

#ifndef LOADHELPER_H
#define LOADHELPER_H

#include <QObject>

// Forward declarations
class QmlApplicationViewer;

class LoadHelper : public QObject
{
    Q_OBJECT

public:
    explicit LoadHelper(QmlApplicationViewer *viewer, QObject *parent = 0);

public slots:
    void loadMainQML();

private: // Data
    QmlApplicationViewer *m_viewer;     // Not owned
};


#endif // LOADHELPER_H
