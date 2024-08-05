/****************************************************************************
** Meta object code from reading C++ file 'launcher.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.7.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../src/launcher.h"
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'launcher.h' doesn't include <QObject>."
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
struct qt_meta_stringdata_CLASSLauncherENDCLASS_t {};
constexpr auto qt_meta_stringdata_CLASSLauncherENDCLASS = QtMocHelpers::stringData(
    "Launcher",
    "osChanged",
    "",
    "frameworkChanged",
    "selectDirChanged",
    "selectVersionChanged",
    "memoryMaxChanged",
    "usernameChanged",
    "uuidChanged",
    "widthChanged",
    "heightChanged",
    "javaPathChanged",
    "isIsolateChanged",
    "launchMc",
    "os",
    "framework",
    "selectDir",
    "selectVersion",
    "memoryMax",
    "username",
    "uuid",
    "width",
    "height",
    "javaPath",
    "isIsolate"
);
#else  // !QT_MOC_HAS_STRINGDATA
#error "qtmochelpers.h not found or too old."
#endif // !QT_MOC_HAS_STRINGDATA
} // unnamed namespace

Q_CONSTINIT static const uint qt_meta_data_CLASSLauncherENDCLASS[] = {

 // content:
      12,       // revision
       0,       // classname
       0,    0, // classinfo
      12,   14, // methods
      11,   98, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
      11,       // signalCount

 // signals: name, argc, parameters, tag, flags, initial metatype offsets
       1,    0,   86,    2, 0x06,   12 /* Public */,
       3,    0,   87,    2, 0x06,   13 /* Public */,
       4,    0,   88,    2, 0x06,   14 /* Public */,
       5,    0,   89,    2, 0x06,   15 /* Public */,
       6,    0,   90,    2, 0x06,   16 /* Public */,
       7,    0,   91,    2, 0x06,   17 /* Public */,
       8,    0,   92,    2, 0x06,   18 /* Public */,
       9,    0,   93,    2, 0x06,   19 /* Public */,
      10,    0,   94,    2, 0x06,   20 /* Public */,
      11,    0,   95,    2, 0x06,   21 /* Public */,
      12,    0,   96,    2, 0x06,   22 /* Public */,

 // methods: name, argc, parameters, tag, flags, initial metatype offsets
      13,    0,   97,    2, 0x02,   23 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // methods: parameters
    QMetaType::Void,

 // properties: name, type, flags
      14, QMetaType::QString, 0x00015903, uint(0), 0,
      15, QMetaType::QString, 0x00015903, uint(1), 0,
      16, QMetaType::QString, 0x00015903, uint(2), 0,
      17, QMetaType::QString, 0x00015903, uint(3), 0,
      18, QMetaType::Int, 0x00015903, uint(4), 0,
      19, QMetaType::QString, 0x00015903, uint(5), 0,
      20, QMetaType::QString, 0x00015903, uint(6), 0,
      21, QMetaType::Int, 0x00015903, uint(7), 0,
      22, QMetaType::Int, 0x00015903, uint(8), 0,
      23, QMetaType::QString, 0x00015903, uint(9), 0,
      24, QMetaType::Int, 0x00015903, uint(10), 0,

       0        // eod
};

Q_CONSTINIT const QMetaObject Launcher::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_CLASSLauncherENDCLASS.offsetsAndSizes,
    qt_meta_data_CLASSLauncherENDCLASS,
    qt_static_metacall,
    nullptr,
    qt_incomplete_metaTypeArray<qt_meta_stringdata_CLASSLauncherENDCLASS_t,
        // property 'os'
        QtPrivate::TypeAndForceComplete<QString, std::true_type>,
        // property 'framework'
        QtPrivate::TypeAndForceComplete<QString, std::true_type>,
        // property 'selectDir'
        QtPrivate::TypeAndForceComplete<QString, std::true_type>,
        // property 'selectVersion'
        QtPrivate::TypeAndForceComplete<QString, std::true_type>,
        // property 'memoryMax'
        QtPrivate::TypeAndForceComplete<int, std::true_type>,
        // property 'username'
        QtPrivate::TypeAndForceComplete<QString, std::true_type>,
        // property 'uuid'
        QtPrivate::TypeAndForceComplete<QString, std::true_type>,
        // property 'width'
        QtPrivate::TypeAndForceComplete<int, std::true_type>,
        // property 'height'
        QtPrivate::TypeAndForceComplete<int, std::true_type>,
        // property 'javaPath'
        QtPrivate::TypeAndForceComplete<QString, std::true_type>,
        // property 'isIsolate'
        QtPrivate::TypeAndForceComplete<int, std::true_type>,
        // Q_OBJECT / Q_GADGET
        QtPrivate::TypeAndForceComplete<Launcher, std::true_type>,
        // method 'osChanged'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'frameworkChanged'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'selectDirChanged'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'selectVersionChanged'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'memoryMaxChanged'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'usernameChanged'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'uuidChanged'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'widthChanged'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'heightChanged'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'javaPathChanged'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'isIsolateChanged'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'launchMc'
        QtPrivate::TypeAndForceComplete<void, std::false_type>
    >,
    nullptr
} };

