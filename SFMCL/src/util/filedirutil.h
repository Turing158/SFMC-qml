#ifndef FILEDIRUTIL_H
#define FILEDIRUTIL_H

#include <QObject>
#include <QFile>
#include <QDir>
using namespace std;
class FileDirUtil : public QObject
{
    Q_OBJECT
public:
    explicit FileDirUtil(QObject *parent = nullptr);

    enum FlagFilename{
        Contain = 0,
        StartWith = 1,
        EndWith = 2,
    };

    bool existFile(QString pathStr);
    bool existFile(string pathStr);
    QString readFile(QString filePath);
    QString readFile(string filePath);
    bool flagFilename(const QString &str,const QString &flagStr,FlagFilename flag = FlagFilename::Contain,bool isCaseSensitiveForFileName = false);
    void moveFileToTopLevelAndDelOtherFile(const QString &path,QString flagStr,FlagFilename flag = FlagFilename::Contain,bool isCaseSensitiveForFileName = false);
    bool delPathAllFolder(QString path);
    bool delDir(QString dirPath);
    bool delDirFile(QString dirPath);
    bool delDirAllContent(QString dirPath);
    bool delDirAllContentAndDir(QString dirPath);

signals:
};

#endif // FILEDIRUTIL_H
