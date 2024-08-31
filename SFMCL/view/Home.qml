import QtQuick 6.2
import "../comp"
Item{
    id: homePage
    Rectangle{
        id:leftComp
        width: mainPage.width/2-100
        height: mainPage.height-40
        x:20
        y:20
        color:"transparent"
        Rectangle{
            anchors.horizontalCenter: parent.horizontalCenter
            y: 10
            width: parent.width
            height: 200
            color: "transparent"
            Player{}
        }
        ThemeButton{
            id:launchBtn
            anchors.bottom: parent.bottom
            anchors.bottomMargin:70
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width-80
            height: 55
            text:
                (launcher.selectVersion !== "" ? qsTr("启   动   游   戏") : qsTr("未    选    择"))
            +"\n"
            +(launcher.selectVersion !== "" ? qsTr("-"+launcher.selectVersion+"-") : qsTr("游  戏  版  本"))
            onClicked: {
                var flag = true
                if(launcher.selectVersion === ""){
                    globalTips.show("","未选择Minecraft版本","")
                    console.log("未选择版本")
                    flag = false
                }
                if(launcher.username === ""){
                    globalTips.show("","用户名不能为空","")
                    console.log("用户名为空")
                    flag = false
                }
                if(launcher.javaPath === ""){
                    globalTips.show("","未选择java","")
                    console.log("未选择java")
                    flag = false
                }
                if(flag){
                    launcher.launchMc()
                    launingBtnShow.start()
                    window.isLaunching = true
                }
                else{
                    console.log("启动失败")
                }
            }
        }

        ThemeButton{
            id: versionBtn
            anchors.bottom: parent.bottom
            anchors.bottomMargin:22
            anchors.left: parent.left
            anchors.leftMargin: 40
            width: (parent.width-80)/2-2.5
            height: 35
            borderColor: "#A28E85"
            text: qsTr("版本选择")
            fontSize: 15
            onClicked: {
                subWindowTitle.text = qsTr("选择Minecraft")
                leftCompBg.width = mainPage.width/2-120
                subPageLoader.source = "/view/home/VersionSelect.qml"
                subWindowHide.stop()
                subWindowShow.start()
            }
        }
        ThemeButton{
            id: gameSetBtn
            anchors.bottom: parent.bottom
            anchors.bottomMargin:22
            anchors.right: parent.right
            anchors.rightMargin: 40
            width: (parent.width-80)/2-12
            height: 35
            borderColor: "#A28E85"
            text: qsTr("游戏设置")
            fontSize: 15
            onClicked: {
                if(launcher.selectVersion.length){
                    subWindowTitle.text = qsTr("Minecraft设置")
                    subPageLoader.source = "/view/home/VersionSetting.qml"
                    leftCompBg.width = 150
                    subWindowHide.stop()
                    subWindowShow.start()
                }
                else{
                    globalTips.show("","未选择版本","")
                }
            }
        }
        Timer{
            id: launchStart
            interval: 8000
            onTriggered: {
                launingBtnHide.start()
            }
        }
        ThemeButton{
            id:launchingBtn
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin:70
            width: parent.width-80
            height: 55
            text: qsTr("启   动   中   ...\n- "+launcher.selectVersion+" -")
            borderColor: "#666"
            fontSize: 13
            bg: "#aaa"
            opacity: 0
            z: -1
            onClicked: {
                globalTips.show("","游戏启动中！！！","")
            }
            onOpacityChanged: {
                if(launchingBtn.opacity <= 0.01){
                    launchingBtn.z = -1
                }
                else{
                    launchingBtn.z = 1
                }
            }
        }
        ThemeButton{
            id: cancelBtn
            anchors.bottom: parent.bottom
            anchors.bottomMargin:22
            anchors.left: parent.left
            anchors.leftMargin: 40
            width: parent.width-80
            height: 35
            borderColor: "#666"
            text: qsTr("取   消")
            fontSize: 13
            bg: "#aaa"
            opacity: 0
            z: -1
            onOpacityChanged: {
                if(cancelBtn.opacity <= 0.01){
                    cancelBtn.z = -1
                }
                else{
                    cancelBtn.z = 1
                }
            }
        }

    }


    PropertyAnimation{
        id: launingBtnShow
        targets: [launchingBtn,cancelBtn]
        properties: "opacity"
        to: 1
        duration: 200
    }
    PropertyAnimation{
        id: launingBtnHide
        targets: [launchingBtn,cancelBtn]
        properties: "opacity"
        to: 0
        duration: 1000
    }


    Rectangle{
        width: parent.width/2-20
        height: parent.height
        anchors.right: parent.right
        // color: "#fff"
    }
    signal finishLaunch()
    onFinishLaunch: {
        launchStart.start()
    }
}

