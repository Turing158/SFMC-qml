#ifndef NETWORKUTIL_H
#define NETWORKUTIL_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QFile>
#include <QDir>
#include <QDebug>
#include <QEventLoop>
#include "stdutil.h"
class NetworkUtil : public QObject
{
    Q_OBJECT
public:
    explicit NetworkUtil(QObject *parent = nullptr);

    StdUtil su;

    QNetworkAccessManager *manager = new QNetworkAccessManager(this);

    QString downloadFile(QString url,QString filePath);



signals:
};

#endif // NETWORKUTIL_H
