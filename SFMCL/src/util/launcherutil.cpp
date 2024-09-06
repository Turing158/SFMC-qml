#include "launcherutil.h"

#include <unordered_set>
#include <regex>
#include <iostream>

LauncherUtil::LauncherUtil(QObject *parent)
    : QObject{parent}
{
    connect(&nu,&NetworkUtil::downloadingTips,this,&LauncherUtil::downloading);
    connect(&nu,&NetworkUtil::finishDownloadTips,this,&LauncherUtil::downloadFinished);
}

//"/"转成"\"
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

//判断versions里的文件夹是否为minecraft的核心jar储存文件夹
int LauncherUtil::existVersionJar(QString filePath,QString jarName){
    QString folderPath = filePath+"/"+jarName;
    QDir dir(folderPath);
    QStringList entries = dir.entryList(QDir::Files | QDir::Dirs | QDir::NoDotAndDotDot);
    foreach (const QString &entry, entries) {
        if(entry == jarName+".jar"){
            return 1;
        }
    }
    return 0;
}

//查找Minecraft版本
QVariantList LauncherUtil::findVersion(QString dirPath){
    qDebug()<<"获取Minecraft版本...";
    QVariantList version;
    QString folderPath = dirPath+"/versions";
    QDir dir(folderPath);
    QStringList entries = dir.entryList(QDir::Files | QDir::Dirs | QDir::NoDotAndDotDot);
    foreach (const QString &entry, entries) {
        if(existVersionJar(folderPath,entry)){
            version.append(entry);
        }
    }
    qDebug()<<(version.empty() ? "未找到Minecraft版本" : "获取Minecraft版本...");
    return version;
}

//判断当前选择版本是否版本隔离
bool LauncherUtil::isDefaultIsolate(QString selectDir,QString selectVersion){
    QDir dir(selectDir+"/versions/"+selectVersion+"/resources");
    if(dir.exists()){
        return true;
    }
    return false;
}

//解压jar包
bool LauncherUtil::decompressJar(QString jarPath,QString outPutDir){
    QString batchFileName = outPutDir+"/decompressJar.bat";
    QFile batchFile(batchFileName);
    batchFile.open(QIODevice::WriteOnly | QIODevice::Text);
    QTextStream out(&batchFile);
    out.setEncoding(QStringConverter::Encoding::System);
    out << "@echo off" << "\n";
    out << "cd /d \""+outPutDir+"\"" << "\n";
    out << "jar xf \""+jarPath+"\"" << "\n";
    batchFile.close();
    QProcess process;
    process.start(batchFileName);
    process.waitForFinished();
    return false;
}

//获取并解压native库
string LauncherUtil::getAndDecompressNatives(vector<Lib>libs,QString gameDir,QString gameVersion) {
    qDebug()<<"解压native库...";
    QString nativesDir = gameDir+"/versions/"+gameVersion+"/"+gameVersion+"-natives";
    QDir dir;
    if(!dir.exists(nativesDir)){
        dir.mkdir(nativesDir);
    }
    for(const Lib & ele : libs){
        if(ele.isNativesWindows){
            if(ele.classifiers.empty()){
                decompressJar(gameDir+"/libraries/"+QString::fromStdString(ele.path),nativesDir);
            }
            else{
                map<string,Download> map = ele.classifiers;
                string nativesNames[] = {"natives-windows","natives-windows-32","natives-windows-64"};
                for(string nativesName : nativesNames){
                    if(!map[nativesName].path.empty()){
                        qDebug()<<map[nativesName].path;
                        decompressJar(gameDir+"/libraries/"+QString::fromStdString(map[nativesName].path),nativesDir);
                    }
                }
            }
        }
    }
    dir.remove(nativesDir+"/decompressJar.bat");
    fdu.moveFileToTopLevelAndDelOtherFile(nativesDir,".dll",FileDirUtil::EndWith,false);
    fdu.delPathAllFolder(nativesDir);
    qDebug()<<"native库解压完成";
    return su.QStringToStringLocal8Bit(gameVersion)+"-natives";
}

