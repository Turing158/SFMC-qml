#include "launcherutil.h"

LauncherUtil::LauncherUtil(QObject *parent)
    : QObject{parent}
{}

#include <iostream>
#include <string>
#include <QVariantList>
#include <QString>
using namespace std;

QString LauncherUtil::slashTobackslash(QString str){
    QVector<QString> list = str.split("/");
    QString re;
    for (int var = 0; var < list.size(); ++var) {
        re.append(list[var]);
        if(var != list.size()-1){
            re.append("\\");
        }
    }
    return re;
}

#include <dirent.h>
//判断versions里的文件夹是否为minecraft的核心jar储存文件夹
int LauncherUtil::existVersionJar(string filePath,string jarName){
    string folderPath = filePath+"/"+jarName;
    DIR* dir;
    if ((dir = opendir(folderPath.c_str())) != nullptr) {
        struct dirent* entry;
        while ((entry = readdir(dir)) != nullptr) {
            if(entry->d_name == jarName+".jar"){
                return 1;
            }
        }
        closedir(dir);
    }
    return 0;
}
//查找Minecraft版本
QVariantList LauncherUtil::findVersion(QString dirPath){
    QVariantList version;
    string folderPath = dirPath.toStdString()+"/versions";
    DIR* dir;
    if ((dir = opendir(folderPath.c_str())) != nullptr) {
        struct dirent* entry;
        int index=0;
        while ((entry = readdir(dir)) != nullptr) {
            if(index == 2){
                if(existVersionJar(folderPath,entry->d_name) == 1){
                    version.append(QString::fromStdString(entry->d_name));
                }
            }
            else{
                index++;
            }
        }
        closedir(dir);
    }
    return version;
}

//查找版本的动态链接库native文件夹
string LauncherUtil::findNativeFile(string dirPath,string version){
    string folderPath = dirPath+"/versions/"+version+"/";
    DIR* dir;
    if ((dir = opendir(folderPath.c_str())) != nullptr) {
        struct dirent* entry;
        while ((entry = readdir(dir)) != nullptr) {
            string str = entry->d_name;
            if(str.find("natives")!=string::npos){
                return entry->d_name;
            }
        }
        closedir(dir);
    }
    return "NOT_FOUND";
}

#include <regex>
#include <iostream>
//获取Minecraft的基础lib文件的路径
vector<string> LauncherUtil::getLibPaths(string str){
    vector<string> libPaths;
    try {
        regex pathRegex("(\"path\": \")([^\"]+)(\")");

        auto pos = sregex_iterator(str.begin(), str.end(), pathRegex);
        auto end = sregex_iterator();
        while (pos != end) {
            string pathValue = pos->str(2);
            if(pathValue.find("linux")==string::npos && pathValue.find("osx")==string::npos && pathValue.find("macos")==string::npos){//windows系统
                auto flag = find(libPaths.begin(), libPaths.end(), pathValue);
                if(flag == libPaths.end()){
                    libPaths.push_back(pathValue);
                }
            }
            ++pos;
        }
    } catch (const regex_error& e) {
        cerr << "Regex error: " << e.what() << endl;
        throw;
    }
    return libPaths;
}


//获取Minecraft的基础lib文件的下载链接
vector<string> LauncherUtil::getLibUrls(string str){
    vector<string> libUrls;
    try {
        regex pathRegex("(\"url\": \")([^\"]+)(\")");
        auto pos = sregex_iterator(str.begin(), str.end(), pathRegex);
        auto end = sregex_iterator();
        ++pos;//用于去除Mc的Json文件最顶部的url
        while (pos != end) {
            string pathValue = pos->str(2);
            libUrls.push_back(pathValue);
            ++pos;
        }
    } catch (const regex_error& e) {
        cerr << "Regex error: " << e.what() << endl;
        throw;
    }
    return libUrls;
}


