#include "downloadutil.h"

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

QVariantMap DownloadUtil::getMinecreftListFromJson(const QByteArray &data){
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
