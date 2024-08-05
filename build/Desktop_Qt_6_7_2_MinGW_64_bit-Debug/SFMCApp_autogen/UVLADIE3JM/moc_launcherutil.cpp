/****************************************************************************
** Meta object code from reading C++ file 'launcherutil.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.7.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../src/launcherutil.h"
#include <QtNetwork/QSslPreSharedKeyAuthenticator>
#include <QtNetwork/QSslError>
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'launcherutil.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 68
#error "This file was generated using the moc from 6.7.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

#ifndef Q_CONSTINIT
#define Q_CONSTINIT
#endif

QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
QT_WARNING_DISABLE_GCC("-Wuseless-cast")
namespace {

#ifdef QT_MOC_HAS_STRINGDATA
struct qt_meta_stringdata_CLASSLauncherUtilENDCLASS_t {};
constexpr auto qt_meta_stringdata_CLASSLauncherUtilENDCLASS = QtMocHelpers::stringData(
    "LauncherUtil",
    "findVersion",
    "",
    "dirPath",
    "getClientVersion",
    "string",
    "json",
    "isOptifine",
    "isForge",
    "isFabric",
    "generateUUID",
    "random_str",
    "len"
);
#else  // !QT_MOC_HAS_STRINGDATA
#error "qtmochelpers.h not found or too old."
#endif // !QT_MOC_HAS_STRINGDATA
} // unnamed namespace

Q_CONSTINIT static const uint qt_meta_data_CLASSLauncherUtilENDCLASS[] = {

 // content:
      12,       // revision
       0,       // classname
       0,    0, // classinfo
       7,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // methods: name, argc, parameters, tag, flags, initial metatype offsets
       1,    1,   56,    2, 0x02,    1 /* Public */,
       4,    1,   59,    2, 0x02,    3 /* Public */,
       7,    1,   62,    2, 0x02,    5 /* Public */,
       8,    1,   65,    2, 0x02,    7 /* Public */,
       9,    1,   68,    2, 0x02,    9 /* Public */,
      10,    0,   71,    2, 0x02,   11 /* Public */,
      11,    1,   72,    2, 0x02,   12 /* Public */,

 // methods: parameters
    QMetaType::QVariantList, QMetaType::QString,    3,
    0x80000000 | 5, 0x80000000 | 5,    6,
    QMetaType::Int, 0x80000000 | 5,    6,
    QMetaType::Int, 0x80000000 | 5,    6,
    QMetaType::Int, 0x80000000 | 5,    6,
    0x80000000 | 5,
    0x80000000 | 5, QMetaType::Int,   12,

       0        // eod
};

Q_CONSTINIT const QMetaObject LauncherUtil::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_CLASSLauncherUtilENDCLASS.offsetsAndSizes,
    qt_meta_data_CLASSLauncherUtilENDCLASS,
    qt_static_metacall,
    nullptr,
    qt_incomplete_metaTypeArray<qt_meta_stringdata_CLASSLauncherUtilENDCLASS_t,
        // Q_OBJECT / Q_GADGET
        QtPrivate::TypeAndForceComplete<LauncherUtil, std::true_type>,
        // method 'findVersion'
        QtPrivate::TypeAndForceComplete<QVariantList, std::false_type>,
        QtPrivate::TypeAndForceComplete<QString, std::false_type>,
        // method 'getClientVersion'
        QtPrivate::TypeAndForceComplete<string, std::false_type>,
        QtPrivate::TypeAndForceComplete<string, std::false_type>,
        // method 'isOptifine'
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        QtPrivate::TypeAndForceComplete<string, std::false_type>,
        // method 'isForge'
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        QtPrivate::TypeAndForceComplete<string, std::false_type>,
        // method 'isFabric'
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        QtPrivate::TypeAndForceComplete<string, std::false_type>,
        // method 'generateUUID'
        QtPrivate::TypeAndForceComplete<string, std::false_type>,
        // method 'random_str'
        QtPrivate::TypeAndForceComplete<string, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>
    >,
    nullptr
} };

void LauncherUtil::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<LauncherUtil *>(_o);
        (void)_t;
        switch (_id) {
        case 0: { QVariantList _r = _t->findVersion((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVariantList*>(_a[0]) = std::move(_r); }  break;
        case 1: { string _r = _t->getClientVersion((*reinterpret_cast< std::add_pointer_t<string>>(_a[1])));
            if (_a[0]) *reinterpret_cast< string*>(_a[0]) = std::move(_r); }  break;
        case 2: { int _r = _t->isOptifine((*reinterpret_cast< std::add_pointer_t<string>>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 3: { int _r = _t->isForge((*reinterpret_cast< std::add_pointer_t<string>>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 4: { int _r = _t->isFabric((*reinterpret_cast< std::add_pointer_t<string>>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 5: { string _r = _t->generateUUID();
            if (_a[0]) *reinterpret_cast< string*>(_a[0]) = std::move(_r); }  break;
        case 6: { string _r = _t->random_str((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])));
            if (_a[0]) *reinterpret_cast< string*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    }
}

const QMetaObject *LauncherUtil::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *LauncherUtil::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_CLASSLauncherUtilENDCLASS.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int LauncherUtil::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 7)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 7;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 7)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 7;
    }
    return _id;
}
QT_WARNING_POP
