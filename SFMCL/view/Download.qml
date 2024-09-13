import QtQuick 6.2

Item {
    property string bgColor: window.deepMainColor_2
    property string textColor: window.deepColor_4
    property string blockColor: window.deepColor_5
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
            id:downloadMc
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
                id:downloadMcText
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
                        changePage("/view/download/DownloadMinecraft.qml")
                        activeIndex = 0
                        activeBlock.y = 15+10+(45*activeIndex)
                    }
                }
            }

        }
        Rectangle{
            id:autoInstall
            y:15+45
            width: parent.width
            height: 45
            color: "transparent"
            Behavior on color{
                PropertyAnimation{
                    duration: 200
                }
            }

            Text {
                id:autoInstallText
                anchors.centerIn: parent
                text: qsTr("自动安装")
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
                        changePage("/view/download/AutoInstall.qml")
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
        Rectangle{
            anchors.fill: parent
            color: "#fff"
            opacity: 0.6
            radius: 10
        }
        Loader{
            id: downloadLoader
            height: parent.height
            asynchronous: true
            source: "./download/DownloadMinecraft.qml"
            opacity: 1
        }
        ParallelAnimation{
            id: changeDownloadLoaderBefore
            PropertyAnimation{
                target: downloadLoader
                properties: "opacity"
                to: 0
                duration: 100
            }
            PropertyAnimation{
                target: downloadLoader
                properties: "y"
                easing.type: Easing.InCirc
                to: -downloadLoader.height
                duration: 200
            }
        }
        ParallelAnimation{
            id: changeDownloadLoaderAfter
            PropertyAnimation{
                target: downloadLoader
                properties: "opacity"
                to: 1
                duration: 100
            }
            PropertyAnimation{
                target: downloadLoader
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
            id: changeDownloadLoaderTimer
            interval: 200
            onTriggered: {
                downloadLoader.source = source
                changeDownloadLoaderAfter.stop()
                changeDownloadLoaderAfter.start()
            }
        }
    }
    function changePage(source){
        changeDownloadLoaderBefore.stop()
        changeDownloadLoaderBefore.start()
        changeDownloadLoaderTimer.source = source
        changeDownloadLoaderTimer.stop()
        changeDownloadLoaderTimer.start()
    }
}
