#ifndef ORIENTATIONFILTER_H
#define ORIENTATIONFILTER_H


#include <QOrientationFilter>
#include <QtCore/QDebug>

QTM_USE_NAMESPACE

class OrientationFilter : public QObject, public QOrientationFilter
{
    Q_OBJECT
public:
    bool filter(QOrientationReading *reading) {
        emit orientationChanged(reading->orientation());

        // don't store the reading in the sensor
        return false;
    }

signals:
    void orientationChanged(const QVariant &orientation);
};

#endif // ORIENTATIONFILTER_H
