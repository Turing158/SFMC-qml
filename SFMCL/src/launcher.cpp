#include "launcher.h"

Launcher::Launcher(QObject *parent)
    : QObject{parent}
{}

QString Launcher::getToken() const
{
    return token;
}

void Launcher::setToken(const QString &newToken)
{
    if (token == newToken)
        return;
    token = newToken;
    emit tokenChanged();
}

QString Launcher::getJvmExtraPara() const
{
    return jvmExtraPara;
}

void Launcher::setJvmExtraPara(const QString &newJvmExtraPara)
{
    if (jvmExtraPara == newJvmExtraPara)
        return;
    jvmExtraPara = newJvmExtraPara;
    emit jvmExtraParaChanged();
}

bool Launcher::getAutoMemory() const
{
    return autoMemory;
}

void Launcher::setAutoMemory(bool newAutoMemory)
{
    if (autoMemory == newAutoMemory)
        return;
    autoMemory = newAutoMemory;
    emit autoMemoryChanged();
}

bool Launcher::getAutoJava() const
{
    return autoJava;
}

void Launcher::setAutoJava(bool newAutoJava)
{
    if (autoJava == newAutoJava)
        return;
    autoJava = newAutoJava;
    emit autoJavaChanged();
}

bool Launcher::getIsIsolate() const
{
    return isIsolate;
}

void Launcher::setIsIsolate(bool newIsIsolate)
{
    if (isIsolate == newIsIsolate)
        return;
    isIsolate = newIsIsolate;
    emit isIsolateChanged();
}

bool Launcher::getIsFullscreen() const
{
    return isFullscreen;
}

void Launcher::setIsFullscreen(bool newIsFullscreen)
{
    if (isFullscreen == newIsFullscreen)
        return;
    isFullscreen = newIsFullscreen;
    emit isFullscreenChanged();
}

QString Launcher::getJavaPath() const
{
    return javaPath;
}

void Launcher::setJavaPath(const QString &newJavaPath)
{
    if (javaPath == newJavaPath)
        return;
    javaPath = newJavaPath;
    emit javaPathChanged();
}

int Launcher::getHeight() const
{
    return height;
}

void Launcher::setHeight(int newHeight)
{
    if (height == newHeight)
        return;
    height = newHeight;
    emit heightChanged();
}

int Launcher::getWidth() const
{
    return width;
}

void Launcher::setWidth(int newWidth)
{
    if (width == newWidth)
        return;
    width = newWidth;
    emit widthChanged();
}

QString Launcher::getUuid() const
{
    return uuid;
}

void Launcher::setUuid(const QString &newUuid)
{
    if (uuid == newUuid)
        return;
    uuid = newUuid;
    emit uuidChanged();
}

QString Launcher::getUsername() const
{
    return username;
}

void Launcher::setUsername(const QString &newUsername)
{
    if (username == newUsername)
        return;
    username = newUsername;
    emit usernameChanged();
}

int Launcher::getMemoryMax() const
{
    return memoryMax;
}

void Launcher::setMemoryMax(int newMemoryMax)
{
    if (memoryMax == newMemoryMax)
        return;
    memoryMax = newMemoryMax;
    emit memoryMaxChanged();
}

QString Launcher::getSelectVersion() const
{
    return selectVersion;
}

void Launcher::setSelectVersion(const QString &newSelectVersion)
{
    if (selectVersion == newSelectVersion)
        return;
    selectVersion = newSelectVersion;
    emit selectVersionChanged();
}

QString Launcher::getSelectDir() const
{
    return selectDir;
}

void Launcher::setSelectDir(const QString &newSelectDir)
{
    if (selectDir == newSelectDir)
        return;
    selectDir = newSelectDir;
    emit selectDirChanged();
}

QString Launcher::getFramework() const
{
    return framework;
}

void Launcher::setFramework(const QString &newFramework)
{
    if (framework == newFramework)
        return;
    framework = newFramework;
    emit frameworkChanged();
}

QString Launcher::getOs() const
{
    return os;
}

