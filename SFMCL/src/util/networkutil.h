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
#include <QtConcurrent/QtConcurrent>
#include "stdutil.h"
#include "../entity/downloader.h"

class NetworkUtil : public QObject
{
    Q_OBJECT
public:
    explicit NetworkUtil(QObject *parent = nullptr);

    StdUtil su;
    int threadsNum = 20;
    int currentFinishNumber = 0;
    QVariantMap tasks;
    QList<Downloader*> downloaders;
    QNetworkAccessManager *manager;

    QString downloadFile(QString url,QString filePath);
    void downloadFiles(QVariantMap urlsWithFilePath);
    void downloadFilesFunc(QVariantMap urlsWithFilePath);
    void finishCurrentTask();
    void cancelDownload();
    void reJoinTasks(const QString &url,const QString &filePath);
    void GET(const QUrl &url,const QMap<QString,QString> &header);
    void GET(const QUrl &url);
    void GET(const QUrl &url,const QVariantMap &args);
    void POST(const QUrl &url,const QJsonObject &jsonData);
    void POST(const QUrl &url,const Json::Value &json);
    void POST(const QUrl &url,const QVariantMap &args);

signals:
    void dataReceived(const QByteArray &data); // 传递数据的信号
    void downloadingTips(const QString &text);
    void finishDownloadTips(const QString &text);
    void startDonwloadFiles(QVariantMap urlsWithFilePath);
    void finishDownloadTask();
private slots:
    void onReplyFinished();
};

#endif // NETWORKUTIL_H
