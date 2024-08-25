import QtQuick 6.2

Item {
    property int activeIndex: 0
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
            color: "#273B42"
            Behavior on y{
                animation: activeBlockMove
            }
        }
        Rectangle{
            id:themeChoice
            y:15
            width: parent.width
            height: 45
            color: "transparent"
            Rectangle{
                id:themeChoiceBg
                anchors.fill: parent
                color: "#687E86"
                opacity: 0
            }
            Text {
                id:themeChoiceText
                anchors.centerIn: parent
                text: qsTr("主   题")
                font.pixelSize: 16
                color: "#38555F"
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    themeChoiceBack.stop()
                    themeChoiceHover.start()
                }
                onExited: {
                    themeChoiceHover.stop()
                    themeChoiceBack.start()
                }
                onClicked: {
                    themeChoiceActiveBack.stop()
                    themeChoiceActive.start()

                    helpChoiceActiveBack.start()
                    updateChoiceActiveBack.start()
                    aboutChoiceActiveBack.start()

                    activeBlock.y = 15+10

                    if(activeIndex !== 0){
                        changePage("./setting/ThemeSetting.qml")
                        activeIndex = 0
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
            Rectangle{
                id:helpChoiceBg
                anchors.fill: parent
                color: "#687E86"
                opacity: 0
            }
            Text {
                id :helpChoiceText
                anchors.centerIn: parent
                text: qsTr("有事点这")
                font.pixelSize: 16
                color: "#131313"
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    helpChoiceBack.stop()
                    helpChoiceHover.start()
                }
                onExited: {
                    helpChoiceHover.stop()
                    helpChoiceBack.start()
                }
                onClicked: {
                    helpChoiceActiveBack.stop()
                    helpChoiceActive.start()

                    themeChoiceActiveBack.start()
                    updateChoiceActiveBack.start()
                    aboutChoiceActiveBack.start()

                    activeBlock.y = 15+10+(45*1)

                    if(activeIndex !== 1){
                        changePage("./setting/Helping.qml")
                        activeIndex = 1
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
            Rectangle{
                id:updateChoiceBg
                anchors.fill: parent
                color: "#687E86"
                opacity: 0
            }
            Text {
                id: updateChoiceText
                anchors.centerIn: parent
                text: qsTr("更新")
                font.pixelSize: 16
                color: "#131313"
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    updateChoiceBack.stop()
                    updateChoiceHover.start()
                }
                onExited: {
                    updateChoiceHover.stop()
                    updateChoiceBack.start()
                }
                onClicked: {
                    updateChoiceActiveBack.stop()
                    updateChoiceActive.start()

                    themeChoiceActiveBack.start()
                    helpChoiceActiveBack.start()
                    aboutChoiceActiveBack.start()
                    activeBlock.y = 15+10+(45*2)
                    if(activeIndex !== 2){
                        changePage("./setting/UpdateAndLoging.qml")
                        activeIndex = 2
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
            Rectangle{
                id:aboutChoiceBg
                anchors.fill: parent
                color: "#687E86"
                opacity: 0
            }
            Text {
                id: aboutChoiceText
                anchors.centerIn: parent
                text: qsTr("关于")
                font.pixelSize: 16
                color: "#131313"
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    aboutChoiceBack.stop()
                    aboutChoiceHover.start()
                }
                onExited: {
                    aboutChoiceHover.stop()
                    aboutChoiceBack.start()
                }
                onClicked: {
                    aboutChoiceActiveBack.stop()
                    aboutChoiceActive.start()

                    themeChoiceActiveBack.start()
                    helpChoiceActiveBack.start()
                    updateChoiceActiveBack.start()

                    activeBlock.y = 15+10+(45*3)

                    if(activeIndex !== 3){
                        changePage("/view/setting/AboutApp.qml")
                        activeIndex = 3
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

    PropertyAnimation{
        id:themeChoiceHover
        target: themeChoiceBg
        properties: "opacity"
        to: 0.3
    }
    PropertyAnimation{
        id:helpChoiceHover
        target: helpChoiceBg
        properties: "opacity"
        to: 0.3
    }
    PropertyAnimation{
        id:updateChoiceHover
        target: updateChoiceBg
        properties: "opacity"
        to: 0.3
    }
    PropertyAnimation{
        id:aboutChoiceHover
        target: aboutChoiceBg
        properties: "opacity"
        to: 0.3
    }


    PropertyAnimation{
        id:themeChoiceBack
        target: themeChoiceBg
        properties: "opacity"
        to: 0
    }
    PropertyAnimation{
        id:helpChoiceBack
        target: helpChoiceBg
        properties: "opacity"
        to: 0
    }
    PropertyAnimation{
        id:updateChoiceBack
        target: updateChoiceBg
        properties: "opacity"
        to: 0
    }
    PropertyAnimation{
        id:aboutChoiceBack
        target: aboutChoiceBg
        properties: "opacity"
        to: 0
    }


    PropertyAnimation{
        id: themeChoiceActive
        target: themeChoiceText
        properties: "color"
        to: "#38555F"
        duration: 200
    }
    PropertyAnimation{
        id: helpChoiceActive
        target: helpChoiceText
        properties: "color"
        to: "#38555F"
        duration: 200
    }
    PropertyAnimation{
        id: updateChoiceActive
        target: updateChoiceText
        properties: "color"
        to: "#38555F"
        duration: 200
    }
    PropertyAnimation{
        id: aboutChoiceActive
        target: aboutChoiceText
        properties: "color"
        to: "#38555F"
        duration: 200
    }






    PropertyAnimation{
        id: themeChoiceActiveBack
        target: themeChoiceText
        properties: "color"
        to: "#131313"
        duration: 200
    }
    PropertyAnimation{
        id: helpChoiceActiveBack
        target: helpChoiceText
        properties: "color"
        to: "#131313"
        duration: 200
    }
    PropertyAnimation{
        id: updateChoiceActiveBack
        target: updateChoiceText
        properties: "color"
        to: "#131313"
        duration: 200
    }
    PropertyAnimation{
        id: aboutChoiceActiveBack
        target: aboutChoiceText
        properties: "color"
        to: "#131313"
        duration: 200
    }

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
