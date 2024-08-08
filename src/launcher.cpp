#include "launcher.h"

Launcher::Launcher(QObject *parent)
    : QObject{parent}
{}

int Launcher::getAutoMemory() const
{
    return autoMemory;
}

void Launcher::setAutoMemory(int newAutoMemory)
{
    if (autoMemory == newAutoMemory)
        return;
    autoMemory = newAutoMemory;
    emit autoMemoryChanged();
}

int Launcher::getAutoJava() const
{
    return autoJava;
}

void Launcher::setAutoJava(int newAutoJava)
{
    if (autoJava == newAutoJava)
        return;
    autoJava = newAutoJava;
    emit autoJavaChanged();
}

int Launcher::getIsIsolate() const
{
    return isIsolate;
}

void Launcher::setIsIsolate(int newIsIsolate)
{
    if (isIsolate == newIsIsolate)
        return;
    isIsolate = newIsIsolate;
    emit isIsolateChanged();
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
using namespace std;

#define WIN32_LEAN_AND_MEAN//解决了启动编译时报了一堆错的问题，但是也禁用了一些东西
#include <windows.h>

//通过创建新线程运行java虚拟机
int Launcher::run(string str){
    STARTUPINFOA si;
    PROCESS_INFORMATION pi;
    ZeroMemory(&si, sizeof(si));
    si.cb = sizeof(si);
    ZeroMemory(&pi, sizeof(pi));
    char* cmdLineChars = new char[str.size() + 1];
    strcpy(cmdLineChars, str.c_str());
    if (!CreateProcessA(
            "E:\\Programmer\\jdk-21\\bin\\java.exe", // java.exe的路径
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
#include "launcherutil.h"
void Launcher::launchMcFunc(){
    LauncherUtil lu;
    string launchStr1 =
        javaPath.toStdString()+" -Xmx"+to_string(memoryMax)+"m "+
        "-Dfile.encoding=GB18030 -Dstdout.encoding=GB18030 -Dsun.stdout.encoding=GB18030 -Dstderr.encoding=GB18030 -Dsun.stderr.encoding=GB18030 "+
        "-Djava.rmi.server.useCodebaseOnly=true -Dcom.sun.jndi.rmi.object.trustURLCodebase=false -Dcom.sun.jndi.cosnaming.object.trustURLCodebase=false ";
    string log4j2File = selectDir.toStdString()+"/versions/"+selectVersion.toStdString()+"/log4j2.xml";
    string clientPath = ".minecraft/versions/"+selectVersion.toStdString()+"/"+selectVersion.toStdString()+".jar";
    string launchStr2;//参数在下面，因为路径有空格的话会报错，所有在下面集中处理了
    string launchStr3 = "-XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32m -XX:-UseAdaptiveSizePolicy -XX:-OmitStackTraceInFastThrow -XX:-DontCompileHugeMethods ";
    string launchStr4 = "-Dfml.ignoreInvalidMinecraftCertificates=true -Dfml.ignorePatchDiscrepancies=true -XX:HeapDumpPath=MojangTricksIntelDriversForPerformance_javaw.exe_minecraft.exe.heapdump ";
    string libraryPath = selectDir.toStdString()+"/versions/"+selectVersion.toStdString()+"/"+lu.findNativeFile(selectDir.toStdString(),selectVersion.toStdString());
    string launchStr5;//参数在下面，因为路径有空格的话会报错，所有在下面集中处理了
    string launchStr6 = "-Dminecraft.launcher.brand=CMDL -Dminecraft.launcher.version=1.0.0 ";
    string cpStr = "";
    string jsonContent = lu.readFile(selectDir.toStdString()+"/versions/"+selectVersion.toStdString()+"/"+selectVersion.toStdString()+".json");
    vector<string> CpPaths = lu.getLibPaths(jsonContent);
    if(lu.isOptifine(jsonContent)){
        vector<string> optifineLibPaths = lu.getOptifineLib(jsonContent);
        for(int i=0;i<optifineLibPaths.size();i++){
            string path = selectDir.toStdString()+"/libraries/"+optifineLibPaths[i];
            if(lu.existFile(path)){
                cpStr+=path+";";
            }
        }
    }
    if(lu.isForge(jsonContent)){
        vector<string> forgeLibPaths = lu.getForgeLib(jsonContent,CpPaths);
        for(int i=0;i<forgeLibPaths.size();i++){
            string path = selectDir.toStdString()+"/libraries/"+forgeLibPaths[i];
            if(lu.existFile(path)){
                cpStr+=path+";";
            }
        }
    }
    if(lu.isFabric(jsonContent)){
        vector<string> fabricLibPaths = lu.getFabricLib(jsonContent,CpPaths);
        for(int i=0;i<fabricLibPaths.size();i++){
            string path = selectDir.toStdString()+"/libraries/"+fabricLibPaths[i];
            if(lu.existFile(path)){
                cpStr+=path+";";
            }
        }
    }
    for(int i=0;i<CpPaths.size();i++){
        string path = selectDir.toStdString()+"/libraries/"+CpPaths[i];
        if(lu.existFile(path)){
            cpStr+=path+";";
        }
    }
    cpStr+=selectDir.toStdString()+"/versions/"+selectVersion.toStdString()+"/"+selectVersion.toStdString()+".jar";
    string mainClass = lu.getMainClass(jsonContent)+" ";
    string assetIndex = lu.getAssetIndex(jsonContent);
    string gameDir = "";
    if(isIsolate){
        gameDir += selectDir.toStdString()+"/versions/"+selectVersion.toStdString();
    }
    else{
        gameDir += selectDir.toStdString();
    }
    if(selectVersion.toStdString().find(" ") == string::npos){
        launchStr2 = "-Dlog4j2.formatMsgNoLookups=true -Dlog4j.configurationFile="+log4j2File+" -Dminecraft.client.jar="+clientPath+" ";
        launchStr5 = "-Djava.library.path="+libraryPath+" ";
        cpStr = "-cp "+cpStr+" ";
    }
    else{
        launchStr2 = "-Dlog4j2.formatMsgNoLookups=true \"-Dlog4j.configurationFile="+log4j2File+"\" \"-Dminecraft.client.jar="+clientPath+"\" ";
        launchStr5 = "\"-Djava.library.path="+libraryPath+"\" ";
        cpStr = "-cp \""+cpStr+"\" ";
        gameDir = "\""+gameDir+"\"";
    }
    string version = selectVersion.toStdString().find(" ") != string::npos ? "\""+selectVersion.toStdString()+"\"" : selectVersion.toStdString();
    string mcInfoStr = "--username "+username.toStdString()+" --version "+version+" --gameDir "+gameDir+" --assetsDir "+selectDir.toStdString()+"/assets --assetIndex "+assetIndex+" --uuid "+uuid.toStdString()+" --accessToken "+lu.random_str(32)+" --userType msa --versionType \"CMDL 1.0.0\" ";
    string tweakClass = lu.getTweakClass(jsonContent);
    if(tweakClass.size()){
        mcInfoStr+="--tweakClass "+tweakClass+" ";
    }
    mcInfoStr+="--width "+to_string(width)+" --height "+to_string(height)+" ";
    //	1.20Forge参数
    string prePara = lu.extraPrePara(jsonContent,libraryPath);
    string morePara = lu.extraMorePara(jsonContent,selectDir.toStdString(),selectVersion.toStdString());
    string fmlPara = lu.extraParaNameFml(jsonContent);
    string launchStr = launchStr1+launchStr2+launchStr3+launchStr4+launchStr5+prePara+launchStr6+cpStr+morePara+mainClass+mcInfoStr+fmlPara;
    // cout<<launchStr<<endl;
    run(launchStr);
    cout<<"进程已关闭"<<endl;
}

#include <thread>
void Launcher::launchMc(){
    std::thread t(&Launcher::launchMcFunc,this);
    t.detach();
}