//处理json中的libraries，将其转化成对象
vector<Lib> LauncherUtil::JsonToLib(Json::Value libs){
    vector<Lib> re;
    for (auto & lib : libs) {
        string path;
        string fileName;
        string name = lib["name"].asString();
        vector<string> nameSplit = su.splitStr(name,":");
        vector<string> nameSplit0Split = su.splitStr(nameSplit[0],".");
        for (const auto & j : nameSplit0Split) {
            path+=j+"/";
        }
        for (int j = 1; j < nameSplit.size(); ++j) {
            fileName+=nameSplit[j]+"-";
            if(j == nameSplit.size()-1){
                if(su.isNumber(nameSplit[j].substr(0,1))){
                    path+=nameSplit[j]+"/";
                }
                fileName = fileName.substr(0,fileName.size()-1) + ".jar";
            }
            else{
                path+=nameSplit[j]+"/";
            }
        }
        path+=fileName;

        auto artifact = lib["downloads"]["artifact"];
        Download downloadArtifact;
        map<string,Download> downloadClassifiers;
        if(!artifact.isNull()){
            auto downloadPath = artifact["path"];
            auto downloadUrl = artifact["url"];
            auto downloadSha1 = artifact["sha1"];
            auto downloadSize = artifact["size"];
            downloadArtifact = Download(
                downloadPath.isNull()?"":downloadPath.asString(),
                downloadUrl.isNull()?"":downloadUrl.asString(),
                downloadSha1.isNull()?"":downloadSha1.asString(),
                downloadSize.isNull()?-1:downloadSize.asInt()
                );
        }
        bool isNativeWindows = name.find("natives-windows") != string::npos;
        bool isNativeLinux = name.find("natives-linux") != string::npos;
        bool isNativeMacos = name.find("natives-macos") != string::npos;

        auto classifiers = lib["downloads"]["classifiers"];
        if(!classifiers.isNull()){
            string classifiersNames[] = {"natives-linux","natives-windows","natives-macos","natives-windows-32","natives-windows-64"};
            for (string classifiersName : classifiersNames) {
                auto classifiersNative = classifiers[classifiersName];

                if(!classifiersNative.isNull()){
                    isNativeLinux = classifiersName.find("linux") != string::npos;
                    isNativeWindows = classifiersName.find("windows") != string::npos;
                    isNativeMacos = classifiersName.find("macos") != string::npos;
                    auto downloadPath = classifiersNative["path"];
                    auto downloadUrl = classifiersNative["url"];
                    auto downloadSha1 = classifiersNative["sha1"];
                    auto downloadSize = classifiersNative["size"];
                    downloadClassifiers.insert_or_assign(
                        classifiersName,
                        Download(
                            downloadPath.isNull()?"":downloadPath.asString(),
                            downloadUrl.isNull()?"":downloadUrl.asString(),
                            downloadSha1.isNull()?"":downloadSha1.asString(),
                            downloadSize.isNull()?-1:downloadSize.asInt()
                            )
                        );
                }
            }
        }
        auto rules = lib["rules"];
        if(!rules.isNull()){
            isNativeLinux = false;
            isNativeWindows = false;
            isNativeMacos = false;
            for(const auto & rule : rules){
                auto action = rule["action"].asString();
                if(action == "allow"){
                    auto os = rule["os"];
                    if(os.isNull()){
                        isNativeLinux = true;
                        isNativeWindows = true;
                        isNativeMacos = true;
                    }
                    else{
                        auto osName = rule["os"]["name"].asString();
                        if(osName == "linux") isNativeLinux = true;
                        if(osName == "windows") isNativeWindows = true;
                        if(osName == "osx") isNativeMacos = true;
                    }
                }
                else{
                    auto osName = rule["os"]["name"].asString();
                    if(osName == "linux") isNativeLinux = false;
                    if(osName == "windows") isNativeWindows = false;
                    if(osName == "osx") isNativeMacos = false;
                }
            }
        }
        if(!classifiers.isNull() && artifact.isNull()){
            path = "";
        }
        re.emplace_back(name,path,isNativeLinux,isNativeWindows,isNativeMacos,downloadArtifact,downloadClassifiers);
    }
    return re;
}

