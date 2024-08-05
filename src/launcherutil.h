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





    int existVersionJar(string filePath,string jarName);
    Q_INVOKABLE QVariantList findVersion(QString dirPath);
    string findNativeFile(string dirPath,string version);
    vector<string> getLibPaths(string str);
    vector<string> getLibUrls(string str);
    string getAssetIndex(string json);
    Q_INVOKABLE string getClientVersion(string json);
    string getMainClass(string json);
    string getTweakClass(string json);
    Q_INVOKABLE int isOptifine(string json);
    Q_INVOKABLE int isForge(string json);
    Q_INVOKABLE int isFabric(string json);
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
    map<string,string> findAllJavaVersion();

signals:

private:

};

#endif // LAUNCHERUTIL_H
