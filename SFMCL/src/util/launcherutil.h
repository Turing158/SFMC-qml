#ifndef LAUNCHERUTIL_H
#define LAUNCHERUTIL_H

#include <QObject>
#include <string>
#include <vector>
#include <dirent.h>
#include <QtQml>
#include <QString>
#include <json/json.h>
#include "../entity/lib.h"
#include "stdutil.h"
#include "networkutil.h"
using namespace std;
class LauncherUtil : public QObject
{
    Q_OBJECT
    // QML_ELEMENT
public:
    explicit LauncherUtil(QObject *parent = nullptr);

    StdUtil su;
    NetworkUtil nu;
    const QString mirrorUrl = "https://bmclapi2.bangbang93.com";
    const QString optifineDownloadUrl = mirrorUrl + "/optifine";
    const QString librariesDownloadUrl = mirrorUrl + "/maven";
    const QString assetIndexDownloadUrl = mirrorUrl;
    const QString assetsFileDownloadUrl = mirrorUrl + "/assets";

    QString slashTobackslash(QString str);
    int existVersionJar(QString filePath,QString jarName);
    Q_INVOKABLE QVariantList findVersion(QString dirPath);
    Q_INVOKABLE bool isDefaultIsolate(QString selectDir,QString selectVersion);
    void moveDllToTopLevelAndDelOtherFile(QString path,QString topLevePath);
    bool delPathAllFolder(QString path);
    bool decompressJar(QString jarPath,QString outPutDir);
    string getAndDecompressNatives(vector<Lib>libs,QString gameDir,QString gameVersion);
    vector<Lib> JsonToLib(Json::Value libs);
    vector<Lib> getLibs(string json);
    vector<string> getLibPaths(vector<Lib> lib);
    string getOnlyString(string json,string key);
    string getAssetIndex(string json);
    string getVersionInPatchesById(string json,string key);
    string getClientVersion(string json);
    Q_INVOKABLE QVariantMap getVersionInfo(QString dir,QString version);
    string getMainClass(string json);
    Q_INVOKABLE QVariantMap getSuitableJava(QString dir,QString version);
    string getTweakClass(string json);
    int isOptifine(string json);
    int isForge(string json);
    int isFabric(string json);
    string getOptifineVersion(string json);
    string getForgeVersion(string json);
    string getFabricVersion(string json);
    string findGameExtraArg(QString json);
    map<string,string> findJvmExtraArgs(QString json,QString gameDir,QString gameVersion,QString launcherName,QString launcherVersion);
    QString readFile(QString filePath);
    QString readFile(string filePath);
    bool existFile(QString pathStr);
    bool existFile(string pathStr);
    Q_INVOKABLE QString generateUUID();
    map<string,string> findJavaVersionFromReg(const wchar_t* regKey);
    Q_INVOKABLE QVariantMap findAllJavaVersion();
    Q_INVOKABLE QString getCurrentPath();
    Q_INVOKABLE QVariantMap getMemory();
    bool fixNeedDownloadLibFile(vector<Lib> libs,QString gameDir, QString gameVersion);
    bool fixAssetsByVersionJson(QString gameDir , QString jsonContent);
    Q_INVOKABLE bool fixAssetsByVersionPath(QString seleceDir, QString selectVersion);
    Q_INVOKABLE bool openFolder(QString url);
    Q_INVOKABLE bool fixAllResourcesFile(QString selectDir,QString selectVersion);
    map<string,string> getOptifineJarInfoByPath(string path);
    bool installOptifineByInstaller(QString installerPath, map<string,string> optifineInfo, QString gameDir, QString gameVersion);
    Q_INVOKABLE bool deleteDirContentsAndDir(QString dirPath);

signals:


private:

};

#endif // LAUNCHERUTIL_H
