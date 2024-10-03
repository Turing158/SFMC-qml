#include "downloader.h"

Downloader::Downloader(QObject *parent)
    : QObject{parent}
{

}

void Downloader::startDownload(const QUrl &url, const QString &filePath){
    isFree = false;
    this->url = url;
    this->filePath = filePath;
    QNetworkAccessManager *manager = new QNetworkAccessManager(this);
    manager->setTransferTimeout(10000);
    QNetworkRequest request = QNetworkRequest(url);
    reply = manager->get(request);
    connect(reply, &QNetworkReply::errorOccurred, this, &Downloader::taskTimeout);
    connect(reply, &QNetworkReply::finished, this, &Downloader::finishDownloadFunc);
}

void Downloader::taskTimeout(){
    reply->abort();
    reply->deleteLater();
    isFree = true;
    qDebug() <<"超时，重新下载:"<<url.toString();
    emit finishDownload();
    emit reJoinTasks(url.toString(),filePath);
}

void Downloader::finishDownloadFunc(){
    isFree = true;
    QByteArray data = reply->readAll();
    if (reply->error() == QNetworkReply::NoError) {
        qDebug() << "Downloaded data:" << data.size() << "bytes";
        QString parentPath = (filePath.lastIndexOf("/") != -1 ? filePath.left(filePath.lastIndexOf("/")) : filePath);
        QDir dir(parentPath);
        if(!dir.exists()){
            dir.mkpath(parentPath);
        }
        QFile file(filePath);
        if (file.open(QIODevice::WriteOnly)) {
            file.write(data);
            file.close();
            qDebug() << "下载成功:" << url;
        } else {
            qDebug() << "无法保存文件:" << filePath;
        }
    } else {
        qDebug() << "Download error:" << reply->errorString();
    }
    this->url = "";
    this->filePath = "";
    reply->deleteLater();
    emit finishDownload();
}