//获取json中的所有libraries
vector<Lib> LauncherUtil::getLibs(string json){
    qDebug()<<"获取Json中Libraries的所有文件信息...";
    Json::Reader reader;
    Json::Value root;
    unordered_set<string> set;
    vector<Lib> libList;
    if(reader.parse(json,root)){
        Json::Value libs = root["libraries"];
        libList = JsonToLib(libs);
        Json::Value patchesLib = root["patches"];
        for (int i = 0; i < patchesLib.size(); ++i) {
            Json::Value ele = patchesLib[i]["libraries"];
            vector<Lib> list = JsonToLib(ele);
            for (int j = 0; j < list.size(); ++j) {
                libList.push_back(list[i]);
            }
        }
    }
    vector<Lib> re;
    for(const Lib & ele : libList ){
        string repeatedName = ele.name+"-"+(ele.isNativesLinux?"t":"f")+"-"+(ele.isNativesWindows?"t":"f")+"-"+(ele.isNativesMacos?"t":"f");
        if(set.find(repeatedName) == set.end()){
            set.insert(repeatedName);
            re.push_back(ele);
        }
    }
    qDebug()<<"成功获取Libraries的所有文件信息";
    return re;
}

//获取cp的lib库path
vector<string> LauncherUtil::getLibPaths(vector<Lib> lib){
    vector<string> re;
    for(const auto & ele : lib){
        re.push_back(ele.path);
    }
    return su.outRepeated(re);
}

//获取json最外层的字符串[只是为了方便]
string LauncherUtil::getOnlyString(string json,string key){
    string re;
    Json::Reader reader;
    Json::Value root;
    if(reader.parse(json,root)){
        re = root[key].asString();
    }
    return re;
}

//获取 assetsIndex参数
string LauncherUtil::getAssetIndex(string json){
    return getOnlyString(json,"assets");
}

//通过id获取patches字段下的version[方便获取加载器版本]
string LauncherUtil::getVersionInPatchesById(string json,string key){
    Json::Reader reader;
    Json::Value root;
    if(reader.parse(json,root)){
        auto patches = root["patches"];
        for (auto & patche : patches) {
            if(patche["id"].asString() == key){
                return patche["version"].asString();
            }
        }
    }
    return "";
}

//获取 ClientVersion参数[获取Minecraft版本的方法]
string LauncherUtil::getClientVersion(string json){
    string re = getOnlyString(json,"clientVersion");
    if(re.empty()){
        re = getVersionInPatchesById(json,"game");
    }
    if(re.empty()){
        re = getAssetIndex(json);
    }
    return re;
}

// 获取一些版本信息
QVariantMap LauncherUtil::getVersionInfo(QString dir,QString version){
    qDebug()<<"获取"<<version<<"版本信息...";
    QVariantMap re;
    string json = fdu.readFile(dir.toStdString()+"/versions/"+version.toStdString()+"/"+version.toStdString()+".json").toStdString();
    re.insert("client",json.size() == 0 ? "未找到" : QString::fromStdString(getClientVersion(json)));
    re.insert("loader","");
    re.insert("loaderVersion","0");
    if(isFabric(json)){
        re.insert("loader","Fabric");
        re.insert("loaderVersion",QString::fromStdString(getFabricVersion(json)));
    }
    else if(isForge(json)){
        re.insert("loader","Forge");
        re.insert("loaderVersion",QString::fromStdString(getForgeVersion(json)));
    }
    else if(isOptifine(json)){
        re.insert("loader","Optifine");
        re.insert("loaderVersion",QString::fromStdString(getOptifineVersion(json)));
    }
    qDebug()<<"成功获取"<<version<<"版本信息";
    return re;
}

//获取 mainClass参数
string LauncherUtil::getMainClass(string json){
    return getOnlyString(json,"mainClass");
}