//获取 assetsIndex参数
string LauncherUtil::getAssetIndex(string json){
    string re;
    try {
        regex pathRegex("(\"assets\": \")([^\"]+)(\",)");
        auto pos = sregex_iterator(json.begin(), json.end(), pathRegex);
        auto end = sregex_iterator();
        while (pos != end) {
            re = pos->str(2);
            ++pos;
        }
    } catch (const regex_error& e) {
        cerr << "Regex error: " << e.what() << endl;
        throw;
    }
    return re;
}
// 获取所有version字段
vector<string> LauncherUtil::findVersionStr(string json){
    vector<string> tmp;
    try {
        regex pathRegex("(\"version\": \")([^\"]+)(\",)");

        auto pos = sregex_iterator(json.begin(), json.end(), pathRegex);
        auto end = sregex_iterator();
        while (pos != end) {
            tmp.push_back(pos->str(2));
            ++pos;
        }
    } catch (const regex_error& e) {
        cerr << "Regex error: " << e.what() << endl;
        throw;
    }
    return tmp;
}

//获取 ClientVersion参数
string LauncherUtil::getClientVersion(string json){
    string re = getAssetIndex(json);
    return re.length() <= 1 ? findVersionStr(json)[0] : re;
}
// 获取一些版本信息
QVariantMap LauncherUtil::getVersionInfo(QString dir,QString version){
    QVariantMap re;
    string json = readFile(dir.toStdString()+"/versions/"+version.toStdString()+"/"+version.toStdString()+".json");
    re.insert("client",QString::fromStdString(getClientVersion(json)));
    re.insert("loader","");
    re.insert("loaderVersion","");
    if(isFabric(json)){
        re.insert("loader","Fabric");
        re.insert("loaderVersion",QString::fromStdString(findOptifineOrFabricVersion(json)));
    }
    else if(isForge(json)){
        re.insert("loader","Forge");
        re.insert("loaderVersion",QString::fromStdString(findForgeVersion(json)));
    }
    else if(isOptifine(json)){
        re.insert("loader","Optifine");
        re.insert("loaderVersion",QString::fromStdString(findOptifineOrFabricVersion(json)));
    }
    return re;
}

// 获取适合的java版本
int LauncherUtil::getSuitableJava(string json){
    int re;
    try {
        regex pathRegex("(\"majorVersion\": )([0-9]+)");
        auto pos = sregex_iterator(json.begin(), json.end(), pathRegex);
        auto end = sregex_iterator();
        while (pos != end) {
            re = stoi(pos->str(2));
            ++pos;
        }
    } catch (const regex_error& e) {
        cerr << "Regex error: " << e.what() << endl;
        throw;
    }
    return re;
}
QVariantMap LauncherUtil::getSuitableJava(QString dir,QString version){
    QVariantMap re;
    int suitJavaInt;
    string json = readFile(dir.toStdString()+"/versions/"+version.toStdString()+"/"+version.toStdString()+".json");
    try {
        regex pathRegex("(\"majorVersion\": )([0-9]+)");

        auto pos = sregex_iterator(json.begin(), json.end(), pathRegex);
        auto end = sregex_iterator();
        while (pos != end) {
            suitJavaInt = stoi(pos->str(2));
            ++pos;
        }
    } catch (const regex_error& e) {
        cerr << "Regex error: " << e.what() << endl;
        throw;
    }
    string suitJava = to_string(suitJavaInt);
    if(suitJavaInt < 10 && suitJavaInt != 0){
        suitJava = "1." + suitJava;
    }
    re.insert("name",suitJavaInt == 0 ? "" : QString::fromStdString(suitJava));
    re.insert("javaPath","");
    QVariantMap versions = findAllJavaVersion();
    regex pathRegex("^"+suitJava+".*$");
    for (const auto& pair : versions.toStdMap()) {
        string str = pair.second.toString().toStdString().substr(3);
        auto pos = sregex_iterator(str.begin(), str.end(), pathRegex);
        auto end = sregex_iterator();
        while (pos != end) {
            re.insert("javaPath",pair.first);
            return re;
            ++pos;
        }
    }
    return re;
}

//获取 mainClass参数
string LauncherUtil::getMainClass(string json){
    string re;
    try {
        regex pathRegex("(\"mainClass\": \")([^\"]+)(\",)");

        auto pos = sregex_iterator(json.begin(), json.end(), pathRegex);
        auto end = sregex_iterator();
        while (pos != end) {
            re = pos->str(2);
            ++pos;
        }
    } catch (const regex_error& e) {
        cerr << "Regex error: " << e.what() << endl;
        throw;
    }
    return re;
}

