import QtQuick 2.15

Item {
    property string bgColor: "#687E86"
    property string textColor: "#38555F"
    property string blockColor: "#273B42"
    property int activeIndex: 0
    Component.onCompleted: {
        bgColor = bgColor.substring(0,1)+"44"+bgColor.substring(1)
    }
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
            color: blockColor
            Behavior on y{
                PropertyAnimation{
                    easing{
                        type: Easing.OutElastic
                        amplitude: 1
                        period: 1
                    }
                    duration: 500
                }
            }
        }
        Rectangle{
            id:info
            y:15
            width: parent.width
            height: 45
            color: "transparent"
            Behavior on color{
                PropertyAnimation{
                    duration: 200
                }
            }
            Text {
                id:infoText
                anchors.centerIn: parent
                text: qsTr("Minecraft")
                font.pixelSize: 16
                color: activeIndex === 0 ? textColor : "#131313"
                Behavior on color{
                    PropertyAnimation{
                        duration: 200
                    }
                }
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.color = bgColor
                }
                onExited: {
                    parent.color = "transparent"
                }
                onClicked: {
                    if(activeIndex !== 0){
                        changePage("/view/home/MinecraftInfo.qml")
                        activeIndex = 0
                        activeBlock.y = 15+10+(45*activeIndex)
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
            Behavior on color{
                PropertyAnimation{
                    duration: 200
                }
            }
            Text {
                id :settingVersionText
                anchors.centerIn: parent
                text: qsTr("🔧设置")
                font.pixelSize: 16
                color: activeIndex === 1 ? textColor : "#131313"
                Behavior on color{
                    PropertyAnimation{
                        duration: 200
                    }
                }
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.color = bgColor
                }
                onExited: {
                    parent.color = "transparent"
                }
                onClicked: {
                    if(activeIndex !== 1){
                        changePage("/view/home/MinecraftSetting.qml")
                        activeIndex = 1
                        activeBlock.y = 15+10+(45*activeIndex)
                    }
                }
            }
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
                changeMinecraftSettingPageAfter.stop()
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
