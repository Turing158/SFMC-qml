#ifndef DOWNLOADUTIL_H
#define DOWNLOADUTIL_H

#include <QObject>
#include "networkutil.h"

class DownloadUtil : public QObject
{
    Q_OBJECT
public:
    explicit DownloadUtil(QObject *parent = nullptr);

    NetworkUtil nu;

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
