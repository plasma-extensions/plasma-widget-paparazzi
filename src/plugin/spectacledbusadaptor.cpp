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

void SpectacleDbusAdaptor::captureScreen(int delay) {
    qDebug() << "Capturing screenn.";
    iface->FullScreen(false);
}

void SpectacleDbusAdaptor::captureWindow(int delay) {
    qDebug() << "Capturing window.";
    iface->ActiveWindow(true, false);
}

void SpectacleDbusAdaptor::captureArea(int delay) {
    qDebug() << "Capturing area.";
    iface->ActiveWindow();
}
