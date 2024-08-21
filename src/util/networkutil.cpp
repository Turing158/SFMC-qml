#include "networkutil.h"

NetworkUtil::NetworkUtil(QObject *parent)
    : QObject{parent}
{}


QString NetworkUtil::downloadFile(QString url,QString filePath){
    qDebug()<<"正在下载："<<url;
    QNetworkRequest request(url);
    QNetworkReply *reply = manager->get(request);
    QEventLoop loop;
    connect(reply, &QNetworkReply::finished, &loop, &QEventLoop::quit);
    connect(reply, &QNetworkReply::errorOccurred, &loop, &QEventLoop::quit);

    loop.exec(); // 这里会阻塞，直到下载完成或发生错误

    if (reply->error()) {
        qDebug() << "下载失败:" << reply->errorString();
    } else {
        QFile file(filePath);
        if (file.open(QIODevice::WriteOnly)) {
            file.write(reply->readAll());
            file.close();
            qDebug() << "下载成功：" << filePath;
        } else {
            qDebug() << "无法保存文件:" << filePath;
        }
    }

    reply->deleteLater();
    return "";
}

