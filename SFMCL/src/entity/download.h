#ifndef DOWNLOAD_H
#define DOWNLOAD_H

#include <string>
using namespace std;
class Download {
public:
    Download();
    string path;
    string url;
    string sha1;
    int size;

    Download(const string &path, const string &url, const string &sha1, int size);

    bool operator==(const Download &rhs) const;

    bool operator!=(const Download &rhs) const;
};

#endif // DOWNLOAD_H
