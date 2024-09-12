import QtQuick 6.2

Item {
    property string bgColor: "#687E86"
    property string textColor: "#38555F"
    property string blockColor: "#273B42"
    property int activeIndex: 0
    Component.onCompleted: {
        bgColor = bgColor.substring(0,1)+"44"+bgColor.substring(1)
    }
    Rectangle{
        id: leftComp
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
            id:themeChoice
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
                id:themeChoiceText
                anchors.centerIn: parent
                text: qsTr("主   题")
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
                        changePage("./setting/ThemeSetting.qml")
                        activeIndex = 0
                        activeBlock.y = 15+10+(45*activeIndex)
                    }

                }
            }

        }
        Rectangle{
            id: helpChoice
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
                id :helpChoiceText
                anchors.centerIn: parent
                text: qsTr("有事点这")
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
                        changePage("./setting/Helping.qml")
                        activeIndex = 1
                        activeBlock.y = 15+10+(45*activeIndex)
                    }

                }
            }
        }
        Rectangle{
            id: updateChoice
            y:105
            width: parent.width
            height: 45
            color: "transparent"
            Behavior on color{
                PropertyAnimation{
                    duration: 200
                }
            }
            Text {
                id: updateChoiceText
                anchors.centerIn: parent
                text: qsTr("更新")
                font.pixelSize: 16
                color: activeIndex === 2 ? textColor : "#131313"
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
                    if(activeIndex !== 2){
                        changePage("./setting/UpdateAndLoging.qml")
                        activeIndex = 2
                        activeBlock.y = 15+10+(45*activeIndex)
                    }

                }

            }
        }
        Rectangle{
            id: aboutChoice
            y:150
            width: parent.width
            height: 45
            color: "transparent"
            Behavior on color{
                PropertyAnimation{
                    duration: 200
                }
            }
            Text {
                id: aboutChoiceText
                anchors.centerIn: parent
                text: qsTr("关于")
                font.pixelSize: 16
                color: activeIndex === 3 ? textColor : "#131313"
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
                    if(activeIndex !== 3){
                        changePage("/view/setting/AboutApp.qml")
                        activeIndex = 3
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
            id: settingPage
            height: parent.height
            asynchronous: true
            source: "./setting/ThemeSetting.qml"
            opacity: 1
        }
        ParallelAnimation{
            id: changeSettingPageBefore
            PropertyAnimation{
                target: settingPage
                properties: "opacity"
                to: 0
                duration: 100
            }
            PropertyAnimation{
                target: settingPage
                properties: "y"
                easing.type: Easing.InCirc
                to: -settingPage.height
                duration: 200
            }
        }
        ParallelAnimation{
            id: changeSettingPageAfter
            PropertyAnimation{
                target: settingPage
                properties: "opacity"
                to: 1
                duration: 100
            }
            PropertyAnimation{
                target: settingPage
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
            id: changeSettingPageTimer
            interval: 200
            onTriggered: {
                settingPage.source = source
                changeSettingPageAfter.stop()
                changeSettingPageAfter.start()
            }
        }

    }
    function changePage(source){
        changeSettingPageBefore.stop()
        changeSettingPageBefore.start()
        changeSettingPageTimer.source = source
        changeSettingPageTimer.stop()
        changeSettingPageTimer.start()
    }
}
