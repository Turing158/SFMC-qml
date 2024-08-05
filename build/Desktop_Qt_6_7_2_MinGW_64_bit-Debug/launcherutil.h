#ifndef LAUNCHERUTIL_H
#define LAUNCHERUTIL_H

#include <QObject>
#include <string>
#include <vector>
#include <dirent.h>
#include <QtQml>
using namespace std;
class LauncherUtil : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit LauncherUtil(QObject *parent = nullptr);



    QVariantList _versions;



    int existVersionJar(string filePath,string jarName);
    Q_INVOKABLE vector<string> findVersion(QString dirPath);
    string findNativeFile(string dirPath,string version);
    vector<string> getLibPaths(string str);
    vector<string> getLibUrls(string str);
    string getAssetIndex(string json);
    string getMainClass(string json);
    string getTweakClass(string json);
    int isOptifine(string json);
    int isForge(string json);
    int isFabric(string json);
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
    string generateUUID();
    string random_str(int len);
    static LauncherUtil * getInstance();
    QVariantList versions() const;
    void setVersions(const QVariantList &newVersions);

signals:
    void versionsChanged();
private:

    Q_PROPERTY(QVariantList versions READ versions WRITE setVersions NOTIFY versionsChanged FINAL)
};

#endif // LAUNCHERUTIL_H
