#include "spectacledbusadaptor.h"

#include <QFile>
#include <QtWidgets/QApplication>
#include <QClipboard>
#include <QImage>

SpectacleDbusAdaptor::SpectacleDbusAdaptor(QObject *parent) : QObject(parent)
{
      if (!QDBusConnection::sessionBus().isConnected()) {
        qWarning("Cannot connect to the D-Bus session bus.\n"
                 "Please check your system settings and try again.\n");
    }
    iface = new org::kde::Spectacle("org.kde.Spectacle", "/", QDBusConnection::sessionBus(), this);
    
    connect(iface, &org::kde::Spectacle::ScreenshotFailed, this, &SpectacleDbusAdaptor::screenshotFailed);
    connect(iface, &org::kde::Spectacle::ScreenshotTaken, this, &SpectacleDbusAdaptor::screenshotTaken);
    
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

void SpectacleDbusAdaptor::eraseCapture(const QString &fileName) {
  QFile file (fileName);
  file.remove();
}

void SpectacleDbusAdaptor::copyCaptureToClipboard(const QString &fileName) {
  QImage image (fileName);
  QClipboard * clipboard = QApplication::clipboard();

  if (!image.isNull())
    clipboard->setImage(image);
}