// 获取适合的java版本
QVariantMap LauncherUtil::getSuitableJava(QString dir,QString version){
    QVariantMap re;
    if(version.isEmpty()){
        return re;
    }
    qDebug()<<"获取"<<version<<"合适的java版本...";
    int suitJavaInt;
    string json = fdu.readFile(dir.toStdString()+"/versions/"+version.toStdString()+"/"+version.toStdString()+".json").toStdString();
    Json::Reader reader;
    Json::Value root;
    if(reader.parse(json,root)){
        suitJavaInt = root["javaVersion"]["majorVersion"].asInt();
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
    qDebug()<<"成功获取"<<version<<"合适的java版本："<<re["name"];
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

// 获取optifine版本
string LauncherUtil::getOptifineVersion(string json){
    string re = getVersionInPatchesById(json,"optifine");
    qDebug()<<"成功获取forge版本："<<re;
    return re;
}

// 获取forge版本
string LauncherUtil::getForgeVersion(string json){
    string re = getVersionInPatchesById(json,"forge");
    Json::Reader reader;
    Json::Value root;
    if(re.empty() && reader.parse(json,root)){
        auto gameArg = root["arguments"]["game"];
        for (int i = 0; i < gameArg.size(); ++i) {
            if(gameArg[i].isString() && gameArg[i].asString() == "--fml.forgeVersion"){
                re = gameArg[i+1].asString();
                break;
            }
        }
    }
    qDebug()<<"成功获取forge版本："<<re;
    return re;
}

// 获取fabric版本
string LauncherUtil::getFabricVersion(string json){
    string re = getVersionInPatchesById(json,"fabric");
    Json::Reader reader;
    Json::Value root;
    if(re.empty() && reader.parse(json,root)){
        auto libs = root["libraries"];
        for (auto ele : libs) {
            if(ele["name"].asString().find("fabric-loader") != string::npos){
                auto ss = su.splitStr(ele["name"].asString(),":");
                return ss[ss.size()-1];
            }
        }
    }
    qDebug()<<"成功获取fabric版本："<<re;
    return re;
}

// 查找更多的游戏参数
string LauncherUtil::findGameExtraArg(QString json){
    qDebug()<<"获取Minecraft额外参数中...";
    string re;
    Json::Reader reader;
    Json::Value root;
    if(reader.parse(su.QStringToStringLocal8Bit(json),root)){
        auto gameArgs = root["arguments"]["game"];
        for (int i = 0; i < gameArgs.size(); ++i) {
            if(gameArgs[i].isString() && (gameArgs[i].asString() == "--launchTarget" || gameArgs[i].asString().find("fml.")!=string::npos)){
                re += gameArgs[i].asString()+" "+gameArgs[i+1].asString()+" ";
            }
        }
    }
    qDebug()<<"成功获取Minecraft额外参数";
    return re;
}

//查找更多的JVM参数
map<string,string> LauncherUtil::findJvmExtraArgs(QString json,QString gameDir,QString gameVersion,QString launcherName,QString launcherVersion){
    qDebug()<<"获取JVM额外参数中...";
    map<string,string> re;
    Json::Reader reader;
    Json::Value root;

    if(reader.parse(su.QStringToStringLocal8Bit(json),root)){
        auto jvmArgs = root["arguments"]["jvm"];
        string tmp;
        int i;
        for (i = 0; i < jvmArgs.size(); ++i) {
            auto ele = jvmArgs[i];
            if(ele.isString() && ele.asString() == "-cp"){
                break;
            }

            if(!ele.isString() && ele["rules"][0]["os"]["name"].asString() == "windows"){
                if(ele["value"].isString()){
                    tmp += "\""+ele["value"].asString()+"\" ";
                }
                else{
                    auto values = ele["value"];
                    for(const auto & value : values){
                        tmp += "\""+value.asString()+"\" ";
                    }

                }
            }
            if(ele.isString()){
                tmp += "\""+ele.asString()+"\" ";
            }

        }
        tmp = su.replaceStr(tmp,"${natives_directory}",(gameDir+"/versions/"+gameVersion+"/"+gameVersion+"-natives").toStdString());
        tmp = su.replaceStr(tmp,"${launcher_name}",launcherName.toStdString());
        re.insert_or_assign("-cpPre",su.replaceStr(tmp,"${launcher_version}",launcherVersion.toStdString()));

        tmp = "";
        for (i+=2; i < jvmArgs.size(); ++i) {
            auto ele = jvmArgs[i];
            if(ele.isString() && ele.asString() == "-p"){
                break;
            }
            tmp+="\"";
            if(ele.isString()){
                tmp += su.paraExistSpace(ele.asString());
            }
            tmp+="\" ";
        }
        tmp = su.replaceStr(tmp,"${version_name}",gameVersion.toStdString());
        tmp = su.replaceStr(tmp,"${primary_jar_name}",gameVersion.toStdString()+".jar");
        re.insert_or_assign("-pPre",su.replaceStr(tmp,"${library_directory}",gameDir.toStdString()+"/libraries"));

        tmp = "";
        for (; i < jvmArgs.size(); ++i) {
            auto ele = jvmArgs[i];
            tmp+="\"";
            if(ele.isString()){
                tmp += ele.asString();
            }
            tmp+="\" ";
        }
        tmp = su.replaceStr(tmp,"${library_directory}",gameDir.toStdString()+"/libraries");
        re.insert_or_assign("-p",su.replaceStr(tmp,"${classpath_separator}",";"));
    }
    qDebug()<<"成功获取JVM额外参数";
    return re;
}

//UUID生成
QString LauncherUtil::generateUUID() {
    QUuid q = QUuid::createUuid();
    return q.toString(QUuid::WithoutBraces).remove("-");
}

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
                string pahtStr = su.wcharToUtf8(szValue);
                string path = pahtStr.substr(0,pahtStr.size()-1);
                result.insert(make_pair(path,string(wcscmp(regKey, L"SOFTWARE\\JavaSoft\\Java Runtime Environment") == 0  ? "jre" : "jdk")+su.wcharToUtf8(szKeyName)));
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
    qDebug()<<"获取所有java版本中...";
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
    vector<string> list = su.splitStr(su.wcharToUtf8(path),"\\");
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

//  获取本机内存
QVariantMap LauncherUtil::getMemory(){
    qDebug()<<"获取内存信息中...";
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
    qDebug()<<"成功获取内存信息";
    return re;
}

//  fml加载器加载forge需要额外下载的一些path
Lib LauncherUtil::getFmlExtraDownloadFile(QString json,QString gameDir){
    vector<string> paths;
    vector<string> gameExtraPara = su.splitStr(findGameExtraArg(json)," ");
    string forgeVersion;
    string mcVersion;
    string mcpVersion;
    //  解决fml加载forge时所需要的文件
    for(int i=0;i<gameExtraPara.size();i++){
        if(gameExtraPara[i] == "--fml.forgeVersion"){
            forgeVersion = gameExtraPara[i+1];
        }
        if(gameExtraPara[i] == "--fml.mcVersion"){
            mcVersion = gameExtraPara[i+1];
        }
        if(gameExtraPara[i] == "--fml.mcpVersion"){
            mcpVersion = gameExtraPara[i+1];
        }
    }
    if(forgeVersion.empty() && mcVersion.empty() && mcpVersion.empty()){
        return Lib();
    }
    string needArg[] = {"fmlcore","javafmllanguage","mclanguage"};
    paths.push_back("net/minecraftforge/forge/"+mcVersion+"-"+forgeVersion+"/forge-"+mcVersion+"-"+forgeVersion+"-client.jar");
    paths.push_back("net/minecraft/client/"+mcVersion+"-"+mcpVersion+"/client-"+mcVersion+"-"+mcpVersion+"-srg.jar");
    paths.push_back("net/minecraft/client/"+mcVersion+"-"+mcpVersion+"/client-"+mcVersion+"-"+mcpVersion+"-extra.jar");
    paths.push_back("net/minecraftforge/forge/"+mcVersion+"-"+forgeVersion+"/forge-"+mcVersion+"-"+forgeVersion+"-universal.jar");
    for(const auto &ele : needArg){
        paths.push_back("net/minecraftforge/"+ele+"/"+mcVersion+"-"+forgeVersion+"/"+ele+"-"+mcVersion+"-"+forgeVersion+".jar");
    }
    map<string,Download> nullDownloadMap;
    for(const auto &ele : paths){
        if(!fdu.existFile(gameDir + "/libraries/" + QString::fromStdString(ele))){
            string installJarPath = "net/minecraftforge/forge/"+mcVersion+"-"+forgeVersion+"/forge-"+mcVersion+"-"+forgeVersion+"-installer.jar";
            return Lib(installJarPath,installJarPath,false,false,false,Download(),nullDownloadMap);
        }
    }
    return Lib();
}

//  修复json文件中的所有要下载的libraries
bool LauncherUtil::fixNeedDownloadLibFile(vector<Lib> libs,QString gameDir, QString gameVersion,QString json){
    vector<Download> needDownloads;
    QString filePath;
    QString librariesPath = gameDir+"/libraries";
    QDir dir(librariesPath);
    if(!dir.exists()){
        dir.mkdir(librariesPath);
    }
    //  遍历需要下载的信息
    for (const auto & ele : libs) {
        filePath = librariesPath + "/" + QString::fromStdString(ele.path);
        if(!fdu.existFile(filePath)
                &&
            !(
                (ele.isNativesLinux && !ele.isNativesWindows && ele.isNativesMacos) ||
                (ele.isNativesLinux && !ele.isNativesWindows && !ele.isNativesMacos) ||
                (!ele.isNativesLinux && !ele.isNativesWindows && ele.isNativesMacos))
            ){
            auto paht = ele.path;
            auto url = ele.artifact.url;
            auto sha1 = ele.artifact.sha1;
            auto size = ele.artifact.size;
            needDownloads.push_back(Download(paht,url,sha1,size));
        }

        map<string,Download> eleClassifiers = ele.classifiers;
        if(!eleClassifiers.empty()){
            auto eleClassifiersNativesWindows = eleClassifiers["natives-windows"];
            filePath = librariesPath + "/" + QString::fromStdString(eleClassifiersNativesWindows.path);
            if(ele.isNativesWindows && !fdu.existFile(filePath)){
                auto paht = eleClassifiersNativesWindows.path;
                auto url = eleClassifiersNativesWindows.url;
                auto sha1 = eleClassifiersNativesWindows.sha1;
                auto size = eleClassifiersNativesWindows.size;
                needDownloads.push_back(Download(paht,url,sha1,size));
            }
        }
    }
    //  检测forge是否完整
    Lib fmlExtraFile = getFmlExtraDownloadFile(json,gameDir);

    if(!fmlExtraFile.path.empty()){
        needDownloads.push_back(Download(fmlExtraFile.path,fmlExtraFile.path,"",-1));
    }


    qDebug()<<(needDownloads.empty() ? "libraries库完整，无需修补" : "libraries库文件缺失，正在修补...");
    if(needDownloads.empty()){
        return true;
    }

    unordered_set<string> set;
    for(const auto & ele : needDownloads){
        if(set.find(ele.path) == set.end()){
            set.insert(ele.path);
            filePath = librariesPath + "/" + QString::fromStdString(ele.path);

            //optifine特殊处理
            if(ele.path.find("optifine") != string::npos){
                string optifinePath = ele.path;
                //optifine的launchwrapper不需要下载
                if(ele.path.find("launchwrapper") != string::npos){
                    for(const auto &libEle : libs){
                        if(libEle.name.find("OptiFine") != string::npos){
                            optifinePath = libEle.path;
                            break;
                        }
                    }
                }
                map<string,string> optifineInfo = getOptifineJarInfoByPath(optifinePath);
                QString url = optifineDownloadUrl + "/" + QString::fromStdString(optifineInfo["mcVersion"] + "/" + optifineInfo["type"] + "/" + optifineInfo["patch"]);
                filePath = librariesPath + "/" + QString::fromStdString(optifineInfo["installJarPath"]);
                if(!QFile::exists(filePath)){
                    nu.downloadFile(url,filePath);
                }
                installOptifineByInstaller(filePath,optifineInfo,gameDir,gameVersion,libs);
            }
            else{
                QString url = librariesDownloadUrl + "/" + QString::fromStdString(ele.path);
                if(!QFile::exists(filePath)){
                    nu.downloadFile(url,filePath);
                }
                if(filePath.contains("forge") && filePath.contains("installer")){
                    installForgeByInstall(filePath,gameDir);
                }
            }
        }
    }
    qDebug()<< "libraries库文件修补完成";
    return false;
}

//  通过版本json修复版本assets文件
bool LauncherUtil::fixAssetsByVersionJson(QString gameDir , QString jsonContent){
    string json = jsonContent.toStdString();
    Json::Reader reader;
    Json::Value root;
    qDebug()<<"检查补全资源文件中...";
    QString urlPath;
    string assetIndexId;
    string indexJson;
    if(reader.parse(json,root)){
        auto url = root["assetIndex"]["url"];
        if(!url.isNull()){
            vector<string> urlPathSplit = su.splitStr(url.asString(),"/");
            for(int i = 2;i < urlPathSplit.size();++i){
                urlPath+=urlPathSplit[i];
                if(i != urlPathSplit.size()-1){
                    urlPath+="/";
                }
            }
            urlPath = assetIndexDownloadUrl + "/" + urlPath ;
        }
        assetIndexId =  root["assetIndex"]["id"].isNull() ? "" : root["assetIndex"]["id"].asString();
        QString assetIndexPath = gameDir+"/assets/indexes/"+QString::fromStdString(assetIndexId)+".json";
        if(!QFile::exists(assetIndexPath)){
            nu.downloadFile(urlPath,assetIndexPath);
        }
        indexJson = fdu.readFile(assetIndexPath).toStdString();
    }

    if(reader.parse(indexJson,root)){
        auto objects = root["objects"];
        for(auto obj : objects){
            QString hash = QString::fromStdString(obj["hash"].asString());
            QString assetsFilePath = gameDir+"/assets/objects/"+hash.left(2)+"/"+hash;
            if(!QFile::exists(assetsFilePath)){
                QString assetsFileUrl = assetsFileDownloadUrl + "/" + hash.left(2)+"/"+hash;
                qDebug()<<assetsFileUrl;
                nu.downloadFile(assetsFileUrl,assetsFilePath);
            }
        }
    }
    qDebug()<<"检查补全资源文件完成";
    return false;
}

//  通过版本路径查询json修复版本assets文件
bool LauncherUtil::fixAssetsByVersionPath(QString seleceDir,QString selectVersion){
    QString versionJsonPath = seleceDir+"/versions/"+selectVersion+"/"+selectVersion+".json";
    return fixAssetsByVersionJson(seleceDir, fdu.readFile(versionJsonPath));
}


//  通过文件资源管理器打开指定文件夹
bool LauncherUtil::openFolder(QString url){
    QDir dir(url);
    if(!dir.exists()){
        return false;
    }
    QDesktopServices::openUrl(QUrl::fromLocalFile(url));
    return true;
}

//  修复所有资源文件
bool LauncherUtil::fixAllResourcesFile(QString selectDir,QString selectVersion){
    emit topProcessTips("正在读取需要修补的文件...");
    QString json = fdu.readFile(selectDir + "/versions/" + selectVersion + "/" + selectVersion + ".json");
    vector<Lib> libs = getLibs(su.QStringToStringLocal8Bit(json));
    emit topProcessTips("修补libraries文件夹所需文件中...");
    fixNeedDownloadLibFile(libs,selectDir,selectVersion,json);
    emit topProcessTips("修补assets文件夹所需文件中...");
    fixAssetsByVersionJson(selectDir,json);
    emit topProcessTips("");
    emit touchGlobalTips("","修补资源文件完成");
    return true;
}

//  通过path获取optifine的信息
map<string,string> LauncherUtil::getOptifineJarInfoByPath(string path){
    map<string,string> re;
    vector<string> pathSplit = su.splitStr(path,"/");
    string jarName = pathSplit[pathSplit.size()-1];
    vector<string> jarNameSplit = su.splitStr(jarName,"_");
    string mcVersion = jarNameSplit[0].substr(9);
    re.insert_or_assign("mcVersion",mcVersion);
    string type;
    for(int i=1;i<jarNameSplit.size()-1;i++){
        type+=jarNameSplit[i];
        if(i != jarNameSplit.size()-2){
            type+="_";
        }
    }
    re.insert_or_assign("type",type);
    string patch = su.splitStr(jarNameSplit[jarNameSplit.size()-1],".")[0];
    re.insert_or_assign("patch",patch);
    string installJarPath = su.splitStr(path,".jar")[0] + "-installer.jar";
    re.insert_or_assign("installJarPath",installJarPath);
    return re;
}

//  安装optifine
bool LauncherUtil::installOptifineByInstaller(QString installerPath, map<string,string> optifineInfo, QString gameDir, QString gameVersion, vector<Lib> libs){
    qDebug()<<"安装Optifine中...";
    //emit startInstallOptifine()
    QString dirPath = su.getPathParentPath(installerPath);
    QString optifineJarPath = dirPath + "/" + "Optifine-" + QString::fromStdString(optifineInfo["mcVersion"] + "_" + optifineInfo["type"] + "_" + optifineInfo["patch"]) + ".jar";
    QString versionJarPath = gameDir + "/versions/" + gameVersion + "/" + gameVersion + ".jar";
    QString command =QString("java -cp \"%1\" optifine.Patcher \"%2\" \"%1\" \"%3\"")
                          .arg(installerPath).arg(versionJarPath).arg(optifineJarPath);
    QProcess process;
    process.start(command);
    process.waitForFinished();
    QString launchwrapperPath;
    for(const auto &ele : libs){
        if(ele.name.find("launchwrapper") != string::npos){
            launchwrapperPath = gameDir + "/libraries/" + QString::fromStdString(ele.path);
            break;
        }
    }
    if(!fdu.existFile(launchwrapperPath)){
        QString parentPath = su.getPathParentPath(launchwrapperPath);
        QDir dir(parentPath);
        if(!dir.exists()){
            dir.mkpath(parentPath);
        }
        decompressJar(installerPath,parentPath);
        fdu.moveFileToTopLevelAndDelOtherFile(parentPath,"launchwrapper");
        fdu.delPathAllFolder(parentPath);
    }
    //emit finishInstallOptifine()
    qDebug()<<"Optifine安装完成";
    return true;
}

//  安装forge
bool LauncherUtil::installForgeByInstall(QString installerPath,QString gameDir){
    qDebug()<<"安装Forge中...";
    //emit startInstallForge()
    QString command = QString("java -jar \"%1\" net.minecraftforge.installer.SimpleInstaller --installClient \"%2\"").arg(installerPath).arg(gameDir);
    QProcess process;
    process.start(command);
    process.waitForFinished();
    QFile::remove(installerPath);
    //emit finishInstallForge()
    qDebug()<<"Forge安装完成";
    return true;
}

//  删除Minecraft版本
bool LauncherUtil::delVersion(QString gameDir,QString gameVersion){
    QString path = gameDir + "/versions/" + gameVersion;
    return fdu.delDirAllContentAndDir(path);
}

//  删除Native动态链接库文件
bool LauncherUtil::delNativeDir(QString gameDir,QString gameVersion){
    return fdu.delDirAllContent(gameDir + "/versions/" + gameVersion + "/" + gameVersion + "-natives");
}

//通过链接打开网页
bool LauncherUtil::openWebUrl(QString url){
    if(!QDesktopServices::openUrl(url)){
        return 0;
    }
    return 1;
}

//  复制文本到剪切板
void LauncherUtil::copyTextToClipboard(QString text) {
    QGuiApplication::clipboard()->setText(text);
}

