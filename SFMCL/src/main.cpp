
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "entity/player.h"
#include "util/launcherutil.h"
#include "util/loginutil.h"
#include "util/downloadutil.h"
#include "launcher.h"

#include "app_environment.h"
#include "import_qml_components_plugins.h"
#include "import_qml_plugins.h"

#include <QIcon>

int main(int argc, char *argv[])
{
    set_qt_environment();

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/main.qml"_qs);
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);

    qmlRegisterType<Player>("Player",1,0,"PlayerInfo");
    qmlRegisterType<LauncherUtil>("LauncherUtil",1,0,"LauncherUtil");
    qmlRegisterType<Launcher>("Launcher",1,0,"Launcher");
    qmlRegisterType<LoginUtil>("LoginMinecraft",1,0,"LoginMinecraft");
    qmlRegisterType<DownloadUtil>("DownloadUtil",1,0,"DownloadUtil");//DownloadUtil

    engine.addImportPath(QCoreApplication::applicationDirPath() + "/qml");
    engine.addImportPath(":/");

    engine.load(url);

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }
    app.setWindowIcon(QIcon(":/img/ico.png"));
    return app.exec();
}