//获取 tweakClass参数
string LauncherUtil::getTweakClass(string json){
    string re;
    try {
        regex pathRegex("(--tweakClass )([^\" ]+)( |\",)");
        auto pos = sregex_iterator(json.begin(), json.end(), pathRegex);
        auto end = sregex_iterator();
        while (pos != end) {
            re = pos->str(2);
            ++pos;
        }
    } catch (const regex_error& e) {
        cerr << "Regex error: " << e.what() << endl;
        throw;
    }
    if(!re.length()){
        try {
            regex pathRegex("(\"--tweakClass\",      \")([^\"]+)(\"    ],)");
            auto pos = sregex_iterator(json.begin(), json.end(), pathRegex);
            auto end = sregex_iterator();
            while (pos != end) {
                re = pos->str(2);
                ++pos;
            }
        } catch (const regex_error& e) {
            cerr << "Regex error: " << e.what() << endl;
            throw;
        }
    }
    return re;
}


//是否为optifine
int LauncherUtil::isOptifine(string json){
    if(json.find("optifine")!=string::npos){
        return 1;
    }
    return 0;
}
//是否为forge
int LauncherUtil::isForge(string json){
    if(json.find("forge")!=string::npos){
        return 1;
    }
    return 0;
}
//是否为fabric
int LauncherUtil::isFabric(string json){
    if(json.find("fabric")!=string::npos){
        return 1;
    }
    return 0;
}
string LauncherUtil::findOptifineOrFabricVersion(string json){
    vector<string> tmp = findVersionStr(json);
    return tmp[tmp.size()-1];
}

string LauncherUtil::findForgeVersion(string json){
    string re;
    try {
        regex pathRegex("(\"--fml.forgeVersion\",      \")([^\"]+)(\")");
        auto pos = sregex_iterator(json.begin(), json.end(), pathRegex);
        auto end = sregex_iterator();
        while (pos != end) {
            re = pos->str(2);
            ++pos;
        }
    } catch (const regex_error& e) {
        cerr << "Regex error: " << e.what() << endl;
        throw;
    }
    return re == "" ? findOptifineOrFabricVersion(json) : re;
}


//字符串分割
vector<string> LauncherUtil::splitStr(string str, string delimiter) {
    vector<string> tokens;
    string::size_type pos, lastPos = 0;
    string token;
    while ((pos = str.find(delimiter, lastPos)) != string::npos) {
        token = str.substr(lastPos, pos - lastPos);
        if (!token.empty()) {
            tokens.push_back(token);
        }
        lastPos = pos + delimiter.length();
    }
    if (lastPos < str.length()) {
        tokens.push_back(str.substr(lastPos));
    }
    return tokens;
}



//字符串替换
string LauncherUtil::replaceStr(string original,string oldStr,string newStr){
    if (oldStr.empty()) {
        return "";
    }
    size_t pos = 0;
    while ((pos = original.find(oldStr, pos)) != string::npos) {
        original.replace(pos, oldStr.length(), newStr);
        pos += newStr.length();
    }
    return original;
}

//获取optifine的lib
vector<string> LauncherUtil::getOptifineLib(string json){
    vector<string> splitJsonList = splitStr(json,"\"id\": \"optifine\",");
    string splitJson;
    if(splitJsonList.size() > 1){
        splitJson = splitJsonList[1];
    }
    else{
        splitJson = json;
    }
    vector<string> libPaths;
    try {
        regex pathRegex("(\"name\": \")([^\"]+)(\")");
        auto pos = sregex_iterator(splitJson.begin(), splitJson.end(), pathRegex);
        auto end = sregex_iterator();
        while (pos != end) {
            string pathValue = pos->str(2);
            vector<string> pathSplit = splitStr(pathValue,":");
            string pathPrefix = replaceStr(pathSplit[0],".","/");
            if(pathValue != "linux" && pathValue != "osx" && pathValue != "windows"){
                string path = pathPrefix+"/"+pathSplit[1]+"/"+pathSplit[2]+"/"+pathSplit[1]+"-"+pathSplit[2]+".jar";
                libPaths.push_back(path);
            }
            ++pos;
        }
    } catch (const regex_error& e) {
        cerr << "Regex error: " << e.what() << endl;
        throw;
    }
    return libPaths;
}



