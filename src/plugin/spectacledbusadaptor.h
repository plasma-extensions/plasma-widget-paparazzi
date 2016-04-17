#ifndef SPECTACLEDBUSADAPTOR_H
#define SPECTACLEDBUSADAPTOR_H

#include <QObject>

#include "Spectacle.h"


class SpectacleDbusAdaptor : public QObject
{
    Q_OBJECT
public:
    SpectacleDbusAdaptor(QObject *parent = 0);
    ~SpectacleDbusAdaptor();

public Q_SLOTS:
    void captureScreen(int delay);
    void captureWindow(int delay);
    void captureArea(int delay);

private:
    org::kde::Spectacle *iface;
};

#endif // SPECTACLEDBUSADAPTOR_H
