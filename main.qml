import QtQuick
import QtQuick.Controls
import Player 1.0
import LauncherUtil 1.0
import Launcher 1.0
import "./comp"

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
                    z:999
                    Icon{}
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
            CloseBtn{
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 10
            }
            MiniBtn{
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 50
            }
            TopBtn{
                id: topBtn
                width:200
                height: 50
            }
            BackBtn{
                id: backBtn
                x: -50
                anchors.verticalCenter: parent.verticalCenter
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
                x: 0
                source: "/view/Home.qml"
                onSourceChanged: {
                    changePgaeOpacity.start()
                }
                onOpacityChanged: {
                    if(mainPageLoader.opacity <= 0.01){
                        mainPageLoader.z = -999
                        mainPageLoader.x = parent.width
                    }
                    else{
                        mainPageLoader.z = 1
                        mainPageLoader.x = 0
                    }
                }

            }
            Loader{
                id:subPageLoader
                asynchronous: true
                source: ""
                opacity: 0
                z: -999
                x: parent.width
                onSourceChanged: {
                    subChangePgaeOpacity.start()
                }
                onOpacityChanged: {
                    if(subPageLoader.opacity <= 0.01){
                        subPageLoader.z = -999
                        subPageLoader.x = parent.width
                    }
                    else{
                        subPageLoader.z = 1
                        subPageLoader.x = 0
                    }
                }
            }
            GlobalTips{
                id: globalTips
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
            autoMemory: true
            memoryMax: 2000
            username: ""
            uuid: ""
            autoJava: true
            isIsolate: false
            isFullscreen: false
            javaPath: ""
            jvmExtraPara: ""
            signal initLauncher()
            signal initJavaPath()
            signal initMemory()
            Component.onCompleted: {
                initLauncher()
                initJavaPath()

            }
        }
        Connections{
            target: launcher
            function onInitLauncher(){
                // launcher.selectDir = "D:/无限的战争3.1.0"
                launcher.selectDir = launcherUtil.getCurrentPath()
                dirList.push(launcher.selectDir)
                dirList.push("E:/Game/test/.minecraft")
                var list = launcherUtil.findVersion(launcher.selectDir)
                if(list.length !== 0){
                    launcher.selectVersion = list[0]
                }
            }
            function onInitJavaPath(){
                var sj = launcherUtil.getSuitableJava(launcher.selectDir, launcher.selectVersion)
                if(sj["name"] === ""){
                    launcher.javaPath = "java"
                }
                else{
                    launcher.javaPath = sj["javaPath"]
                }
            }
            function onInitMemory(){
                if(launcher.autoMemory){
                    launcher.memoryMax = launcherUtil.getMemory()["avalible"]*0.55
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
