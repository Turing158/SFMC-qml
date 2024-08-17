#ifndef LAUNCHERUTIL_H
#define LAUNCHERUTIL_H

#include <QObject>
#include <string>
#include <vector>
#include <dirent.h>
#include <QtQml>
#include <QString>
#include <json/json.h>
#include "stdutil.h"
using namespace std;
class LauncherUtil : public QObject
{
    Q_OBJECT
    // QML_ELEMENT
public:
    explicit LauncherUtil(QObject *parent = nullptr);

    StdUtil su;


    QString slashTobackslash(QString str);
    int existVersionJar(QString filePath,QString jarName);
    Q_INVOKABLE QVariantList findVersion(QString dirPath);
    QString findNativeFolder(QString dirPath,QString version);
    vector<string> libNameToPath(Json::Value libs);
    vector<string> getLibPaths(string str);
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
    QString readFile(string filePath);
    int existFile(string pathStr);
    Q_INVOKABLE QString generateUUID();
    map<string,string> findJavaVersionFromReg(const wchar_t* regKey);
    Q_INVOKABLE QVariantMap findAllJavaVersion();
    Q_INVOKABLE QString getCurrentPath();
    Q_INVOKABLE QVariantMap getMemory();
    string zlibDecompress(const vector<unsigned char>& input);
    Q_INVOKABLE string decompressNative();

signals:


private:

};

#endif // LAUNCHERUTIL_H
