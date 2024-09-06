#include "filedirutil.h"

FileDirUtil::FileDirUtil(QObject *parent)
    : QObject{parent}
{}

//检测文件是否存在
bool FileDirUtil::existFile(QString pathStr){
    QFile file(pathStr);
    return file.exists();
}
bool FileDirUtil::existFile(string pathStr){
    return existFile(QString::fromLocal8Bit(pathStr));
}

//读取文件，变成一行
QString FileDirUtil::readFile(string filePath){
    QString path = QString::fromStdString(filePath);
    return readFile(path);
}
QString FileDirUtil::readFile(QString filePath){
    qDebug()<<"读取文件："<<filePath;
    QString result;
    QFile file(filePath);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qDebug() << "无法打开文件：" << filePath;
        return "";
    }
    QTextStream in(&file);
    while (!in.atEnd()) {
        result += in.readLine();
    }
    file.close();
    return result;
}

// 判断文件符不符合，辅助下一个函数
bool FileDirUtil::flagFilename(const QString &str,const QString &flagStr,FlagFilename flag,bool isCaseSensitiveForFileName){
    if(flag == FlagFilename::StartWith){
        return str.startsWith(flagStr,isCaseSensitiveForFileName ? Qt::CaseSensitive : Qt::CaseInsensitive);
    }
    else if(flag == FlagFilename::EndWith){
        return str.endsWith(flagStr,isCaseSensitiveForFileName ? Qt::CaseSensitive : Qt::CaseInsensitive);
    }
    return str.contains(flagStr,isCaseSensitiveForFileName ? Qt::CaseSensitive : Qt::CaseInsensitive);

}

//将目录下的所有在文件夹内的文件放到目录下,并删除不符合的文件
void FileDirUtil::moveFileToTopLevelAndDelOtherFile(const QString &path,QString flagStr,FlagFilename flag,bool isCaseSensitiveForFileName) {
    QDir dir(path);
    QStringList entries = dir.entryList(QDir::Files | QDir::Dirs | QDir::NoDotAndDotDot);
    foreach (const QString &entry, entries) {
        QString fullPath = dir.filePath(entry);
        if (dir.cd(entry) && dir.path() != "/") {
            moveFileToTopLevelAndDelOtherFile(fullPath,flagStr,flag,isCaseSensitiveForFileName);
            dir.cdUp();
        }
        else if (QFileInfo(fullPath).isFile()) {
            if(flagFilename(entry,flagStr,flag,isCaseSensitiveForFileName)){
                QString destFilePath = path + "/" + entry;
                if(fullPath == destFilePath){
                    continue;
                }
                if(!QFile::rename(fullPath, destFilePath)){
                    QFile::remove(fullPath);
                }
            }
            else{
                QFile::remove(fullPath);
            }
        }
    }
}

//删除当前目录下的所有目录
bool FileDirUtil::delPathAllFolder(QString path){
    QDir dir(path);
    QStringList dirList = dir.entryList(QDir::NoDotAndDotDot | QDir::Dirs);
    foreach (const QString &e, dirList) {
        if(!dir.rmdir(e)){
            delPathAllFolder(path+"/"+e);
        }
        dir.rmdir(e);
    }
    return true;
}

//  删除文件夹，如果文件夹内有文件，会删除不了
bool FileDirUtil::delDir(QString dirPath){
    QDir dir(dirPath);
    if(dir.exists()){
        return dir.rmdir(dirPath);
    }
    return false;
}

//删除该文件夹内所有文件
bool FileDirUtil::delDirFile(QString dirPath) {
    bool result = true;
    QDir dir(dirPath);
    if (!dir.exists()) {
        return false;
    }
    QFileInfoList files = dir.entryInfoList(QDir::NoDotAndDotDot | QDir::AllEntries);
    foreach (QFileInfo file, files) {
        if (file.isDir()) {
            result = delDirFile(file.absoluteFilePath()) && result;
        } else {
            result = QFile::remove(file.absoluteFilePath()) && result;
        }
    }
    return result;
}

//  删除文件夹内所有内容
bool FileDirUtil::delDirAllContent(QString dirPath){
    delDirFile(dirPath);
    return delPathAllFolder(dirPath);
}

//  删除文件夹内所有内容，并删除目标文件夹
bool FileDirUtil::delDirAllContentAndDir(QString dirPath){
    delDirFile(dirPath);
    delPathAllFolder(dirPath);
    return delDir(dirPath);
}
