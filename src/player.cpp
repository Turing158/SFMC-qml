#include "player.h"

Player::Player(QObject *parent)
    : QObject{parent}
{}

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
