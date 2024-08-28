#include "loginutil.h"

QString LoginUtil::getUser_code() const
{
    return user_code;
}

void LoginUtil::setUser_code(const QString &newUser_code)
{
    if (user_code == newUser_code)
        return;
    user_code = newUser_code;
    emit user_codeChanged();
}

QString LoginUtil::getDevice_code() const
{
    return device_code;
}

void LoginUtil::setDevice_code(const QString &newDevice_code)
{
    if (device_code == newDevice_code)
        return;
    device_code = newDevice_code;
    emit device_codeChanged();
}

QString LoginUtil::getAccess_tokenMicrosoft() const
{
    return access_tokenMicrosoft;
}

void LoginUtil::setAccess_tokenMicrosoft(const QString &newAccess_tokenMicrosoft)
{
    if (access_tokenMicrosoft == newAccess_tokenMicrosoft)
        return;
    access_tokenMicrosoft = newAccess_tokenMicrosoft;
    emit access_tokenMicrosoftChanged();
}

QString LoginUtil::getRefresh_tokenMicrosoft() const
{
    return refresh_tokenMicrosoft;
}

void LoginUtil::setRefresh_tokenMicrosoft(const QString &newRefresh_tokenMicrosoft)
{
    if (refresh_tokenMicrosoft == newRefresh_tokenMicrosoft)
        return;
    refresh_tokenMicrosoft = newRefresh_tokenMicrosoft;
    emit refresh_tokenMicrosoftChanged();
}


LoginUtil::LoginUtil(QObject *parent)
    : QObject{parent}
{}

//登录方法：
//获取机器码和用户验证码
QString LoginUtil::getMicrosoftDeviceCode(){
    disconnect(&nu,nullptr,nullptr,nullptr);
    QVariantMap args;
    QUrl url("https://login.microsoftonline.com/consumers/oauth2/v2.0/devicecode");
    args.insert("client_id","d51b460a-0b8a-4696-af4d-690f7ba7f5b6");
    args.insert("scope","XboxLive.signin%20offline_access");
    connect(&nu,&NetworkUtil::dataReceived,this,&LoginUtil::getMicrosoftDeviceCodeHandle);
    nu.GET(url,args);
    return "MicrosoftDeviceCode";
}

//获取MicrosoftToken
QString LoginUtil::getMicrosoftToken(){
    disconnect(&nu,nullptr,nullptr,nullptr);
    QVariantMap args;
    QUrl url("https://login.microsoftonline.com/consumers/oauth2/v2.0/token");
    args.insert("client_id","d51b460a-0b8a-4696-af4d-690f7ba7f5b6");
    args.insert("grant_type","urn:ietf:params:oauth:grant-type:device_code");
    args.insert("device_code",device_code);
    connect(&nu,&NetworkUtil::dataReceived,this,&LoginUtil::getMicrosoftTokenHandle);
    nu.POST(url,args);
    return "MicrosoftToken";
}

//XBoxLive验证，获取XBox的token
QString LoginUtil::getXBoxLiveTokenAndAuthenticate(){
    qDebug()<<"getXBoxLiveTokenAndAuthenticate...";
    disconnect(&nu,nullptr,nullptr,nullptr);
    QUrl url("https://user.auth.xboxlive.com/user/authenticate");
    Json::Value root;
    Json::Value properties;
    properties["AuthMethod"] = "RPS";
    properties["SiteName"] = "user.auth.xboxlive.com";
    properties["RpsTicket"] = "d="+access_tokenMicrosoft.toStdString();
    root["Properties"] = properties;
    root["RelyingParty"] = "http://auth.xboxlive.com";
    root["TokenType"] = "JWT";
    connect(&nu,&NetworkUtil::dataReceived,this,&LoginUtil::getXBoxTokenHandle);
    nu.POST(url,root);
    return "XBoxToken";
}

//XSTS验证，获取XSTS的token
QString LoginUtil::getXSTSTokenAndAuthenticate(){
    qDebug()<<"getXSTSTokenAndAuthenticate...";
    disconnect(&nu,nullptr,nullptr,nullptr);
    QUrl url("https://xsts.auth.xboxlive.com/xsts/authorize");
    Json::Value root;
    Json::Value properties;
    properties["SandboxId"] = "RETAIL";
    Json::Value userTokens;
    userTokens.append(tokenXBox.toStdString());
    properties["UserTokens"] = userTokens;
    root["Properties"] = properties;
    root["RelyingParty"] = "rp://api.minecraftservices.com/";
    root["TokenType"] = "JWT";
    connect(&nu,&NetworkUtil::dataReceived,this,&LoginUtil::getXSTSTokenHandle);
    nu.POST(url,root);
    return "XBoxToken";
}

QString LoginUtil::getMinecraftToken(){
    qDebug()<<"getMinecraftToken...";
    disconnect(&nu,nullptr,nullptr,nullptr);
    QUrl url("https://api.minecraftservices.com/authentication/login_with_xbox");
    Json::Value root;
    root["identityToken"] = "XBL3.0 x="+uhsXSTS.toStdString()+";"+tokenXSTS.toStdString();
    connect(&nu,&NetworkUtil::dataReceived,this,&LoginUtil::getMinecraftTokenHandle);
    nu.POST(url,root);
    return "MinecraftToken";
}

