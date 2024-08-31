#include "stdutil.h"
StdUtil::StdUtil(QObject *parent)
    : QObject{parent}
{}
#include <wchar.h>
#include <sstream>
#include <random>
#include <unordered_set>
#include <algorithm>
using namespace std;

//字符串替换
string StdUtil::replaceStr(const string &original,const string &oldStr,const string &newStr){
    if (oldStr.empty()) {
        return "";
    }
    string re = original;
    size_t pos = 0;
    while ((pos = re.find(oldStr, pos)) != string::npos) {
        re.replace(pos, oldStr.length(), newStr);
        pos += newStr.length();
    }
    return re;
}

//字符串分割
vector<string> StdUtil::splitStr(const string &str,const string &delimiter) {
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

// wchar_t类型转换成string类型
string StdUtil::wcharToUtf8(const wchar_t* wstr) {
    int size_needed = WideCharToMultiByte(CP_UTF8, 0, wstr, -1, nullptr, 0, nullptr, nullptr);
    vector<char> utf8str(size_needed, '\0');
    WideCharToMultiByte(CP_UTF8, 0, wstr, -1, &utf8str[0], size_needed, nullptr, nullptr);
    return string(utf8str.begin(), utf8str.end());
}
// 如果toStdString()是乱码，就用这个函数
string StdUtil::QStringToStringLocal8Bit(const QString &qs){
    return string(qs.toLocal8Bit());
}

//随机数字字母
string StdUtil::random_str(int len){
    random_device rd;
    mt19937 gen(rd());
    uniform_int_distribution<> hex_dis(0, 15);
    stringstream ss;
    for (int i = 0; i < len; ++i) {
        ss << hex << hex_dis(gen);
    }
    return ss.str();
}

// 数组去重
vector<string> StdUtil::outRepeated(const vector<string> &list){
    vector<string> re;
    unordered_set<string> set;
    for (string ele : list) {
        if(set.find(ele) == set.end()){
            re.push_back(ele);
            set.insert(ele);
        }
    }
    return re;
}

// 字符串包含空格在字符串两边加"
string StdUtil::paraExistSpace(const string &str){
    return str.find(" ") != string::npos ? "\""+str+"\"" : str;
}

//检测字符串是否为数字
bool StdUtil::isNumber(const string &str) {
    return all_of(str.begin(), str.end(), ::isdigit) && !str.empty();
}

//QString文件地址获取文件的目录地址
QString StdUtil::getPathParentPath(const QString &path){
    return path.lastIndexOf("/") != -1 ? path.left(path.lastIndexOf("/")) : path;
}
string StdUtil::getPathParentPath(const string &path){
    filesystem::path p(path);
    return p.parent_path().string();
}