void Launcher::setOs(const QString &newOs)
{
    if (os == newOs)
        return;
    os = newOs;
    emit osChanged();
}
#include <iostream>
#include <QDebug>
using namespace std;

#define WIN32_LEAN_AND_MEAN//解决了启动编译时报了一堆错的问题，但是也禁用了一些东西
#include <windows.h>

//通过创建新线程运行java虚拟机
int Launcher::run(string str,string javaExePath){
    STARTUPINFOA si;
    PROCESS_INFORMATION pi;
    ZeroMemory(&si, sizeof(si));
    si.cb = sizeof(si);
    ZeroMemory(&pi, sizeof(pi));
    char* cmdLineChars = new char[str.size() + 1];
    strcpy(cmdLineChars, str.c_str());
    if (!CreateProcessA(
            javaExePath.c_str(), // java.exe的路径
            cmdLineChars, // 命令行
            NULL, // 进程句柄不可继承
            NULL, // 线程句柄不可继承
            FALSE, // 设置句柄继承为 FALSE
            0, // 没有创建标志
            NULL, // 使用父进程的环境块
            NULL, // 使用父进程的起始目录
            &si, // 指向 STARTUPINFO 结构
            &pi) // 指向 PROCESS_INFORMATION 结构
        )   {
        cout << "CreateProcess failed (" << GetLastError() << ").\n";
        return -1;
    }
    WaitForSingleObject(pi.hProcess, INFINITE);
    CloseHandle(pi.hProcess);
    CloseHandle(pi.hThread);
    return 0;
}
#include "util/launcherutil.h"
#include "util/stdutil.h"
void Launcher::launchMcFunc(){
    qDebug()<<selectVersion<<"启动中...";
    emit initLauncherSetting();
    LauncherUtil lu;
    StdUtil su;
    QString javaExe = javaPath == "java" ? javaPath : javaPath+"\\bin\\java.exe";
    qDebug()<<"已选择Java版本："<<javaExe;
    QString launchStr1 =
        javaExe+" -Xmx"+QString::number(memoryMax)+"m "+
        "-Dfile.encoding=GB18030 -Dstdout.encoding=GB18030 -Dsun.stdout.encoding=GB18030 -Dstderr.encoding=GB18030 -Dsun.stderr.encoding=GB18030 "+
        "-Djava.rmi.server.useCodebaseOnly=true -Dcom.sun.jndi.rmi.object.trustURLCodebase=false -Dcom.sun.jndi.cosnaming.object.trustURLCodebase=false ";
    QString log4j2File = lu.slashTobackslash(selectDir)+"\\versions\\"+selectVersion+"\\log4j2.xml";
    QString clientPath = ".minecraft/versions/"+selectVersion+"/"+selectVersion+".jar";
    QString launchStr2;//参数在下面，因为路径有空格的话会报错，所有在下面集中处理了
    QString launchStr3 = "-XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32m -XX:-UseAdaptiveSizePolicy -XX:-OmitStackTraceInFastThrow -XX:-DontCompileHugeMethods -Dfml.ignoreInvalidMinecraftCertificates=true -Dfml.ignorePatchDiscrepancies=true ";
    QString launchStr4 = "-XX:HeapDumpPath=MojangTricksIntelDriversForPerformance_javaw.exe_minecraft.exe.heapdump ";
    QString launchStr5;//参数在下面，因为路径有空格的话会报错，所有在下面集中处理了
    QString launchStr6 = "-Dminecraft.launcher.brand=SFMCL -Dminecraft.launcher.version=1.0.0 ";
    QString cpStr = "";
    QString jsonContent = lu.readFile((selectDir+"/versions/"+selectVersion+"/"+selectVersion+".json").toStdString());
    emit fixAssetsFile();
    lu.fixAssetsByVersionJson(selectDir,jsonContent);
    emit getLib();
    vector<Lib> libs = lu.getLibs(su.QStringToStringLocal8Bit(jsonContent));
    emit fixNeedLibFile();
    lu.fixNeedDownloadLibFile(libs,selectDir,selectVersion,jsonContent);
    emit readyLaunch();
    vector<string> libPaths = lu.getLibPaths(libs);
    for(int i=0;i<libPaths.size();i++){
        string path = su.QStringToStringLocal8Bit(selectDir)+"/libraries/"+libPaths[i];
        if(lu.existFile(path)){
            cpStr+=QString::fromLocal8Bit(path)+";";
        }
    }
    cpStr+=selectDir+"/versions/"+selectVersion+"/"+selectVersion+".jar";
    string mainClass = lu.getMainClass(su.QStringToStringLocal8Bit(jsonContent))+" ";
    string assetIndex = lu.getAssetIndex(su.QStringToStringLocal8Bit(jsonContent));
    QString gameDir = "";
    if(isIsolate){
        gameDir += selectDir+"/versions/"+selectVersion;
    }
    else{
        gameDir += selectDir;
    }
    string nativesFolderName = lu.getAndDecompressNatives(libs,selectDir,selectVersion);
    QString libraryNativesPath = selectDir+"/versions/"+selectVersion+"/"+QString::fromLocal8Bit(nativesFolderName);
    if(su.QStringToStringLocal8Bit(selectVersion).find(" ") == string::npos){
        launchStr2 = "-Dlog4j2.formatMsgNoLookups=true -Dlog4j.configurationFile="+log4j2File+" -Dminecraft.client.jar="+clientPath+" ";
        launchStr5 = "-Djava.library.path="+libraryNativesPath+" ";
        cpStr = "-cp "+cpStr+" ";
    }
    else{
        launchStr2 = "-Dlog4j2.formatMsgNoLookups=true \"-Dlog4j.configurationFile="+log4j2File+"\" \"-Dminecraft.client.jar="+clientPath+"\" ";
        launchStr5 = "\"-Djava.library.path="+libraryNativesPath+"\" ";
        cpStr = "-cp \""+cpStr+"\" ";
        gameDir = "\""+gameDir+"\"";
    }
    QString version = selectVersion.contains(" ") ? "\""+selectVersion+"\"" : selectVersion;
    QString mcInfoStr = "--username "+username+" --version "+version+" --gameDir "+gameDir+" --assetsDir "+selectDir+"/assets --assetIndex "+QString::fromStdString(assetIndex)+" --uuid "+uuid+" --accessToken "+QString::fromStdString(su.random_str(32))+" --userType msa --versionType \"SFMCL 1.0.0\" ";
    string tweakClass = lu.getTweakClass(su.QStringToStringLocal8Bit(jsonContent));
    if(tweakClass.size()){
        mcInfoStr+="--tweakClass "+tweakClass+" ";
    }
    mcInfoStr+="--width "+to_string(width)+" --height "+to_string(height)+" ";
    // //	高版本参数
    map<string,string> extraPara = lu.findJvmExtraArgs(jsonContent,selectDir,selectVersion,"SFMCL","1.0.0");
    QString getJvmPara = QString::fromStdString(extraPara["-cpPre"]);
    QString morePara = QString::fromStdString(extraPara["-pPre"]+extraPara["-p"]);
    QString fmlPara = QString::fromStdString(lu.findGameExtraArg(jsonContent));
    QString fullscreen = isFullscreen ? "--fullscreen " : "";
    QString jvmPara = getJvmPara.isEmpty() ? launchStr4+launchStr5+launchStr6 : getJvmPara;
    QString launchStr = launchStr1+launchStr2+launchStr3+jvmPara+cpStr+morePara+QString::fromStdString(mainClass)+mcInfoStr+fmlPara+fullscreen+jvmExtraPara;
    // qDebug()<<launchStr;
    qDebug()<<"启动："<<selectVersion;
    emit startLaunch(selectVersion);
    run(su.QStringToStringLocal8Bit(launchStr),javaExe.toStdString());
    emit finishLaunch(selectVersion);
    qDebug()<<"进程结束";
}

#include <thread>
void Launcher::launchMc(){
    std::thread t(&Launcher::launchMcFunc,this);
    t.detach();
}