QString LoginUtil::getMinecraftUUID(){
    qDebug()<<"getMinecraftUUID...";
    disconnect(&nu,nullptr,nullptr,nullptr);
    QUrl url("https://api.minecraftservices.com/minecraft/profile");
    QMap<QString,QString> header;
    header.insert("Authorization","Bearer "+tokenMinecraft);
    connect(&nu,&NetworkUtil::dataReceived,this,&LoginUtil::getMinecraftUUIDHandle);
    nu.GET(url,header);
    return "MinecraftUUID";
}





//handle

QString LoginUtil::getMicrosoftDeviceCodeHandle(QByteArray data){
    Json::Reader reader;
    Json::Value root;
    string json = data.toStdString();
    if(reader.parse(json,root)){
        if(root["error"].isNull()){
            user_code = QString::fromStdString(root["user_code"].asString());
            device_code = QString::fromStdString(root["device_code"].asString());
            emit getMicrosoftDeviceCodeData(user_code);
            getMicrosoftToken();
            return "SUCCESS";
        }
    }
    emit finishLogin(false,"MicrosoftDeviceCode_ERROR");
    return "ERROR";
}

QString LoginUtil::getMicrosoftTokenHandle(QByteArray data){
    Json::Reader reader;
    Json::Value root;
    string json = data.toStdString();
    if(reader.parse(json,root)){
        if(root["error"].isNull()){
            emit finishGetMicrosoftToken();
            access_tokenMicrosoft = QString::fromStdString(root["access_token"].asString());
            refresh_tokenMicrosoft = QString::fromStdString(root["refresh_token"].asString());
            getXBoxLiveTokenAndAuthenticate();
            return "SUCCESS";
        }
        emit repeatGetMicrosoftToken();
        qDebug()<<"等待重新检测";
    }
    return "ERROR";
}

QString LoginUtil::getXBoxTokenHandle(QByteArray data){
    Json::Reader reader;
    Json::Value root;
    string json = data.toStdString();
    if(json.empty()){
        return "ERROR";
    }
    if(reader.parse(json,root)){
        tokenXBox = QString::fromStdString(root["Token"].asString());
        uhsXBox = QString::fromStdString(root["DisplayClaims"]["xui"][0]["uhs"].asString());
        getXSTSTokenAndAuthenticate();
        return "SUCCESS";
    }
    emit finishLogin(false,"XBoxToken_ERROR");
    return "ERROR";
}

QString LoginUtil::getXSTSTokenHandle(QByteArray data){
    Json::Reader reader;
    Json::Value root;
    string json = data.toStdString();
    if(json.empty()){
        return "ERROR";
    }
    if(reader.parse(json,root)){
        tokenXSTS = QString::fromStdString(root["Token"].asString());
        uhsXSTS = QString::fromStdString(root["DisplayClaims"]["xui"][0]["uhs"].asString());
        if(uhsXSTS != uhsXBox){
            qDebug()<<"uhs出现不相同情况，但是不影响";
        }
        getMinecraftToken();
        return "SUCCESS";
    }
    emit finishLogin(false,"XSTSToken_ERROR");
    return "ERROR";
}

QString LoginUtil::getMinecraftTokenHandle(QByteArray data){
    Json::Reader reader;
    Json::Value root;
    string json = data.toStdString();
    if(reader.parse(json,root)){
        if(root["error"].isNull()){
            tokenMinecraft = QString::fromStdString(root["access_token"].asString());
            getMinecraftUUID();
            return "SUCCESS";
        }
    }
    emit finishLogin(false,"MinecraftToken_ERROR");
    return "ERROR";
}

QString LoginUtil::getMinecraftUUIDHandle(QByteArray data){
    Json::Reader reader;
    Json::Value root;
    string json = data.toStdString();
    if(reader.parse(json,root)){
        if(root["error"].isNull()){
            qDebug()<<root["id"].asString()<<root["name"].asString()<<root["skins"][0]["url"].asString();
            //  root["id"];     //UUID
            //  root["name"];       //username
            //  root["skins"][0]["url"];        //skinUrl
            successLogin(QString::fromStdString(root["name"].asString()),QString::fromStdString(root["id"].asString()),tokenMinecraft,QString::fromStdString(root["skins"][0]["url"].asString()));
            emit finishLogin(true,"登录成功");
            return "SUCCESS";
        }
    }
    emit finishLogin(false,"未获取Minecraft或Minecraft文档未刷新");
    return "ERROR";
}

void LoginUtil::clearLoginInfo(){
    user_code = "";
    device_code = "";
    access_tokenMicrosoft = "";
    refresh_tokenMicrosoft = "";
    tokenXBox = "";
    uhsXBox = "";
    tokenXSTS = "";
    uhsXSTS = "";
    tokenMinecraft = "";
}
