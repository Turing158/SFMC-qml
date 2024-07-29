import QtQuick
import QtQuick.Controls
import Player 1.0



Window{
    property int isOnline: 1
    property string choiseVersion: ""
    id:window
    width: 900
    height: 450
    visible: true
    flags: Qt.Window | Qt.FramelessWindowHint
    color: "#00000000"
    Rectangle{
        id:main
        anchors.fill: parent
        color: "#AEC6CF"
        radius: 10
        border.color: "#273B42"
        border.width: 2
        Rectangle{
            id:top
            width: parent.width
            height: 50
            color: "#273B42"
            topLeftRadius: 10
            topRightRadius: 10
            focus: true
            Rectangle{
                width: 30
                height: 30
                color: "#00000000"
                anchors.verticalCenter: parent.verticalCenter
                x:10
                Loader{
                    source: "/comp/Icon.qml"
                }
            }
            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 50
                text: qsTr("StarFall Minecraft Launcher")
                font.pixelSize: 18
                font.family: "console"
                color: "#f1f1f1"
            }
            MouseArea{
                anchors.fill: parent
                property point clickPos: "0,0"
                onPressed: {
                    clickPos = Qt.point(mouseX, mouseY)
                }
                onPositionChanged: {
                    var delta = Qt.point(mouseX-clickPos.x, mouseY-clickPos.y)
                    window.setX(window.x+delta.x)
                    window.setY(window.y+delta.y)
                }
            }
            Rectangle{
                width: 30
                height: 30
                color: "#00000000"
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 10
                Loader{
                    asynchronous: true
                    source: "/comp/CloseBtn.qml"
                }
            }
            Rectangle{
                width: 30
                height: 30
                color: "#00000000"
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 50
                Loader{
                    asynchronous: true
                    source: "/comp/MiniBtn.qml"
                }
            }
            Rectangle{
                anchors.centerIn: parent
                width:200
                height: 50
                color:"transparent"
                Loader{
                    source: "/comp/TopBtn.qml"
                }
            }

        }
        Rectangle{
            id:mainPage
            y: top.height
            width: window.width
            height: window.height-top.height
            bottomLeftRadius: 10
            bottomRightRadius: 10
            color:"transparent"
            Rectangle{
                id:leftCompBg
                width: mainPage.width/2-100
                height: mainPage.height-40
                color: "#fff"
                opacity: 0.6
                radius: 10
                x:20
                y:20
                Behavior on width{
                    animation: bounce
                }
            }
            Loader{
                id:mainPageLoader
                asynchronous: true
                source: "/view/Home.qml"
                onSourceChanged: {
                    changePgaeOpacity.start()
                }
            }

        }
        PlayerInfo{
            id: player
        }
    }
    PropertyAnimation{
        id:changePgaeOpacity
        target: mainPageLoader
        properties: "opacity"
        from: 0
        to: 1
        duration: 200
    }
    PropertyAnimation{
        id:bounce
        easing{
            type: Easing.OutElastic
            amplitude: 1
            period: 1
        }
        duration: 200
    }
    signal miniWindow()
    onMiniWindow: {
        showMinimized()
    }
}
