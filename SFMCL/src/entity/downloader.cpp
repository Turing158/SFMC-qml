#include "downloader.h"

Downloader::Downloader(QObject *parent)
    : QObject{parent}
{

}

void Downloader::startDownload(const QUrl &url, const QString &filePath){
    isFree = false;
    this->url = url;
    this->filePath = filePath;
    emit downloadStatus(su.getFilenameByPath(filePath),"downloading");
    // manager = new QScopedPointer<QNetworkAccessManager>();
    manager = new QNetworkAccessManager(this);
    // manager->setTransferTimeout(10000);
    QNetworkRequest request = QNetworkRequest(url);
    request.setRawHeader("Referer", "https://bmclapi2.bangbang93.com");
    request.setRawHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36 Edg/131.0.0.0");
    reply = manager->get(request);

    // connect(reply, &QNetworkReply::errorOccurred, this, &Downloader::taskTimeout);
    connect(reply, &QNetworkReply::finished, this, &Downloader::finishDownloadFunc);
}

// void Downloader::taskTimeout(){
//     reply->abort();
//     reply->deleteLater();
//     manager->deleteLater();
//     isFree = true;
//     qDebug() <<"超时，重新下载:"<<url.toString();
//     emit finishDownload();
//     emit reJoinTasks(url.toString(),filePath);
// }

void Downloader::finishDownloadFunc(){
    isFree = true;
    if (reply->error() == QNetworkReply::NoError) {
        QByteArray data = reply->readAll();
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
            emit downloadStatus(su.getFilenameByPath(filePath),"success");
        } else {
            qDebug() << "无法保存文件:" << filePath;
            emit reJoinTasks(url.toString(),filePath);
            emit downloadStatus(su.getFilenameByPath(filePath),"error");
        }
    } else {
        emit reJoinTasks(url.toString(),filePath);
        qDebug()
            <<"========================="<<"\n"
            <<"下载失败："<<reply->url()<<"\n"
            <<"status code: "<<reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toString()<<"\n"
            << "Download error:" << reply->errorString()<<"\n"
            <<"=========================\n";
        emit downloadStatus(su.getFilenameByPath(filePath),"error");
    }
    reply->deleteLater();
    manager->deleteLater();
    this->url = "";
    this->filePath = "";

    emit finishDownload();
}

void Downloader::cancelDownload(){
    reply->deleteLater();
    manager->deleteLater();
}


