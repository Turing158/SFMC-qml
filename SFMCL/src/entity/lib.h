#ifndef LIB_H
#define LIB_H

#include <string>
#include <map>
#include "download.h"
using namespace std;
class Lib
{
public:
    Lib();
    string name;
    string path;
    bool isNativesLinux;
    bool isNativesWindows;
    bool isNativesMacos;
    Download artifact;
    map<string,Download> classifiers;

    Lib(const string &name, const string &path, bool isNativesLinux, bool isNativesWindows, bool isNativesMacos,
        const Download &artifact, const map<string, Download> &classifiers);


};

#endif // LIB_H
