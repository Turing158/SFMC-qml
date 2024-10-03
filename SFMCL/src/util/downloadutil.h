#ifndef DOWNLOADUTIL_H
#define DOWNLOADUTIL_H

#include <QObject>
#include <QProcess>
#include <QJsonObject>
#include <json/json.h>
#include "networkutil.h"
#include "launcherutil.h"
#include "stdutil.h"
#include "filedirutil.h"

class DownloadUtil : public QObject
{
    Q_OBJECT
public:
    explicit DownloadUtil(QObject *parent = nullptr);

    NetworkUtil nu;
    LauncherUtil lu;
    StdUtil su;
    FileDirUtil fdu;

    QString downloadUrl = "https://bmclapi2.bangbang93.com/version/";

    Q_INVOKABLE void getMinecraftList();
    void getMinecraftOfSupportingOptifine();
    void getMinecraftOfSupportingLiteloader();
    void getMinecraftOfSupportingForge();
    void getMinecraftOfSupportingNeoForge();
    void getMinecraftOfSupportingFabric();
    QVariantMap getMinecreftListFromJson(const QByteArray &data);
    QVariantList getMinecraftOfSupportingOptifineFromJson(const QByteArray &data);
    QVariantList getMinecraftOfSupportingLiteloaderFromJson(const QByteArray &data);
    QVariantList getMinecraftOfSupportingForgeFromJson(const QByteArray &data);
    QVariantList getMinecraftOfSupportingNeoForgeFromJson(const QByteArray &data);
    QVariantList getMinecraftOfSupportingFabricFromJson(const QByteArray &data);

    Q_INVOKABLE void downloadMinecraft(QString version,QString versionName,QString gameDir);
    void downloadMinecraftFunc(QString version,QString versionName,QString gameDir);

signals:
    void returnGetMinecraftList(QVariantMap data);
    void errorGetMinecraftList();
    void returnMinecraftOfSupportingOptifine(QVariantList data);
    void returnMinecraftOfSupportingLiteloader(QVariantList data);
    void returnMinecraftOfSupportingForge(QVariantList data);
    void returnMinecraftOfSupportingNeoForge(QVariantList data);
    void returnMinecraftOfSupportingFabric(QVariantList data);
};

#endif // DOWNLOADUTIL_H
