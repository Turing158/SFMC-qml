#ifndef STDUTIL_H
#define STDUTIL_H

#include <QObject>
#include <string>
#include <vector>
#define WIN32_LEAN_AND_MEAN
#include <windows.h>

using namespace std;
class StdUtil : public QObject
{
    Q_OBJECT
public:
    explicit StdUtil(QObject *parent = nullptr);

    string replaceStr(string original,string oldStr,string newStr);
    vector<string> splitStr(string str, string delimiter);
    string wcharToUtf8(const wchar_t* wstr);
    string QStringToStringLocal8Bit(QString qs);
    string random_str(int len);
    void extracted(vector<string> list);
    vector<string> outRepeated(vector<string> list);
    string paraExistSpace(string str);
    bool isNumber(string str);
    string QStringToStringANSI(QString qStr);
    QString getPathParentPath(QString path);

  signals:
};

#endif // STDUTIL_H
