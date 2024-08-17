#ifndef STDUTIL_H
#define STDUTIL_H

#include <QObject>
#include <string>
#include <vector>
using namespace std;
class StdUtil : public QObject
{
    Q_OBJECT
public:
    explicit StdUtil(QObject *parent = nullptr);

    string replaceStr(string original,string oldStr,string newStr);
    vector<string> splitStr(string str, string delimiter);
    string wcharToUtf8(const wchar_t* wstr);
    string QStringToString(QString qs);
    string random_str(int len);
    void extracted(vector<string> list);
    vector<string> outRepeated(vector<string> list);
    string paraExistSpace(string str);
    bool isNumber(string str);

  signals:
};

#endif // STDUTIL_H