void Launcher::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<Launcher *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->osChanged(); break;
        case 1: _t->frameworkChanged(); break;
        case 2: _t->selectDirChanged(); break;
        case 3: _t->selectVersionChanged(); break;
        case 4: _t->memoryMaxChanged(); break;
        case 5: _t->usernameChanged(); break;
        case 6: _t->uuidChanged(); break;
        case 7: _t->widthChanged(); break;
        case 8: _t->heightChanged(); break;
        case 9: _t->javaPathChanged(); break;
        case 10: _t->isIsolateChanged(); break;
        case 11: _t->launchMc(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (Launcher::*)();
            if (_t _q_method = &Launcher::osChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (Launcher::*)();
            if (_t _q_method = &Launcher::frameworkChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (Launcher::*)();
            if (_t _q_method = &Launcher::selectDirChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (Launcher::*)();
            if (_t _q_method = &Launcher::selectVersionChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 3;
                return;
            }
        }
        {
            using _t = void (Launcher::*)();
            if (_t _q_method = &Launcher::memoryMaxChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 4;
                return;
            }
        }
        {
            using _t = void (Launcher::*)();
            if (_t _q_method = &Launcher::usernameChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 5;
                return;
            }
        }
        {
            using _t = void (Launcher::*)();
            if (_t _q_method = &Launcher::uuidChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 6;
                return;
            }
        }
        {
            using _t = void (Launcher::*)();
            if (_t _q_method = &Launcher::widthChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 7;
                return;
            }
        }
        {
            using _t = void (Launcher::*)();
            if (_t _q_method = &Launcher::heightChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 8;
                return;
            }
        }
        {
            using _t = void (Launcher::*)();
            if (_t _q_method = &Launcher::javaPathChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 9;
                return;
            }
        }
        {
            using _t = void (Launcher::*)();
            if (_t _q_method = &Launcher::isIsolateChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 10;
                return;
            }
        }
    } else if (_c == QMetaObject::ReadProperty) {
        auto *_t = static_cast<Launcher *>(_o);
        (void)_t;
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = _t->getOs(); break;
        case 1: *reinterpret_cast< QString*>(_v) = _t->getFramework(); break;
        case 2: *reinterpret_cast< QString*>(_v) = _t->getSelectDir(); break;
        case 3: *reinterpret_cast< QString*>(_v) = _t->getSelectVersion(); break;
        case 4: *reinterpret_cast< int*>(_v) = _t->getMemoryMax(); break;
        case 5: *reinterpret_cast< QString*>(_v) = _t->getUsername(); break;
        case 6: *reinterpret_cast< QString*>(_v) = _t->getUuid(); break;
        case 7: *reinterpret_cast< int*>(_v) = _t->getWidth(); break;
        case 8: *reinterpret_cast< int*>(_v) = _t->getHeight(); break;
        case 9: *reinterpret_cast< QString*>(_v) = _t->getJavaPath(); break;
        case 10: *reinterpret_cast< int*>(_v) = _t->getIsIsolate(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        auto *_t = static_cast<Launcher *>(_o);
        (void)_t;
        void *_v = _a[0];
        switch (_id) {
        case 0: _t->setOs(*reinterpret_cast< QString*>(_v)); break;
        case 1: _t->setFramework(*reinterpret_cast< QString*>(_v)); break;
        case 2: _t->setSelectDir(*reinterpret_cast< QString*>(_v)); break;
        case 3: _t->setSelectVersion(*reinterpret_cast< QString*>(_v)); break;
        case 4: _t->setMemoryMax(*reinterpret_cast< int*>(_v)); break;
        case 5: _t->setUsername(*reinterpret_cast< QString*>(_v)); break;
        case 6: _t->setUuid(*reinterpret_cast< QString*>(_v)); break;
        case 7: _t->setWidth(*reinterpret_cast< int*>(_v)); break;
        case 8: _t->setHeight(*reinterpret_cast< int*>(_v)); break;
        case 9: _t->setJavaPath(*reinterpret_cast< QString*>(_v)); break;
        case 10: _t->setIsIsolate(*reinterpret_cast< int*>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    } else if (_c == QMetaObject::BindableProperty) {
    }
    (void)_a;
}

const QMetaObject *Launcher::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *Launcher::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_CLASSLauncherENDCLASS.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int Launcher::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 12)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 12;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 12)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 12;
    }else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::BindableProperty
            || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 11;
    }
    return _id;
}

// SIGNAL 0
void Launcher::osChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void Launcher::frameworkChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void Launcher::selectDirChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void Launcher::selectVersionChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}

// SIGNAL 4
void Launcher::memoryMaxChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 4, nullptr);
}

// SIGNAL 5
void Launcher::usernameChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 5, nullptr);
}

// SIGNAL 6
void Launcher::uuidChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 6, nullptr);
}

// SIGNAL 7
void Launcher::widthChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 7, nullptr);
}

// SIGNAL 8
void Launcher::heightChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 8, nullptr);
}

// SIGNAL 9
void Launcher::javaPathChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 9, nullptr);
}

// SIGNAL 10
void Launcher::isIsolateChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 10, nullptr);
}
QT_WARNING_POP
