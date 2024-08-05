import QtQuick 2.15

Item {
    Rectangle{
        id:leftComp
        width: 150
        height: mainPage.height-40
        x:20
        y:20
        color:"transparent"
        Rectangle{
            id:activeBlock
            y:15+10
            width: 8
            height: 25
            color: "#273B42"
            Behavior on y{
                animation: activeBlockMove
            }
        }
        Rectangle{
            id:info
            y:15
            width: parent.width
            height: 45
            color: "transparent"
            Rectangle{
                id:infoBg
                anchors.fill: parent
                color: "#687E86"
                opacity: 0
            }
            Text {
                id:infoText
                anchors.centerIn: parent
                text: qsTr("Minecraft")
                font.pixelSize: 16
                color: "#38555F"
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    infoBack.stop()
                    infoHover.start()
                }
                onExited: {
                    infoHover.stop()
                    infoBack.start()
                }
                onClicked: {
                    infoActiveBack.stop()
                    infoActive.start()

                    settingVersionActiveBack.start()
                    // modManageActiveBack.start()

                    activeBlock.y = 15+10
                    minecraftSettingPage.source = "/view/home/MinecraftInfo.qml"
                }
            }

        }
        Rectangle{
            id: settingVersion
            y:60
            width: parent.width
            height: 45
            color: "transparent"
            Rectangle{
                id:settingVersionBg
                anchors.fill: parent
                color: "#687E86"
                opacity: 0
            }
            Text {
                id :settingVersionText
                anchors.centerIn: parent
                text: qsTr("🔧设置")
                font.pixelSize: 16
                color: "#131313"
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    settingVersionBack.stop()
                    settingVersionHover.start()
                }
                onExited: {
                    settingVersionHover.stop()
                    settingVersionBack.start()
                }
                onClicked: {
                    settingVersionActiveBack.stop()
                    settingVersionActive.start()

                    infoActiveBack.start()
                    // modManageActiveBack.start()

                    activeBlock.y = 15+10+(45*1)
                    minecraftSettingPage.source = "/view/home/MinecraftSetting.qml"
                }
            }
        }
        // Rectangle{
        //     id: modManage
        //     y:105
        //     width: parent.width
        //     height: 45
        //     color: "transparent"
        //     Rectangle{
        //         id:modManageBg
        //         anchors.fill: parent
        //         color: "#687E86"
        //         opacity: 0
        //     }
        //     Text {
        //         id: modManageText
        //         anchors.centerIn: parent
        //         text: qsTr("MOD管理")
        //         font.pixelSize: 16
        //         color: "#131313"
        //     }
        //     MouseArea{
        //         anchors.fill: parent
        //         hoverEnabled: true
        //         onEntered: {
        //             modManageBack.stop()
        //             modManageHover.start()
        //         }
        //         onExited: {
        //             modManageHover.stop()
        //             modManageBack.start()
        //         }
        //         onClicked: {
        //             modManageActiveBack.stop()
        //             modManageActive.start()

        //             infoActiveBack.start()
        //             settingVersionActiveBack.start()
        //             activeBlock.y = 15+10+(45*2)
        //         }

        //     }
        // }
        PropertyAnimation{
            id:infoHover
            target: infoBg
            properties: "opacity"
            to: 0.3
        }
        PropertyAnimation{
            id:settingVersionHover
            target: settingVersionBg
            properties: "opacity"
            to: 0.3
        }
        // PropertyAnimation{
        //     id:modManageHover
        //     target: modManageBg
        //     properties: "opacity"
        //     to: 0.3
        // }


        PropertyAnimation{
            id:infoBack
            target: infoBg
            properties: "opacity"
            to: 0
        }
        PropertyAnimation{
            id:settingVersionBack
            target: settingVersionBg
            properties: "opacity"
            to: 0
        }
        // PropertyAnimation{
        //     id:modManageBack
        //     target: modManageBg
        //     properties: "opacity"
        //     to: 0
        // }


        PropertyAnimation{
            id: infoActive
            target: infoText
            properties: "color"
            to: "#38555F"
            duration: 200
        }
        PropertyAnimation{
            id: settingVersionActive
            target: settingVersionText
            properties: "color"
            to: "#38555F"
            duration: 200
        }
        // PropertyAnimation{
        //     id: modManageActive
        //     target: modManageText
        //     properties: "color"
        //     to: "#38555F"
        //     duration: 200
        // }







        PropertyAnimation{
            id: infoActiveBack
            target: infoText
            properties: "color"
            to: "#131313"
            duration: 200
        }
        PropertyAnimation{
            id: settingVersionActiveBack
            target: settingVersionText
            properties: "color"
            to: "#131313"
            duration: 200
        }
        //PropertyAnimation{
        //     id: modManageActiveBack
        //     target: modManageText
        //     properties: "color"
        //     to: "#131313"
        //     duration: 200
        // }

        PropertyAnimation{
            id:activeBlockMove
            easing{
                type: Easing.OutElastic
                amplitude: 1
                period: 1
            }
            duration: 250

        }
    }
    Rectangle{
        width: mainPage.width-leftComp.width-60
        height: mainPage.height-40
        y:20
        anchors.left: leftComp.right
        anchors.leftMargin: 20
        color: "transparent"
        Rectangle{
            anchors.fill: parent
            color: "#fff"
            opacity: 0.6
            radius: 10
        }

        Loader{
            id: minecraftSettingPage
            asynchronous: true
            source: "/view/home/MinecraftInfo.qml"
            onSourceChanged: {
                changeMinecraftSettingPage.stop()
                changeMinecraftSettingPage.start()
            }
            PropertyAnimation{
                id: changeMinecraftSettingPage
                target: minecraftSettingPage
                properties: "opacity"
                from: 0
                to: 1
                duration: 200
            }
        }
    }
}
