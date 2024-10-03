#ifndef DOWNLOADER_H
#define DOWNLOADER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QDir>
#include <QFile>
#include <QTimer>

class Downloader : public QObject
{
    Q_OBJECT
public:
    explicit Downloader(QObject *parent = nullptr);

    bool isFree = true;
    QNetworkReply *reply;
    QTimer *timer;
    QUrl url;
    QString filePath;


    void startDownload(const QUrl &url,const QString &filePath);
    void taskTimeout();
    void finishDownloadFunc();
signals:
    void finishDownload();
    void reJoinTasks(const QString &url,const QString &filePath);
};

#endif // DOWNLOADER_H
