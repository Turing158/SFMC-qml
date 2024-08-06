import QtQuick
import QtQuick.Controls
import Player 1.0
import LauncherUtil 1.0
import Launcher 1.0


Window{
    property int isOnline: 1
    property string choiseVersion: ""
    property var dirList: []
    id:window
    width: 850
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
            z: 999
            Rectangle{
                id: mainWindowElement
                color: "#00000000"
                width: parent.width
                height: parent.height
                opacity: 1
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
            }

            Text{
                id: subWindowTitle
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 50
                text: qsTr("")
                font.pixelSize: 18
                font.family: "console"
                color: "#f1f1f1"
                opacity: 0
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
                id: topBtn
                anchors.horizontalCenter: parent.horizontalCenter
                width:200
                height: 50
                y: 0
                color:"transparent"
                Loader{
                    source: "/comp/TopBtn.qml"
                }
            }
            Rectangle{
                id: backBtn
                width: 30
                height: 30
                color: "#00000000"
                anchors.verticalCenter: parent.verticalCenter
                x: -50
                Loader{
                    source: "/comp/BackBtn.qml"
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
            Loader{
                id:subPageLoader
                asynchronous: true
                source: ""
                opacity: 0
                z: -1
                onSourceChanged: {
                    subChangePgaeOpacity.start()
                }
                onOpacityChanged: {
                    if(subPageLoader.opacity <= 0.01){
                        subPageLoader.z = -1
                    }
                    else{
                        subPageLoader.z = 1
                    }
                }
            }

        }
        PlayerInfo{
            id: player
        }
        LauncherUtil{
            id: launcherUtil
        }
        Launcher{
            id: launcher
            selectDir: ""
            selectVersion: ""
            memoryMax: 2000
            username: ""
            uuid: ""
            signal initLauncher()

            Component.onCompleted: {
                initLauncher()
            }
        }
        Connections{
            target: launcher
            function onInitLauncher(){
                // launcher.selectDir = "E:/Game/test/.minecraft"
                launcher.selectDir = launcherUtil.getCurrentPath()
                dirList.push(launcher.selectDir)
                var list = launcherUtil.findVersion(launcher.selectDir)
                if(list.length !== 0){
                    launcher.selectVersion = list[0]
                }
            }
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
        id:subChangePgaeOpacity
        target: subPageLoader
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
    ParallelAnimation{
        id: subWindowShow
        PropertyAnimation{
            target: mainWindowElement
            properties: "opacity"
            to: 0
            duration: 200
        }
        PropertyAnimation{
            target: subWindowTitle
            properties: "opacity"
            to: 1
            duration: 200
        }
        PropertyAnimation{
            target: topBtn
            properties: "y"
            easing{
                type: Easing.OutElastic
                amplitude: 1
                period: 1
            }
            to: -50
            duration: 100
        }
        PropertyAnimation{
            target: backBtn
            properties: "opacity"
            to: 1
            duration: 200
        }
        PropertyAnimation{
            target: backBtn
            properties: "x"
            easing{
                type: Easing.OutElastic
                amplitude: 1
                period: 1
            }
            to: 10
            duration: 200
        }
        PropertyAnimation{
            target: mainPageLoader
            properties: "opacity"
            to: 0
            duration: 100
        }
        PropertyAnimation{
            target: subPageLoader
            properties: "opacity"
            to: 1
            duration: 200
        }
    }
    ParallelAnimation{
        id: subWindowHide
        PropertyAnimation{
            target: mainWindowElement
            properties: "opacity"
            to: 1
            duration: 200
        }
        PropertyAnimation{
            target: subWindowTitle
            properties: "opacity"
            to: 0
            duration: 200
        }

        PropertyAnimation{
            target: topBtn
            easing{
                type: Easing.OutElastic
                amplitude: 1
                period: 1
            }
            properties: "y"
            to: 0
            duration: 200
        }
        PropertyAnimation{
            target: backBtn
            properties: "opacity"
            to: 0
            duration: 200
        }
        PropertyAnimation{
            target: backBtn
            properties: "x"
            easing{
                type: Easing.OutElastic
                amplitude: 1
                period: 1
            }
            to: -50
            duration: 200
        }
        PropertyAnimation{
            target: mainPageLoader
            properties: "opacity"
            to: 1
            duration: 200
        }
        PropertyAnimation{
            target: subPageLoader
            properties: "opacity"
            to: 0
            duration: 100
        }
    }
}
