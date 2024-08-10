import QtQuick 6.2

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
            Loader{
                asynchronous: true
                source: "/comp/Player.qml"
            }
        }
        Rectangle{
            id:launchBtn
            anchors.bottom: parent.bottom
            anchors.bottomMargin:70
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width-80
            height: 55
            color: "#D3BEB5"
            border.color: "#A28E85"
            radius: 5
            Text {
                id:launchBtnText1
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 12
                text: launcher.selectVersion !== "" ? qsTr("启   动   游   戏") : qsTr("未    选    择")
                color: "#273B42"
            }
            Text {
                id:launchBtnText2
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 12
                text: launcher.selectVersion !== "" ? qsTr(launcher.selectVersion) : qsTr("游  戏  版  本")
                color: "#273B42"
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    launchBtnBack.stop()
                    launchBtnHover.start()
                }
                onExited: {
                    launchBtnHover.stop()
                    launchBtnBack.start()
                }
                onClicked: {
                    var flag = true
                    if(launcher.selectVersion === ""){
                        console.log("未选择版本")
                        flag = false
                    }
                    if(launcher.username === ""){
                        console.log("用户名为空")
                        flag = false
                    }
                    if(launcher.javaPath === ""){
                        console.log("未选择java")
                        flag = false
                    }
                    if(flag){
                        launcher.launchMc()
                        launchStart.start()
                        launingBtnShow.start()

                    }
                    else{
                        console.log("启动失败")
                    }
                }
            }
        }
        Rectangle{
            id:launchingBtn
            anchors.bottom: parent.bottom
            anchors.bottomMargin:70
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width-80
            height: 55
            color: "#aaa"
            border.color: "#666"
            radius: 5
            opacity: 0
            z: -1
            onOpacityChanged: {
                if(launchingBtn.opacity <= 0.01){
                    launchingBtn.z = -1
                }
                else{
                    launchingBtn.z = 1
                }
            }

            Text {
                id:launchingBtnText1
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 12
                text: launcher.selectVersion !== "" ? qsTr("启   动   中   ...") : qsTr("未    选    择")
                color: "#273B42"
            }
            Text {
                id:launchingBtnText2
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 12
                text: launcher.selectVersion !== "" ? qsTr(launcher.selectVersion) : qsTr("游  戏  版  本")
                color: "#273B42"
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    launchBtnBack.stop()
                    launchBtnHover.start()
                }
                onExited: {
                    launchBtnHover.stop()
                    launchBtnBack.start()
                }
                onClicked: {
                    console.log("nonono")
                }
                Timer{
                    id: launchStart
                    interval: 8000
                    running: false
                    onTriggered: {
                        launingBtnHide.start()
                    }
                }
            }
        }

        PropertyAnimation{
            id: launingBtnShow
            target: launchingBtn
            properties: "opacity"
            to: 1
            duration: 200
        }
        PropertyAnimation{
            id: launingBtnHide
            target: launchingBtn
            properties: "opacity"
            to: 0
            duration: 1000
        }

        Rectangle{
            id: versionBtn
            anchors.bottom: parent.bottom
            anchors.bottomMargin:22
            anchors.left: parent.left
            anchors.leftMargin: 40
            width: (parent.width-80)/2-2.5
            height: 35
            color: "#D3BEB5"
            border.color: "#A28E85"
            radius: 5
            Text {
                id:versionBtnText
                anchors.centerIn: parent
                text: qsTr("版本选择")
                font.pixelSize: 15
                color: "#273B42"
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    versionBtnBack.stop()
                    versionBtnTextBack.stop()
                    versionBtnHover.start()
                    versionBtnTextHover.start()
                }
                onExited: {
                    versionBtnHover.stop()
                    versionBtnTextHover.stop()
                    versionBtnBack.start()
                    versionBtnTextBack.start()
                }
                onClicked: {
                    subWindowTitle.text = qsTr("选择Minecraft")
                    leftCompBg.width = mainPage.width/2-120
                    subPageLoader.source = "/view/home/VersionSelect.qml"
                    subWindowHide.stop()
                    subWindowShow.start()
                }
            }
        }
        Rectangle{
            id: gameSetBtn
            anchors.bottom: parent.bottom
            anchors.bottomMargin:22
            anchors.right: parent.right
            anchors.rightMargin: 40
            width: (parent.width-80)/2-12
            height: 35
            color: "#D3BEB5"
            border.color: "#A28E85"
            radius: 5
            Text {
                id:gameSetBtnText
                anchors.centerIn: parent
                text: qsTr("游戏设置")
                font.pixelSize: 15
                color: "#273B42"
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    gameSetBtnBack.stop()
                    gameSetBtnTextBack.stop()
                    gameSetBtnHover.start()
                    gameSetBtnTextHover.start()
                }
                onExited: {
                    gameSetBtnHover.stop()
                    gameSetBtnTextHover.stop()
                    gameSetBtnBack.start()
                    gameSetBtnTextBack.start()
                }
                onClicked: {
                    if(launcher.selectVersion.length){
                        subWindowTitle.text = qsTr("Minecraft设置")
                        subPageLoader.source = "/view/home/VersionSetting.qml"
                        leftCompBg.width = 150
                        subWindowHide.stop()
                        subWindowShow.start()
                    }
                    else{
                        console.log("未选择版本")
                    }
                }
            }
        }
    }
    Rectangle{
        width: parent.width/2-20
        height: parent.height
        anchors.right: parent.right
        // color: "#fff"
    }




    ParallelAnimation{
        id: launchBtnHover
        PropertyAnimation{
            target: launchBtn
            properties: "color"
            to: "#A28E85"
            duration: 200
        }
        PropertyAnimation{
            targets: [launchBtnText1,launchBtnText2,launchingBtnText1,launchingBtnText2]
            properties: "color"
            to: "#f1f1f1"
            duration: 200
        }
        PropertyAnimation{
            target: launchingBtn
            properties: "color"
            to: "#666"
            duration: 200
        }
    }

    ParallelAnimation{
        id:launchBtnBack
        PropertyAnimation{
            target: launchBtn
            properties: "color"
            to: "#D3BEB5"
            duration: 200
        }
        PropertyAnimation{
            targets: [launchBtnText1,launchBtnText2,launchingBtnText1,launchingBtnText2]
            properties: "color"
            to: "#273B42"
            duration: 200
        }
        PropertyAnimation{
            target: launchingBtn
            properties: "color"
            to: "#aaa"
            duration: 200
        }
    }







    PropertyAnimation{
        id:versionBtnHover
        target: versionBtn
        properties: "color"
        to: "#A28E85"
        duration: 200
    }
    PropertyAnimation{
        id:versionBtnTextHover
        target: versionBtnText
        properties: "color"
        to: "#f1f1f1"
        duration: 200
    }
    PropertyAnimation{
        id:versionBtnBack
        target: versionBtn
        properties: "color"
        to: "#D3BEB5"
        duration: 200
    }
    PropertyAnimation{
        id:versionBtnTextBack
        target: versionBtnText
        properties: "color"
        to: "#273B42"
        duration: 200
    }






    PropertyAnimation{
        id:gameSetBtnHover
        target: gameSetBtn
        properties: "color"
        to: "#A28E85"
        duration: 200
    }
    PropertyAnimation{
        id:gameSetBtnTextHover
        target: gameSetBtnText
        properties: "color"
        to: "#f1f1f1"
        duration: 200
    }
    PropertyAnimation{
        id:gameSetBtnBack
        target: gameSetBtn
        properties: "color"
        to: "#D3BEB5"
        duration: 200
    }
    PropertyAnimation{
        id:gameSetBtnTextBack
        target: gameSetBtnText
        properties: "color"
        to: "#273B42"
        duration: 200
    }
}

