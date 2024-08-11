#ifndef LAUNCHERUTIL_H
#define LAUNCHERUTIL_H

#include <QObject>
#include <string>
#include <vector>
#include <dirent.h>
#include <QtQml>
#include <QString>
using namespace std;
class LauncherUtil : public QObject
{
    Q_OBJECT
    // QML_ELEMENT
public:
    explicit LauncherUtil(QObject *parent = nullptr);




    QString slashTobackslash(QString str);
    int existVersionJar(string filePath,string jarName);
    Q_INVOKABLE QVariantList findVersion(QString dirPath);
    string findNativeFile(string dirPath,string version);
    vector<string> getLibPaths(string str);
    vector<string> getLibUrls(string str);
    string getAssetIndex(string json);
    vector<string> findVersionStr(string json);
    string getClientVersion(string json);
    Q_INVOKABLE QVariantMap getVersionInfo(QString dir,QString version);
    int getSuitableJava(string json);
    Q_INVOKABLE QVariantMap getSuitableJava(QString dir,QString version);
    string getMainClass(string json);
    string getTweakClass(string json);
    int isOptifine(string json);
    int isForge(string json);
    int isFabric(string json);
    string findOptifineOrFabricVersion(string json);
    string findForgeVersion(string json);
    vector<string> splitStr(string str, string delimiter);
    string replaceStr(string original,string oldStr,string newStr);
    vector<string> getOptifineLib(string json);
    vector<string> getForgeLib(string json,vector<string> cpPath);
    vector<string> getFabricLib(string json,vector<string> cpPath);
    string getForge_pPara(string json,string libDir);
    string extraPrePara(string json,string libraryPath);
    string extraMorePara(string json,string selectDir,string selectVersion);
    string extraParaNameFml(string json);
    string readFile(string filePath);
    int existFile(string pathStr);
    Q_INVOKABLE string generateUUID();
    Q_INVOKABLE string random_str(int len);
    map<string,string> findJavaVersionFromReg(const wchar_t* regKey);
    Q_INVOKABLE QVariantMap findAllJavaVersion();
    Q_INVOKABLE QString getCurrentPath();
    Q_INVOKABLE QVariantMap getMemory();

signals:


private:

};

#endif // LAUNCHERUTIL_H
