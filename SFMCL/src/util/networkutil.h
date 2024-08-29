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
#include <json/json.h>
#include <QJsonDocument>
#include <QUrlQuery>
#include <QJsonObject>
#include "stdutil.h"
class NetworkUtil : public QObject
{
    Q_OBJECT
public:
    explicit NetworkUtil(QObject *parent = nullptr);

    StdUtil su;

    QNetworkAccessManager *manager;

    QString downloadFile(QString url,QString filePath);
    void GET(const QUrl &url,const QMap<QString,QString> &header);
    void GET(const QUrl &url);
    void GET(const QUrl &url,const QVariantMap &args);
    void POST(const QUrl &url,const QJsonObject &jsonData);
    void POST(const QUrl &url,const Json::Value &json);
    void POST(const QUrl &url,const QVariantMap &args);

signals:
    void dataReceived(const QByteArray &data); // 传递数据的信号

private slots:
    void onReplyFinished();
};

#endif // NETWORKUTIL_H
