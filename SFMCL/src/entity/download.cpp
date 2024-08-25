#include "download.h"

Download::Download(){

}

Download::Download(const string &path, const string &url, const string &sha1, int size) : path(path), url(url),
    sha1(sha1), size(size) {}
