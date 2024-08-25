#ifndef PLAYER_H
#define PLAYER_H

#include <QObject>
#include <QtQml>
class Player : public QObject
{
    Q_OBJECT
    // QML_ELEMENT
public:
    explicit Player(QObject *parent = nullptr);
    QString outlinePlayerUser;
    QString outlineUuid;
    QString onlinePlayerUser;
    QString onlineAccessToken;
    QString onlineUuid;


    QString getOutlinePlayerUser() const;
    void setOutlinePlayerUser(const QString &newOutlinePlayerUser);

    QString getOutlineUuid() const;
    void setOutlineUuid(const QString &newOutlineUuid);

    QString getOnlinePlayerUser() const;
    void setOnlinePlayerUser(const QString &newOnlinePlayerUser);

    QString getOnlineAccessToken() const;
    void setOnlineAccessToken(const QString &newOnlineAccessToken);

    QString getOnlineUuid() const;
    void setOnlineUuid(const QString &newOnlineUuid);

signals:
    void outlinePlayerUserChanged();
    void outlineUuidChanged();

    void onlinePlayerUserChanged();

    void onlineAccessTokenChanged();

    void onlineUuidChanged();

private:
    Q_PROPERTY(QString outlinePlayerUser READ getOutlinePlayerUser WRITE setOutlinePlayerUser NOTIFY outlinePlayerUserChanged FINAL)
    Q_PROPERTY(QString outlineUuid READ getOutlineUuid WRITE setOutlineUuid NOTIFY outlineUuidChanged FINAL)
    Q_PROPERTY(QString onlinePlayerUser READ getOnlinePlayerUser WRITE setOnlinePlayerUser NOTIFY onlinePlayerUserChanged FINAL)
    Q_PROPERTY(QString onlineAccessToken READ getOnlineAccessToken WRITE setOnlineAccessToken NOTIFY onlineAccessTokenChanged FINAL)
    Q_PROPERTY(QString onlineUuid READ getOnlineUuid WRITE setOnlineUuid NOTIFY onlineUuidChanged FINAL)
};

#endif // PLAYER_H
