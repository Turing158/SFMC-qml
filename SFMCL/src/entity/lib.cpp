#include "Lib.h"

#include "download.h"
using namespace std;
Lib::Lib(){

}

Lib::Lib(const string &name, const string &path, bool isNativesLinux, bool isNativesWindows, bool isNativesMacos,
         const Download &artifact, const map<string, Download> &classifiers) : name(name), path(path),
    isNativesLinux(isNativesLinux),
    isNativesWindows(isNativesWindows),
    isNativesMacos(isNativesMacos),
    artifact(artifact),
    classifiers(classifiers) {

}
