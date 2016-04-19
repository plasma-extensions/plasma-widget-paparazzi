#include "spectacledbusadaptor.h"

SpectacleDbusAdaptor::SpectacleDbusAdaptor(QObject *parent) : QObject(parent)
{
    iface = new org::kde::Spectacle(QString(), QString(), QDBusConnection::sessionBus(), this);
}

SpectacleDbusAdaptor::~SpectacleDbusAdaptor(){
}

void SpectacleDbusAdaptor::captureScreen(int delay) {
    qDebug() << "Capturing screen.";
    iface->FullScreen(false);
}

void SpectacleDbusAdaptor::captureWindow(int delay) {
    qDebug() << "Capturing window.";
    iface->ActiveWindow(true, false);
}

void SpectacleDbusAdaptor::captureArea(int delay) {
    qDebug() << "Capturing area.";
    iface->RectangularRegion(false);
}
