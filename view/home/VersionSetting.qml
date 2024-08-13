import QtQuick 2.15

Item {
    property int activeIndex: 0
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
                    activeBlock.y = 15+10
                    if(activeIndex !== 0){
                        changePage("/view/home/MinecraftInfo.qml")
                        activeIndex = 0
                    }
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

                    activeBlock.y = 15+10+(45*1)

                    if(activeIndex !== 1){
                        changePage("/view/home/MinecraftSetting.qml")
                        activeIndex = 1
                    }
                }
            }
        }
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
        clip: true
        Rectangle{
            anchors.fill: parent
            color: "#fff"
            opacity: 0.6
            radius: 10
        }

        Loader{
            id: minecraftSettingPage
            width: parent.width
            height: parent.height
            asynchronous: true
            source: "/view/home/MinecraftInfo.qml"
            opacity: 1
        }
        ParallelAnimation{
            id: changeMinecraftSettingPageBefore
            PropertyAnimation{
                target: minecraftSettingPage
                properties: "opacity"
                to: 0
                duration: 100
            }
            PropertyAnimation{
                target: minecraftSettingPage
                properties: "y"
                easing.type: Easing.InCirc
                to: -minecraftSettingPage.height
                duration: 200
            }
        }
        ParallelAnimation{
            id: changeMinecraftSettingPageAfter
            PropertyAnimation{
                target: minecraftSettingPage
                properties: "opacity"
                to: 1
                duration: 100
            }
            PropertyAnimation{
                target: minecraftSettingPage
                properties: "y"
                easing{
                    type: Easing.OutElastic
                    amplitude: 1
                    period: 1
                }
                to: 0
                duration: 500
            }
        }
        Timer{
            property string source: ""
            id: changeMinecraftSettingPageTimer
            interval: 200
            onTriggered: {
                minecraftSettingPage.source = source
                changeMinecraftSettingPageAfter.start()
            }
        }
    }
    function changePage(source){
        changeMinecraftSettingPageBefore.stop()
        changeMinecraftSettingPageBefore.start()
        changeMinecraftSettingPageTimer.source = source
        changeMinecraftSettingPageTimer.stop()
        changeMinecraftSettingPageTimer.start()
    }
}
