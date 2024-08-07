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
            Item{height: 20;width: 1}
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
            Item{height: 20;width: 1}
            ShadowRectangle{
                width: parent.width
                height: 100
                color: "#f1f1f1"
                radius: 10
            }

        }
        signal initInfo()
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
        }
    }
}
