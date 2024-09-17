#include "downloadutil.h"
#include <unordered_set>

DownloadUtil::DownloadUtil(QObject *parent)
    : QObject{parent}
{

}

void DownloadUtil::getMinecraftList(){
    disconnect(&nu,nullptr,nullptr,nullptr);
    connect(&nu,&NetworkUtil::dataReceived,this,&DownloadUtil::getMinecreftListFromJson);
    QUrl url("https://bmclapi2.bangbang93.com/mc/game/version_manifest_v2.json");
    nu.GET(url);
}

void DownloadUtil::getMinecraftOfSupportingOptifine(){
    disconnect(&nu,nullptr,nullptr,nullptr);
    connect(&nu,&NetworkUtil::dataReceived,this,&DownloadUtil::getMinecraftOfSupportingOptifineFromJson);
    QUrl url("https://bmclapi2.bangbang93.com/optifine/versionList");
    nu.GET(url);
}

void DownloadUtil::getMinecraftOfSupportingLiteloader(){
    disconnect(&nu,nullptr,nullptr,nullptr);
    connect(&nu,&NetworkUtil::dataReceived,this,&DownloadUtil::getMinecraftOfSupportingLiteloaderFromJson);
    QUrl url("https://bmclapi2.bangbang93.com/liteloader/list");
    nu.GET(url);
}

void DownloadUtil::getMinecraftOfSupportingForge(){
    disconnect(&nu,nullptr,nullptr,nullptr);
    connect(&nu,&NetworkUtil::dataReceived,this,&DownloadUtil::getMinecraftOfSupportingForgeFromJson);
    QUrl url("https://bmclapi2.bangbang93.com/forge/minecraft");
    nu.GET(url);
}

void DownloadUtil::getMinecraftOfSupportingNeoForge(){
    disconnect(&nu,nullptr,nullptr,nullptr);
    connect(&nu,&NetworkUtil::dataReceived,this,&DownloadUtil::getMinecraftOfSupportingNeoForgeFromJson);
    QUrl url("https://maven.neoforged.net/api/maven/versions/releases/net/neoforged/neoforge");
    nu.GET(url);
}

void DownloadUtil::getMinecraftOfSupportingFabric(){
    disconnect(&nu,nullptr,nullptr,nullptr);
    connect(&nu,&NetworkUtil::dataReceived,this,&DownloadUtil::getMinecraftOfSupportingFabricFromJson);
    QUrl url("https://bmclapi2.bangbang93.com/fabric-meta/v2/versions/game");
    nu.GET(url);
}



QVariantMap DownloadUtil::getMinecreftListFromJson(const QByteArray &data){
    if(data.isEmpty()){
        emit errorGetMinecraftList();
        return QVariantMap();
    }
    getMinecraftOfSupportingOptifine();
    string json = data.toStdString();
    Json::Reader reader;
    Json::Value root;
    QVariantMap minecraftMap;
    QVariantList latestList;
    QVariantList releaseList;
    QVariantList snapshotList;
    QVariantList foolsList;
    QVariantList oldVersionList;
    if(reader.parse(json,root)){
        auto latest = root["latest"];
        latestList.append(QString::fromStdString(latest["release"].asString()));
        latestList.append(QString::fromStdString(latest["snapshot"].asString()));
        auto versions = root["versions"];
        for(const auto &ele : versions){

            QString id = QString::fromStdString(ele["id"].asString());
            QString time = QString::fromStdString(ele["releaseTime"].asString());
            if(time.contains("04-01")){
                foolsList.append(id);
                continue;
            }
            if(ele["type"].asString() == "release"){
                releaseList.append(id);
            }
            else if(ele["type"].asString() == "snapshot"){
                snapshotList.append(id);
            }
            else{
                oldVersionList.append(id);
            }
        }
        minecraftMap.insert("latest",latestList);
        minecraftMap.insert("release",releaseList);
        minecraftMap.insert("snapshot",snapshotList);
        minecraftMap.insert("fools",foolsList);
        minecraftMap.insert("olds",oldVersionList);
    }
    emit returnGetMinecraftList(minecraftMap);
    return minecraftMap;
}

