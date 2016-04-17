
#include "plasmoidplugin.h"
#include "spectacledbusadaptor.h"

#include <QtQml>
#include <QDebug>

void PlasmoidPlugin::registerTypes(const char *uri)
{
    Q_ASSERT(uri == QLatin1String("org.kde.private.spectacle"));

    qmlRegisterType<SpectacleDbusAdaptor>(uri, 1, 0, "DbusAdaptor");
}
