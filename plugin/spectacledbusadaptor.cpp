#include "spectacledbusadaptor.h"

SpectacleDbusAdaptor::SpectacleDbusAdaptor(QObject *parent) : QObject(parent)
{
      if (!QDBusConnection::sessionBus().isConnected()) {
        qWarning("Cannot connect to the D-Bus session bus.\n"
                 "Please check your system settings and try again.\n");
    }
    iface = new org::kde::Spectacle("org.kde.Spectacle", "/", QDBusConnection::sessionBus(), this);
}

SpectacleDbusAdaptor::~SpectacleDbusAdaptor(){
}

void SpectacleDbusAdaptor::captureScreen(bool include_pointer) {
    qDebug() << "Capturing screen.";
    iface->FullScreen(include_pointer);
}

void SpectacleDbusAdaptor::captureWindow(bool include_pointer) {
    qDebug() << "Capturing window.";
    iface->ActiveWindow(true, include_pointer);
}

void SpectacleDbusAdaptor::captureArea(bool include_pointer) {
    qDebug() << "Capturing area.";
    iface->RectangularRegion(include_pointer);
}