//获取forge的lib
vector<string> LauncherUtil::getForgeLib(string json,vector<string> cpPath){
    vector<string> splitJsonList = splitStr(json,"\"id\": \"forge\",");
    string splitJson;
    if(splitJsonList.size() > 1){
        splitJson = splitJsonList[1];
    }
    else{
        splitJson = json;
    }
    regex pathRegex("(\"name\": \")([^\"]+)(\")");
    auto pos = sregex_iterator(splitJson.begin(), splitJson.end(), pathRegex);
    auto end = sregex_iterator();
    vector<string> libPaths;
    while (pos != end) {
        string pathValue = pos->str(2);
        vector<string> pathSplit = splitStr(pathValue,":");
        string pathPrefix = replaceStr(pathSplit[0],".","/");
        if(pathValue != "linux" && pathValue != "osx" && pathValue != "windows"){
            string path = pathPrefix+"/"+pathSplit[1]+"/"+pathSplit[2]+"/"+pathSplit[1]+"-"+pathSplit[2]+".jar";
            auto flag = find(cpPath.begin(), cpPath.end(), path);
            if(flag == cpPath.end()){
                libPaths.push_back(path);
            }
        }
        ++pos;
    }
    return libPaths;
}



//获取fabric的lib
vector<string> LauncherUtil::getFabricLib(string json,vector<string> cpPath){
    vector<string> splitJsonList = splitStr(json,"\"id\": \"fabric\",");
    string splitJson;
    if(splitJsonList.size() > 1){
        splitJson = splitJsonList[1];
    }
    else{
        splitJson = json;
    }
    regex pathRegex("(\"name\": \")([^\"]+)(\")");
    auto pos = sregex_iterator(splitJson.begin(), splitJson.end(), pathRegex);
    auto end = sregex_iterator();
    vector<string> libPaths;
    while (pos != end) {
        string pathValue = pos->str(2);
        vector<string> pathSplit = splitStr(pathValue,":");
        string pathPrefix = replaceStr(pathSplit[0],".","/");
        if(pathValue != "linux" && pathValue != "osx" && pathValue != "windows"){
            string path = pathPrefix+"/"+pathSplit[1]+"/"+pathSplit[2]+"/"+pathSplit[1]+"-"+pathSplit[2]+".jar";
            auto flag = find(cpPath.begin(), cpPath.end(), path);
            if(flag == cpPath.end()){
                libPaths.push_back(path);
            }
        }
        ++pos;
    }
    return libPaths;
}
//获取高版本forge的参数lib	-p参数
string LauncherUtil::getForge_pPara(string json,string libDir){
    string _pPara = "";
    vector<string> split_pPara;
    try {
        regex pathRegex("(\"-p\",      \")([^\"]+)(\",)");
        auto pos = sregex_iterator(json.begin(), json.end(), pathRegex);
        auto end = sregex_iterator();
        while (pos != end) {
            string pathValue = pos->str(2);
            split_pPara = splitStr(pathValue,"${classpath_separator}");
            for(int i=0;i<split_pPara.size();i++){
                _pPara += libDir+"/libraries"+replaceStr(split_pPara[i],"${library_directory}","");
                if(i != split_pPara.size()-1){
                    _pPara+=";";
                }
            }
            ++pos;
        }
    } catch (const regex_error& e) {
        cerr << "Regex error: " << e.what() << endl;
        throw;
    }
    return _pPara;
}
// 获取高版本的额外前置参数
string LauncherUtil::extraPrePara(string json,string libraryPath){
    string natives1;
    if(json.find("-Djna.tmpdir")!=string::npos){
        natives1 = "-Djna.tmpdir="+libraryPath+" ";
    }
    string natives2;
    if(json.find("-Djna.tmpdir")!=string::npos){
        natives2 = "-Dorg.lwjgl.system.SharedLibraryExtractPath="+libraryPath+" ";
    }
    string natives3;
    if(json.find("-Djna.tmpdir")!=string::npos){
        natives3 = "-Dio.netty.native.workdir="+libraryPath+" ";
    }
    return natives1+natives2+natives3;
}
// 获取高版本的额外参数
string LauncherUtil::extraMorePara(string json,string selectDir,string selectVersion){
    string IPv6Addresses;
    if(json.find("-Djna.tmpdir")!=string::npos){
        IPv6Addresses = "-Djava.net.preferIPv6Addresses=system ";
    }
    string ignoreList;
    if(json.find("-DignoreList")!=string::npos){
        ignoreList = "-DignoreList=bootstraplauncher,securejarhandler,asm-commons,asm-util,asm-analysis,asm-tree,asm,JarJarFileSystems,client-extra,fmlcore,javafmllanguage,lowcodelanguage,mclanguage,forge-,"+selectVersion+".jar,"+selectVersion+".jar ";
    }
    string dmergeModules;
    if(json.find("-DmergeModules")!=string::npos){
        try {
            regex pathRegex("(-DmergeModules=|-DmergeModules\\u003d)([^\"]+)(\")");
            auto pos = sregex_iterator(json.begin(), json.end(), pathRegex);
            auto end = sregex_iterator();
            while (pos != end) {
                string pathValue = pos->str(2);
                dmergeModules = "-DmergeModules="+pathValue+" ";
                ++pos;
            }
        } catch (const regex_error& e) {
            cerr << "Regex error: " << e.what() << endl;
            throw;
        }
    }
    string libraryDirectory;
    if(json.find("-DlibraryDirectory")!=string::npos){
        libraryDirectory = "-DlibraryDirectory="+selectDir+"/libraries ";
    }
    string _pPara;
    if(json.find("\"-p\",")!=string::npos){
        _pPara = "-p "+getForge_pPara(json,selectDir)+" ";
    }
    string permitPacket = "";
    if(json.find("--add-modules")!=string::npos){
        permitPacket += "--add-modules ALL-MODULE-PATH ";
    }
    if(json.find("--add-opens")!=string::npos){
        permitPacket += "--add-opens java.base/java.util.jar=cpw.mods.securejarhandler --add-opens java.base/java.lang.invoke=cpw.mods.securejarhandler ";
    }
    if(json.find("--add-exports")!=string::npos){
        permitPacket += "--add-exports java.base/sun.security.util=cpw.mods.securejarhandler --add-exports jdk.naming.dns/com.sun.jndi.dns=java.naming ";
    }
    return IPv6Addresses+ignoreList+dmergeModules+libraryDirectory+_pPara+permitPacket;
}

