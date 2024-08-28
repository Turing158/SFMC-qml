#ifndef LAUNCHER_H
#define LAUNCHER_H

#include <QObject>

using namespace std;
class Launcher : public QObject
{
    Q_OBJECT
public:
    explicit Launcher(QObject *parent = nullptr);

    QString os;
    QString framework = "x64";//系统架构
    QString selectDir = "";//.minecraft路径
    QString selectVersion = "";//当前选择的Minecraft版本
    bool autoMemory = true;
    int memoryMax = 0;//最大内存
    QString username = "";//Minecraft用户名称
    QString uuid = "";//用户UUID
    QString token = "";//MinecraftToken
    int width = 854;//游戏窗口宽度
    int height = 480;//游戏窗口高度
    bool autoJava = true;
    QString javaPath = "";//java.exe路径
    bool isIsolate = false;//是否版本分离
    bool isFullscreen = false;
    QString jvmExtraPara = "";

    int run(string str,string javaExePath);
    void launchMcFunc();
    Q_INVOKABLE void launchMc();

    QString getOs() const;
    void setOs(const QString &newOs);

    QString getFramework() const;
    void setFramework(const QString &newFramework);

    QString getSelectDir() const;
    void setSelectDir(const QString &newSelectDir);

    QString getSelectVersion() const;
    void setSelectVersion(const QString &newSelectVersion);

    int getMemoryMax() const;
    void setMemoryMax(int newMemoryMax);

    QString getUsername() const;
    void setUsername(const QString &newUsername);

    QString getUuid() const;
    void setUuid(const QString &newUuid);

    int getWidth() const;
    void setWidth(int newWidth);

    int getHeight() const;
    void setHeight(int newHeight);

    QString getJavaPath() const;
    void setJavaPath(const QString &newJavaPath);

    bool getIsFullscreen() const;
    void setIsFullscreen(bool newIsFullscreen);

    bool getIsIsolate() const;
    void setIsIsolate(bool newIsIsolate);

    bool getAutoJava() const;
    void setAutoJava(bool newAutoJava);

    bool getAutoMemory() const;
    void setAutoMemory(bool newAutoMemory);

    QString getJvmExtraPara() const;
    void setJvmExtraPara(const QString &newJvmExtraPara);

    QString getToken() const;
    void setToken(const QString &newToken);

signals:
    void osChanged();
    void frameworkChanged();

    void selectDirChanged();

    void selectVersionChanged();

    void memoryMaxChanged();

    void usernameChanged();

    void uuidChanged();

    void widthChanged();

    void heightChanged();

    void javaPathChanged();

    void isFullscreenChanged();

    void isIsolateChanged();

    void autoJavaChanged();

    void autoMemoryChanged();

    void jvmExtraParaChanged();

    void tokenChanged();

private:
    Q_PROPERTY(QString os READ getOs WRITE setOs NOTIFY osChanged FINAL)
    Q_PROPERTY(QString framework READ getFramework WRITE setFramework NOTIFY frameworkChanged FINAL)
    Q_PROPERTY(QString selectDir READ getSelectDir WRITE setSelectDir NOTIFY selectDirChanged FINAL)
    Q_PROPERTY(QString selectVersion READ getSelectVersion WRITE setSelectVersion NOTIFY selectVersionChanged FINAL)
    Q_PROPERTY(int memoryMax READ getMemoryMax WRITE setMemoryMax NOTIFY memoryMaxChanged FINAL)
    Q_PROPERTY(QString username READ getUsername WRITE setUsername NOTIFY usernameChanged FINAL)
    Q_PROPERTY(QString uuid READ getUuid WRITE setUuid NOTIFY uuidChanged FINAL)
    Q_PROPERTY(int width READ getWidth WRITE setWidth NOTIFY widthChanged FINAL)
    Q_PROPERTY(int height READ getHeight WRITE setHeight NOTIFY heightChanged FINAL)
    Q_PROPERTY(QString javaPath READ getJavaPath WRITE setJavaPath NOTIFY javaPathChanged FINAL)
    Q_PROPERTY(bool isFullscreen READ getIsFullscreen WRITE setIsFullscreen NOTIFY isFullscreenChanged FINAL)
    Q_PROPERTY(bool isIsolate READ getIsIsolate WRITE setIsIsolate NOTIFY isIsolateChanged FINAL)
    Q_PROPERTY(bool autoJava READ getAutoJava WRITE setAutoJava NOTIFY autoJavaChanged FINAL)
    Q_PROPERTY(bool autoMemory READ getAutoMemory WRITE setAutoMemory NOTIFY autoMemoryChanged FINAL)
    Q_PROPERTY(QString jvmExtraPara READ getJvmExtraPara WRITE setJvmExtraPara NOTIFY jvmExtraParaChanged FINAL)
    Q_PROPERTY(QString token READ getToken WRITE setToken NOTIFY tokenChanged FINAL)
};

#endif // LAUNCHER_H
