/****************************************************************************
** Meta object code from reading C++ file 'player.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.7.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../src/player.h"
#include <QtNetwork/QSslPreSharedKeyAuthenticator>
#include <QtNetwork/QSslError>
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'player.h' doesn't include <QObject>."
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
struct qt_meta_stringdata_CLASSPlayerENDCLASS_t {};
constexpr auto qt_meta_stringdata_CLASSPlayerENDCLASS = QtMocHelpers::stringData(
    "Player",
    "outlinePlayerUserChanged",
    "",
    "outlineUuidChanged",
    "onlinePlayerUserChanged",
    "onlineAccessTokenChanged",
    "onlineUuidChanged",
    "outlinePlayerUser",
    "outlineUuid",
    "onlinePlayerUser",
    "onlineAccessToken",
    "onlineUuid"
);
#else  // !QT_MOC_HAS_STRINGDATA
#error "qtmochelpers.h not found or too old."
#endif // !QT_MOC_HAS_STRINGDATA
} // unnamed namespace

Q_CONSTINIT static const uint qt_meta_data_CLASSPlayerENDCLASS[] = {

 // content:
      12,       // revision
       0,       // classname
       0,    0, // classinfo
       5,   14, // methods
       5,   49, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       5,       // signalCount

 // signals: name, argc, parameters, tag, flags, initial metatype offsets
       1,    0,   44,    2, 0x06,    6 /* Public */,
       3,    0,   45,    2, 0x06,    7 /* Public */,
       4,    0,   46,    2, 0x06,    8 /* Public */,
       5,    0,   47,    2, 0x06,    9 /* Public */,
       6,    0,   48,    2, 0x06,   10 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // properties: name, type, flags
       7, QMetaType::QString, 0x00015903, uint(0), 0,
       8, QMetaType::QString, 0x00015903, uint(1), 0,
       9, QMetaType::QString, 0x00015903, uint(2), 0,
      10, QMetaType::QString, 0x00015903, uint(3), 0,
      11, QMetaType::QString, 0x00015903, uint(4), 0,

       0        // eod
};

Q_CONSTINIT const QMetaObject Player::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_CLASSPlayerENDCLASS.offsetsAndSizes,
    qt_meta_data_CLASSPlayerENDCLASS,
    qt_static_metacall,
    nullptr,
    qt_incomplete_metaTypeArray<qt_meta_stringdata_CLASSPlayerENDCLASS_t,
        // property 'outlinePlayerUser'
        QtPrivate::TypeAndForceComplete<QString, std::true_type>,
        // property 'outlineUuid'
        QtPrivate::TypeAndForceComplete<QString, std::true_type>,
        // property 'onlinePlayerUser'
        QtPrivate::TypeAndForceComplete<QString, std::true_type>,
        // property 'onlineAccessToken'
        QtPrivate::TypeAndForceComplete<QString, std::true_type>,
        // property 'onlineUuid'
        QtPrivate::TypeAndForceComplete<QString, std::true_type>,
        // Q_OBJECT / Q_GADGET
        QtPrivate::TypeAndForceComplete<Player, std::true_type>,
        // method 'outlinePlayerUserChanged'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'outlineUuidChanged'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'onlinePlayerUserChanged'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'onlineAccessTokenChanged'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'onlineUuidChanged'
        QtPrivate::TypeAndForceComplete<void, std::false_type>
    >,
    nullptr
} };

void Player::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<Player *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->outlinePlayerUserChanged(); break;
        case 1: _t->outlineUuidChanged(); break;
        case 2: _t->onlinePlayerUserChanged(); break;
        case 3: _t->onlineAccessTokenChanged(); break;
        case 4: _t->onlineUuidChanged(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (Player::*)();
            if (_t _q_method = &Player::outlinePlayerUserChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (Player::*)();
            if (_t _q_method = &Player::outlineUuidChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (Player::*)();
            if (_t _q_method = &Player::onlinePlayerUserChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (Player::*)();
            if (_t _q_method = &Player::onlineAccessTokenChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 3;
                return;
            }
        }
        {
            using _t = void (Player::*)();
            if (_t _q_method = &Player::onlineUuidChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 4;
                return;
            }
        }
    } else if (_c == QMetaObject::ReadProperty) {
        auto *_t = static_cast<Player *>(_o);
        (void)_t;
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = _t->getOutlinePlayerUser(); break;
        case 1: *reinterpret_cast< QString*>(_v) = _t->getOutlineUuid(); break;
        case 2: *reinterpret_cast< QString*>(_v) = _t->getOnlinePlayerUser(); break;
        case 3: *reinterpret_cast< QString*>(_v) = _t->getOnlineAccessToken(); break;
        case 4: *reinterpret_cast< QString*>(_v) = _t->getOnlineUuid(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        auto *_t = static_cast<Player *>(_o);
        (void)_t;
        void *_v = _a[0];
        switch (_id) {
        case 0: _t->setOutlinePlayerUser(*reinterpret_cast< QString*>(_v)); break;
        case 1: _t->setOutlineUuid(*reinterpret_cast< QString*>(_v)); break;
        case 2: _t->setOnlinePlayerUser(*reinterpret_cast< QString*>(_v)); break;
        case 3: _t->setOnlineAccessToken(*reinterpret_cast< QString*>(_v)); break;
        case 4: _t->setOnlineUuid(*reinterpret_cast< QString*>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    } else if (_c == QMetaObject::BindableProperty) {
    }
    (void)_a;
}

const QMetaObject *Player::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *Player::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_CLASSPlayerENDCLASS.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int Player::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 5)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 5;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 5)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 5;
    }else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::BindableProperty
            || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 5;
    }
    return _id;
}

// SIGNAL 0
void Player::outlinePlayerUserChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void Player::outlineUuidChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void Player::onlinePlayerUserChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void Player::onlineAccessTokenChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}

// SIGNAL 4
void Player::onlineUuidChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 4, nullptr);
}
QT_WARNING_POP