// 高版本的forge需要下面方法获取参数
string LauncherUtil::extraParaNameFml(string json){
    string fmlPara = "";
    if(json.find("--launchTarget")!=string::npos){
        try {
            regex pathRegex("(\"--launchTarget\",      \")([^\"]+)(\")");
            auto pos = sregex_iterator(json.begin(), json.end(), pathRegex);
            auto end = sregex_iterator();
            while (pos != end) {
                string pathValue = pos->str(2);
                fmlPara += "--launchTarget "+pathValue+" ";
                ++pos;
            }
        } catch (const regex_error& e) {
            cerr << "Regex error: " << e.what() << endl;
            throw;
        }
    }
    if(json.find("--fml.forgeVersion")!=string::npos){
        try {
            regex pathRegex("(\"--fml.forgeVersion\",      \")([^\"]+)(\")");
            auto pos = sregex_iterator(json.begin(), json.end(), pathRegex);
            auto end = sregex_iterator();
            while (pos != end) {
                string pathValue = pos->str(2);
                fmlPara += "--fml.forgeVersion "+pathValue+" ";
                ++pos;
            }
        } catch (const regex_error& e) {
            cerr << "Regex error: " << e.what() << endl;
            throw;
        }
    }
    if(json.find("--fml.mcVersion")!=string::npos){
        try {
            regex pathRegex("(\"--fml.mcVersion\",      \")([^\"]+)(\")");
            auto pos = sregex_iterator(json.begin(), json.end(), pathRegex);
            auto end = sregex_iterator();
            while (pos != end) {
                string pathValue = pos->str(2);
                fmlPara += "--fml.mcVersion "+pathValue+" ";
                ++pos;
            }
        } catch (const regex_error& e) {
            cerr << "Regex error: " << e.what() << endl;
            throw;
        }
    }
    if(json.find("--fml.forgeGroup")!=string::npos){
        try {
            regex pathRegex("(\"--fml.forgeGroup\",      \")([^\"]+)(\")");
            auto pos = sregex_iterator(json.begin(), json.end(), pathRegex);
            auto end = sregex_iterator();
            while (pos != end) {
                string pathValue = pos->str(2);
                fmlPara += "--fml.forgeGroup "+pathValue+" ";
                ++pos;
            }
        } catch (const regex_error& e) {
            cerr << "Regex error: " << e.what() << endl;
            throw;
        }
    }
    if(json.find("--fml.mcpVersion")!=string::npos){
        try {
            regex pathRegex("(\"--fml.mcpVersion\",      \")([^\"]+)(\")");
            auto pos = sregex_iterator(json.begin(), json.end(), pathRegex);
            auto end = sregex_iterator();
            while (pos != end) {
                string pathValue = pos->str(2);
                fmlPara += "--fml.mcpVersion "+pathValue+" ";
                ++pos;
            }
        } catch (const regex_error& e) {
            cerr << "Regex error: " << e.what() << endl;
            throw;
        }
    }
    return fmlPara;
}
#include <fstream>
//读取文件，变成一行
string LauncherUtil::readFile(string filePath){
    ifstream file(filePath);
    string line;
    string result;
    if(file.is_open()){
        while (getline(file, line)) {
            result+=line;
        }
        file.close();
    }

    return result;
}

