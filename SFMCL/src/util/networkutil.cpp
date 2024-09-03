#include "networkutil.h"
using namespace std;
NetworkUtil::NetworkUtil(QObject *parent)
    : QObject{parent} ,manager(new QNetworkAccessManager(this)){

}

//  下载文件方法
QString NetworkUtil::downloadFile(QString url,QString filePath){
    if(url.isEmpty() || filePath.isEmpty()){
        return "URL_OR_PATH_IS_EMPTY";
    }
    qDebug()<<"正在下载："<<url;
    emit downloadingTips("正在下载："+QFileInfo(filePath).fileName());
    QString fileFolderPath = su.getPathParentPath(filePath);
    QNetworkRequest request(url);
    QNetworkReply *reply = manager->get(request);
    QEventLoop loop;
    connect(reply, &QNetworkReply::finished, &loop, &QEventLoop::quit);
    connect(reply, &QNetworkReply::errorOccurred, &loop, &QEventLoop::quit);

    loop.exec(); // 这里会阻塞，直到下载完成或发生错误
    QString resultText;
    if (reply->error()) {
        qDebug() << "下载失败:" << reply->errorString();
        resultText = "下载失败:"+ QFileInfo(filePath).fileName();
    } else {
        QFile file(filePath);
        QDir dir(fileFolderPath);
        if(!dir.exists()){
            dir.mkpath(fileFolderPath);
        }
        if (file.open(QIODevice::WriteOnly)) {
            file.write(reply->readAll());
            file.close();
            qDebug() << "下载成功:" << url;
            resultText =  "下载成功:"+QFileInfo(filePath).fileName();
        } else {
            qDebug() << "无法保存文件:" << filePath;
            resultText = "无法保存文件:" + QFileInfo(filePath).fileName();
        }
    }
    emit finishDownloadTips(resultText);
    reply->deleteLater();
    return "DOWNLOAD_COMPLETE";
}

//GET请求，可传header
void NetworkUtil::GET(const QUrl &url,const QMap<QString,QString> &header){
    QNetworkRequest request(url);
    for(const auto &pair : header.toStdMap()){
        request.setRawHeader(pair.first.toUtf8(),pair.second.toUtf8());
    }
    QNetworkReply *reply = manager->get(request);
    connect(reply, &QNetworkReply::finished, this, &NetworkUtil::onReplyFinished);
}

//GET请求，纯url
void NetworkUtil::GET(const QUrl &url){
    QMap<QString,QString> empty;
    GET(url,empty);
}

//GET请求，map作为后面接入要传的值
void NetworkUtil::GET(const QUrl &url,const QVariantMap &args){
    QString newUrlStr = url.toString()+"?";
    int i = 0;
    for(const auto &pair : args.toStdMap()){
        newUrlStr+=pair.first+"="+pair.second.toString();
        if(i != args.size()-1){
            newUrlStr+="&";
        }
        i++;
    }
    QUrl newUrl(newUrlStr);
    GET(newUrl);
}

// POST请求，QJsonObject对象传值
void NetworkUtil::POST(const QUrl &url,const QJsonObject &json){
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader,"application/json");
    QJsonDocument doc(json);
    QByteArray jsonDataByteArray = doc.toJson(QJsonDocument::Compact);
    QNetworkReply *reply = manager->post(request, jsonDataByteArray);
    connect(reply, &QNetworkReply::finished, this, &NetworkUtil::onReplyFinished);
}

// POST请求，Json::Value对象传值
void NetworkUtil::POST(const QUrl &url,const Json::Value &json){
    if(json.isNull()){
        POST(url,QJsonObject());
    }
    Json::StyledStreamWriter writer;
    std::ostringstream out;
    writer.write(out, json);
    QString jsonQString = QString::fromStdString(out.str());
    QJsonParseError jsonError;
    QJsonDocument doc = QJsonDocument::fromJson(jsonQString.toUtf8(), &jsonError);
    if (jsonError.error != QJsonParseError::NoError) {
        qDebug() << "JSON parsing error:" << jsonError.errorString();
        return;
    }
    POST(url,doc.object());
}

// POST请求，Json::Value对象传值
void NetworkUtil::POST(const QUrl &url,const QVariantMap &args){
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader,"application/x-www-form-urlencoded");
    QUrlQuery query;
    for (const auto &pair : args.toStdMap()) {
        query.addQueryItem(pair.first, pair.second.toString());
    }
    QByteArray postDataBytes;
    int i = 0;
    for(const auto &pair : args.toStdMap()){
        postDataBytes.append(QUrl::toPercentEncoding(pair.first));
        postDataBytes.append("=");
        postDataBytes.append(QUrl::toPercentEncoding(pair.second.toString()));
        if(i != args.size()-1){
            postDataBytes.append("&");
        }
        i++;
    }
    QNetworkReply *reply = manager->post(request, postDataBytes);
    connect(reply, &QNetworkReply::finished, this, &NetworkUtil::onReplyFinished);
}

//数据返回方法
void NetworkUtil::onReplyFinished(){
    QNetworkReply *reply = qobject_cast<QNetworkReply *>(sender());
    if (!reply) return;

    if (reply->error()) {
        qDebug() << "Error:" << reply->errorString();
    }
    emit dataReceived(reply->readAll());
    reply->deleteLater();
}