QVariantList DownloadUtil::getMinecraftOfSupportingOptifineFromJson(const QByteArray &data){
    QVariantList re;
    if(data.isEmpty()){
        emit errorGetMinecraftList();
        return re;
    }
    getMinecraftOfSupportingLiteloader();
    string json = data.toStdString();
    Json::Reader reader;
    Json::Value root;
    unordered_set<string> set;
    if(reader.parse(json,root)){
        for(const auto &ele : root){
            string eleStr = ele["mcversion"].asString();
            if(set.find(eleStr) == set.end()){
                set.insert(eleStr);
                //为了解决1.9.0和1.8.0的问题
                if(eleStr.find(".0") != string::npos){
                    eleStr = eleStr.substr(0,eleStr.length()-2);
                }
                re.append(QString::fromStdString(eleStr));
            }
        }
    }
    emit returnMinecraftOfSupportingOptifine(re);
    return re;
}

QVariantList DownloadUtil::getMinecraftOfSupportingLiteloaderFromJson(const QByteArray &data){
    QVariantList re;
    if(data.isEmpty()){
        emit errorGetMinecraftList();
        return re;
    }
    getMinecraftOfSupportingForge();
    string json = data.toStdString();
    Json::Reader reader;
    Json::Value root;
    unordered_set<string> set;
    if(reader.parse(json,root)){
        for(const auto &ele : root){
            string eleStr = ele["mcversion"].asString();
            if(set.find(eleStr) == set.end()){
                set.insert(eleStr);
                re.append(QString::fromStdString(eleStr));
            }
        }
    }
    emit returnMinecraftOfSupportingLiteloader(re);
    return re;
}

QVariantList DownloadUtil::getMinecraftOfSupportingForgeFromJson(const QByteArray &data){
    QVariantList re;
    if(data.isEmpty()){
        emit errorGetMinecraftList();
        return re;
    }
    getMinecraftOfSupportingNeoForge();
    string json = data.toStdString();
    Json::Reader reader;
    Json::Value root;
    if(reader.parse(json,root)){
        for(const auto &ele : root){
            re.append(QString::fromStdString(ele.asString()));
        }
    }
    emit returnMinecraftOfSupportingForge(re);
    return re;
}

QVariantList DownloadUtil::getMinecraftOfSupportingNeoForgeFromJson(const QByteArray &data){
    QVariantList re;
    if(data.isEmpty()){
        emit errorGetMinecraftList();
        return re;
    }
    getMinecraftOfSupportingFabric();
    string json = data.toStdString();
    Json::Reader reader;
    Json::Value root;
    unordered_set<string> set;
    if(reader.parse(json,root)){
        for(const auto &ele : root["versions"]){
            string eleStr = ele.asString().substr(0,4);
            if(set.find(eleStr) != set.end()){
                continue;
            }
            set.insert(eleStr);
            if(eleStr.find(".0") != string::npos){
                eleStr = eleStr.substr(0,2);
            }
            re.append(QString::fromStdString("1."+eleStr));
        }
    }
    emit returnMinecraftOfSupportingNeoForge(re);
    return re;
}

QVariantList DownloadUtil::getMinecraftOfSupportingFabricFromJson(const QByteArray &data){
    QVariantList re;
    if(data.isEmpty()){
        emit errorGetMinecraftList();
        return re;
    }
    string json = data.toStdString();
    Json::Reader reader;
    Json::Value root;
    if(reader.parse(json,root)){
        for(const auto &ele : root){
            re.append(QString::fromStdString(ele["version"].asString()));
        }
    }
    emit returnMinecraftOfSupportingFabric(re);
    return re;
}
