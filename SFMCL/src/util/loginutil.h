#ifndef LOGINUTIL_H
#define LOGINUTIL_H

#include <QObject>
#include <QMap>
#include "networkutil.h"
#include <json/json.h>
class LoginUtil : public QObject
{
    Q_OBJECT
public:

    NetworkUtil nu;
    QString user_code;
    QString device_code;
    QString access_tokenMicrosoft;
    QString refresh_tokenMicrosoft;
    QString tokenXBox;
    QString uhsXBox;
    QString tokenXSTS;
    QString uhsXSTS;
    QString tokenMinecraft;

    explicit LoginUtil(QObject *parent = nullptr);

    const QString clientId = "11c8deff-d17f-44ae-b8cf-068200d155a8";//这个clientId本来是要去Azure上申请的，但是先借用了JMCCC内的

    Q_INVOKABLE QString getMicrosoftDeviceCode();
    Q_INVOKABLE QString getMicrosoftToken();
    QString getXBoxLiveTokenAndAuthenticate();
    QString getXSTSTokenAndAuthenticate();
    QString getMinecraftToken();
    QString getMinecraftUUID();


    QString getMicrosoftDeviceCodeHandle(QByteArray data);
    QString getMicrosoftTokenHandle(QByteArray data);
    QString getXBoxTokenHandle(QByteArray data);
    QString getXSTSTokenHandle(QByteArray data);
    QString getMinecraftTokenHandle(QByteArray data);
    QString getMinecraftUUIDHandle(QByteArray data);

    Q_INVOKABLE void clearLoginInfo();

    QString getUser_code() const;
    void setUser_code(const QString &newUser_code);

    QString getDevice_code() const;
    void setDevice_code(const QString &newDevice_code);

    QString getAccess_tokenMicrosoft() const;
    void setAccess_tokenMicrosoft(const QString &newAccess_tokenMicrosoft);

    QString getRefresh_tokenMicrosoft() const;
    void setRefresh_tokenMicrosoft(const QString &newRefresh_tokenMicrosoft);

signals:
    //反馈数据的信号
    void getMicrosoftDeviceCodeData(QString data);
    void repeatGetMicrosoftToken();
    void finishGetMicrosoftToken();
    void finishLogin(bool success,QString msg);
    void successLogin(QString username,QString UUID,QString accessToken,QString skin);

    //反馈流程的信号
    void getMicrosoftDeviceCodeSignal();
    void getMicrosoftTokenSignal();
    void getXBoxLiveTokenAndAuthenticateSignal();
    void getXSTSTokenAndAuthenticateSignal();
    void getMinecraftTokenSignal();
    void getMinecraftUUIDSignal();

    // ...
    void user_codeChanged();
    void device_codeChanged();
    void access_tokenMicrosoftChanged();
    void refresh_tokenMicrosoftChanged();

private:
    Q_PROPERTY(QString user_code READ getUser_code WRITE setUser_code NOTIFY user_codeChanged FINAL)
    Q_PROPERTY(QString device_code READ getDevice_code WRITE setDevice_code NOTIFY device_codeChanged FINAL)
    Q_PROPERTY(QString access_tokenMicrosoft READ getAccess_tokenMicrosoft WRITE setAccess_tokenMicrosoft NOTIFY access_tokenMicrosoftChanged FINAL)
    Q_PROPERTY(QString refresh_tokenMicrosoft READ getRefresh_tokenMicrosoft WRITE setRefresh_tokenMicrosoft NOTIFY refresh_tokenMicrosoftChanged FINAL)
};

#endif // LOGINUTIL_H
