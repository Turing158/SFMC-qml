#include "stdutil.h"
StdUtil::StdUtil(QObject *parent)
    : QObject{parent}
{}
#include <iostream>
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <wchar.h>
#include <string>
#include <sstream>
#include <random>
#include <unordered_set>
#include <algorithm>

using namespace std;

//字符串替换
string StdUtil::replaceStr(string original,string oldStr,string newStr){
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

//字符串分割
vector<string> StdUtil::splitStr(string str, string delimiter) {
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
string StdUtil::QStringToStringLocal8Bit(QString qs){
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
vector<string> StdUtil::outRepeated(vector<string> list){
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
string StdUtil::paraExistSpace(string str){
    return str.find(" ") != string::npos ? "\""+str+"\"" : str;
}

//检测字符串是否为数字
bool StdUtil::isNumber(string str) {
    return all_of(str.begin(), str.end(), ::isdigit) && !str.empty();
}

//QString转换成utf-8的string
string StdUtil::QStringToStringANSI(QString qStr){
    // // 获取内容的UTF-16表示（QString内部使用的编码）
    // const wchar_t* wStr = reinterpret_cast<const wchar_t*>();

    // // 计算需要的缓冲区大小（包括终止的空字符）
    // int bufferSize = WideCharToMultiByte(CP_ACP, 0, wStr, -1, nullptr, 0, nullptr, nullptr);
    // if (bufferSize == 0) {
    //     // 处理错误情况
    //     throw std::runtime_error("WideCharToMultiByte失败。");
    // }

    // // 分配缓冲区
    // char *buffer = new char[bufferSize];

    // // 执行转换
    // if (WideCharToMultiByte(CP_ACP, 0, wStr, -1, buffer, bufferSize, nullptr, nullptr) == 0) {
    //     // 处理错误情况
    //     delete[] buffer;
    //     throw std::runtime_error("WideCharToMultiByte转换失败。");
    // }

    // // 创建一个std::string并返回
    // std::string result(buffer, bufferSize - 1); // 减去终止的空字符

    // // 清理
    // delete[] buffer;
    // cout<<result<<endl;
    return "";
}
