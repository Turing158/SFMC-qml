#include "player.h"

Player::Player(QObject *parent)
    : QObject{parent}
{}

QString Player::getOutlineSkin() const
{
    return outlineSkin;
}

void Player::setOutlineSkin(const QString &newOutlineSkin)
{
    if (outlineSkin == newOutlineSkin)
        return;
    outlineSkin = newOutlineSkin;
    emit outlineSkinChanged();
}

QString Player::getOnlineSkin() const
{
    return onlineSkin;
}

void Player::setOnlineSkin(const QString &newOnlineSkin)
{
    if (onlineSkin == newOnlineSkin)
        return;
    onlineSkin = newOnlineSkin;
    emit onlineSkinChanged();
}

QString Player::getOnlineUuid() const
{
    return onlineUuid;
}

void Player::setOnlineUuid(const QString &newOnlineUuid)
{
    if (onlineUuid == newOnlineUuid)
        return;
    onlineUuid = newOnlineUuid;
    emit onlineUuidChanged();
}

QString Player::getOnlineAccessToken() const
{
    return onlineAccessToken;
}

void Player::setOnlineAccessToken(const QString &newOnlineAccessToken)
{
    if (onlineAccessToken == newOnlineAccessToken)
        return;
    onlineAccessToken = newOnlineAccessToken;
    emit onlineAccessTokenChanged();
}

QString Player::getOnlinePlayerUser() const
{
    return onlinePlayerUser;
}

void Player::setOnlinePlayerUser(const QString &newOnlinePlayerUser)
{
    if (onlinePlayerUser == newOnlinePlayerUser)
        return;
    onlinePlayerUser = newOnlinePlayerUser;
    emit onlinePlayerUserChanged();
}

QString Player::getOutlineUuid() const
{
    return outlineUuid;
}

void Player::setOutlineUuid(const QString &newOutlineUuid)
{
    if (outlineUuid == newOutlineUuid)
        return;
    outlineUuid = newOutlineUuid;
    emit outlineUuidChanged();
}

QString Player::getOutlinePlayerUser() const
{
    return outlinePlayerUser;
}

void Player::setOutlinePlayerUser(const QString &newOutlinePlayerUser)
{
    if (outlinePlayerUser == newOutlinePlayerUser)
        return;
    outlinePlayerUser = newOutlinePlayerUser;
    emit outlinePlayerUserChanged();
}