int LauncherUtil::existFile(string pathStr){
    ifstream file(pathStr);
    return file.good();
}


//UUID生成
#include <sstream>
#include <random>
#include <chrono>
string LauncherUtil::generateUUID() {
    auto now = chrono::system_clock::now();
    auto now_c = chrono::system_clock::to_time_t(now);
    random_device rd;
    mt19937 gen(rd());
    uniform_int_distribution<> dis(0, 15);
    uniform_int_distribution<> hex_dis(0, 15);
    stringstream ss;
    for (int i = 0; i < 4; ++i) {
        ss << hex << dis(gen);
    }
    for (int i = 0; i < 4; ++i) {
        ss << hex << dis(gen);
    }
    for (int i = 0; i < 4; ++i) {
        ss << hex << dis(gen);
    }
    ss << hex << now_c;
    for (int i = 0; i < 4; ++i) {
        ss << hex << hex_dis(gen);
    }
    for (int i = 0; i < 4; ++i) {
        ss << hex << hex_dis(gen);
    }
    for (int i = 0; i < 4; ++i) {
        ss << hex << hex_dis(gen);
    }
    return ss.str();
}
//随机数字字母
string LauncherUtil::random_str(int len){
    auto now = chrono::system_clock::now();
    auto now_c = chrono::system_clock::to_time_t(now);
    random_device rd;
    mt19937 gen(rd());
    uniform_int_distribution<> dis(0, 15);
    uniform_int_distribution<> hex_dis(0, 15);
    stringstream ss;
    for (int i = 0; i < len; ++i) {
        ss << hex << hex_dis(gen);
    }
    return ss.str();
}



