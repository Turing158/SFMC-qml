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
    QVariantMap getMinecreftListFromJson(const QByteArray &data);

signals:
    void returnGetMinecraftList(QVariantMap data);
};

#endif // DOWNLOADUTIL_H
