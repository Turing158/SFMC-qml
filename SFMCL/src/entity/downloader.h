#ifndef DOWNLOADER_H
#define DOWNLOADER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QDir>
#include <QFile>
#include <QTimer>
#include <QThread>
#include "../util/stdutil.h"

class Downloader : public QObject
{
    Q_OBJECT
public:
    explicit Downloader(QObject *parent = nullptr);

    bool isFree = true;
    // QScopedPointer<QNetworkAccessManager> *manager;
    // QScopedPointer<QNetworkReply> *reply;
    QNetworkAccessManager *manager;
    QNetworkReply *reply;
    QTimer *timer;
    QUrl url;
    QString filePath;
    QString funcName;
    StdUtil su;

    void startDownload(const QUrl &url,const QString &filePath);
    void startSent();
    void taskTimeout();
    void finishDownloadFunc();
    void cancelDownload();
signals:
    void finishDownload();
    void reJoinTasks(const QString &url,const QString &filePath);
    void downloadStatus(const QString &filename,const QString &status);
};

#endif // DOWNLOADER_H