#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <wchar.h>
// wchar_t类型转换成string类型
string WcharToUtf8(const wchar_t* wstr) {
    int size_needed = WideCharToMultiByte(CP_UTF8, 0, wstr, -1, nullptr, 0, nullptr, nullptr);
    vector<char> utf8str(size_needed, '\0');
    WideCharToMultiByte(CP_UTF8, 0, wstr, -1, &utf8str[0], size_needed, nullptr, nullptr);
    return string(utf8str.begin(), utf8str.end());
}
#include <map>
// 从注册表中获取所有java版本
map<string,string> LauncherUtil::findJavaVersionFromReg(const wchar_t* regKey) {
    map<string,string> result;
    HKEY hKey;
    LONG regResult;
    FILETIME fileLastWriteTime;
    DWORD dwIndex = 0;
    DWORD dwType;
    wchar_t szKeyName[256];
    DWORD dwKeyNameSize = sizeof(szKeyName);
    wchar_t szValue[MAX_PATH];
    DWORD dwValueSize = sizeof(szValue);
    // 打开注册表项
    regResult = RegOpenKeyEx(HKEY_LOCAL_MACHINE, regKey, 0, KEY_READ | KEY_ENUMERATE_SUB_KEYS, &hKey);
    if (regResult != ERROR_SUCCESS) {
        cerr << "未安装任何java版本" << regKey << endl;
        return result;
    }
    // 枚举子键
    while (RegEnumKeyEx(hKey, dwIndex++, szKeyName, &dwKeyNameSize, NULL, NULL, NULL, &fileLastWriteTime) == ERROR_SUCCESS) {
        HKEY hSubKey;
        // 尝试打开当前枚举的子键
        regResult = RegOpenKeyEx(hKey, szKeyName, 0, KEY_READ, &hSubKey);
        if (regResult == ERROR_SUCCESS) {
            // 查找可能的安装路径键，如JavaHome
            dwValueSize = sizeof(szValue);
            regResult = RegQueryValueEx(hSubKey, L"JavaHome", NULL, &dwType, (LPBYTE)szValue, &dwValueSize);
            if (regResult == ERROR_SUCCESS && dwType == REG_SZ) {
                result.insert(make_pair(WcharToUtf8(szValue),string(wcscmp(regKey, L"SOFTWARE\\JavaSoft\\Java Runtime Environment") == 0  ? "jre" : "jdk")+WcharToUtf8(szKeyName)));
            }
            // 如果JavaHome不存在，你可能需要查找其他键或子键
            // 关闭子键
            RegCloseKey(hSubKey);
        }
        // 重置dwKeyNameSize以便下一次枚举
        dwKeyNameSize = sizeof(szKeyName);
    }
    // 关闭主键
    RegCloseKey(hKey);
    return result;
}
// 获取所有java版本
QVariantMap LauncherUtil::findAllJavaVersion(){
    QVariantMap allJavaVersion;
    for(const auto& pair : findJavaVersionFromReg(L"SOFTWARE\\JavaSoft\\Java Runtime Environment")){
        allJavaVersion.insert(pair.first.c_str(), pair.second.c_str());
    }
    for(const auto& pair : findJavaVersionFromReg(L"SOFTWARE\\JavaSoft\\Java Development Kit")){
        allJavaVersion.insert(pair.first.c_str(), pair.second.c_str());
    }
    for(const auto& pair : findJavaVersionFromReg(L"SOFTWARE\\JavaSoft\\JDK")){
        allJavaVersion.insert(pair.first.c_str(), pair.second.c_str());
    }
    return allJavaVersion;
}
//获取当前exe路径
QString LauncherUtil::getCurrentPath(){
    wchar_t path[MAX_PATH];
    GetModuleFileName(NULL, path, MAX_PATH);
    vector<string> list = splitStr(WcharToUtf8(path),"\\");
    list.pop_back();
    string re;
    for(int i = 0; i< list.size(); i++){
        re += list[i];
        if(i != list.size()-1){
            re += "/";
        }
    }
    return QString::fromStdString(re);
}

QVariantMap LauncherUtil::getMemory(){
    QVariantMap re;
    MEMORYSTATUSEX statex;
    statex.dwLength = sizeof (statex);
    GlobalMemoryStatusEx(&statex);
    DWORDLONG totalPhys = statex.ullTotalPhys;// 总量
    DWORDLONG physAvail = statex.ullAvailPhys;// 可用
    DWORDLONG usedPhys = totalPhys - physAvail;// 已使用 = 总内存 - 可用内存
    re.insert("total",totalPhys/(1024*1024));
    re.insert("avalible",physAvail/(1024*1024));
    re.insert("using",usedPhys/(1024*1024));
    return re;
}
