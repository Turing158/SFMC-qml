#ifndef STDUTIL_H
#define STDUTIL_H

#include <QObject>
#include <string>
#include <vector>
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <filesystem>
using namespace std;
class StdUtil : public QObject
{
    Q_OBJECT
public:
    explicit StdUtil(QObject *parent = nullptr);

    string replaceStr(const string &original,const string &oldStr,const string &newStr);
    vector<string> splitStr(const string &str, const string &delimiter);
    string wcharToUtf8(const wchar_t* wstr);
    string QStringToStringLocal8Bit(const QString &qs);
    string random_str(int len);
    void extracted(const vector<string> &list);
    vector<string> outRepeated(const vector<string> &list);
    string paraExistSpace(const string &str);
    bool isNumber(const string &str);
    QString getPathParentPath(const QString &path);
    string getPathParentPath(const string &path);
  signals:
};

#endif // STDUTIL_H
