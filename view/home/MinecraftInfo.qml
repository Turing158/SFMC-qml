import QtQuick
import "../../comp"
Item {
    property var versionInfo: {0,0}
    Flickable{
        id: minecraftInfo
        width: mainPage.width-leftComp.width-60
        height: mainPage.height-40
        contentHeight: content.height
        clip: true
        Column{
            id: content
            width: parent.width-80
            anchors.horizontalCenter: parent.horizontalCenter
            Empty{}
            ShadowRectangle{
                id: mcInfo
                width: parent.width
                height: 60
                radius: 10
                Image{
                    id: mcIcon
                    x: 15
                    anchors.verticalCenter: mcInfo.verticalCenter
                    width: 40
                    height: 40
                    smooth: false
                    source: "/img/Minecraft.png"
                }
                Text{
                    anchors{
                        left: mcIcon.right
                        leftMargin: 15
                        top: mcIcon.top
                        topMargin: 2
                    }
                    text: qsTr(launcher.selectVersion)
                    font.pixelSize: 15
                }
                Text{
                    id: versionText
                    anchors{
                        left: mcIcon.right
                        leftMargin: 15
                        bottom: mcIcon.bottom
                        bottomMargin: 2
                    }
                    text: qsTr("")
                    color: "#666"
                }
            }
            Empty{}
            ShadowRectangle{
                width: parent.width
                height: 80
                color: "#f1f1f1"
                radius: 10
                Text{
                    x: 10
                    y: 10
                    text: qsTr("游戏相关")
                }
                Item{
                    y: 35
                    width: parent.width-50
                    anchors.horizontalCenter: parent.horizontalCenter
                    ThemeButton{
                        width: 120
                        height: 32
                        text: qsTr("游戏文件夹")
                        fontSize: 14
                        onClicked: {
                            minecraftInfo.openFolder(launcher.selectDir)
                        }
                    }
                    ThemeButton{
                        width: 120
                        height: 32
                        text: qsTr("版本文件夹")
                        fontSize: 14
                        anchors.horizontalCenter: parent.horizontalCenter
                        onClicked: {
                            minecraftInfo.openFolder(launcher.selectDir+"/versions/"+launcher.selectVersion)
                        }
                    }
                    ThemeButton{
                        width: 120
                        height: 32
                        text: qsTr("日志文件夹")
                        fontSize: 14
                        anchors.right: parent.right
                        onClicked: {
                            if(launcher.isIsolate){
                                minecraftInfo.openFolder(launcher.selectDir+"/versions/"+launcher.selectVersion+"/logs")
                            }
                            else{
                                minecraftInfo.openFolder(launcher.selectDir+"/logs")
                            }
                        }
                    }
                }
            }
            Empty{}
            ShadowRectangle{
                width: parent.width
                height: 80
                color: "#f1f1f1"
                radius: 10
                Text{
                    x: 10
                    y: 10
                    text: qsTr("资源相关")
                }
                Item{
                    y: 35
                    width: parent.width-50
                    anchors.horizontalCenter: parent.horizontalCenter
                    ThemeButton{
                        width: 120
                        height: 32
                        text: qsTr("地图文件夹")
                        fontSize: 14
                        onClicked: {
                            if(launcher.isIsolate){
                                minecraftInfo.openFolder(launcher.selectDir+"/versions/"+launcher.selectVersion+"/saves")
                            }
                            else{
                                minecraftInfo.openFolder(launcher.selectDir+"/saves")
                            }
                        }
                    }
                    ThemeButton{
                        width: 120
                        height: 32
                        text: qsTr("模组文件夹")
                        fontSize: 14
                        anchors.horizontalCenter: parent.horizontalCenter
                        onClicked: {
                            if(launcher.isIsolate){
                                minecraftInfo.openFolder(launcher.selectDir+"/versions/"+launcher.selectVersion+"/mods")
                            }
                            else{
                                minecraftInfo.openFolder(launcher.selectDir+"/mods")
                            }
                        }
                    }
                    ThemeButton{
                        width: 120
                        height: 32
                        text: qsTr("材质文件夹")
                        fontSize: 14
                        anchors.right: parent.right
                        onClicked: {
                            if(launcher.isIsolate){
                                minecraftInfo.openFolder(launcher.selectDir+"/versions/"+launcher.selectVersion+"/resourcepacks")
                            }
                            else{
                                minecraftInfo.openFolder(launcher.selectDir+"/resourcepacks")
                            }
                        }
                    }
                }
            }
            Empty{}
            ShadowRectangle{
                width: parent.width
                height: 80
                color: "#f1f1f1"
                radius: 10
                Text{
                    x: 10
                    y: 10
                    text: qsTr("启动相关")
                }
                Item{
                    y: 35
                    width: parent.width-50
                    anchors.horizontalCenter: parent.horizontalCenter
                    ThemeButton{
                        width: 120
                        height: 32
                        text: qsTr("")
                        fontSize: 14
                    }
                    ThemeButton{
                        width: 120
                        height: 32
                        text: qsTr("补全资源文件")
                        fontSize: 14
                        anchors.horizontalCenter: parent.horizontalCenter
                        onClicked: {
                            minecraftInfo.fixResouces()
                        }
                    }
                    ThemeButton{
                        width: 120
                        height: 32
                        text: qsTr("!!! 删除版本 !!!")
                        fontSize: 14
                        anchors.right: parent.right
                    }
                }
            }
            Empty{}
        }
        signal initInfo()
        signal openFolder(var url)
        signal fixResouces()
        Component.onCompleted: {
            initInfo()
        }
        Connections{
            target: minecraftInfo
            function onInitInfo(){
                versionInfo = launcherUtil.getVersionInfo(launcher.selectDir , launcher.selectVersion)
                var loader = versionInfo["loader"].length === 0 ? "原版MC" : versionInfo["loader"]+"-"+versionInfo["loaderVersion"]
                versionText.text = qsTr(versionInfo["client"]+" | "+loader)
                mcIcon.source = "/img/"+(versionInfo["loader"].length === 0 ? "Minecraft" : versionInfo["loader"])+".png"
            }
            function onOpenFolder(url){
                if(!launcherUtil.openFolder(url)){
                    globalTips.show("","该文件夹无法打开或不存在","")
                }
            }

            function onFixResouces(){
                launcherUtil.fixAllResourcesFile(launcher.selectDir,launcher.selectVersion)
            }
        }
    }
}
