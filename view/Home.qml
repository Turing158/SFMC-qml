import QtQuick 6.2

Item{
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
            anchors.bottomMargin:60
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width-80
            height: 60
            color: "#D3BEB5"
            border.color: "#A28E85"
            radius: 5
            Text {
                id:launchBtnText1
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 14
                text: window.choiseVersion.lenght ? qsTr("启   动   游   戏") : qsTr("未    选    择")
                color: "#273B42"
            }
            Text {
                id:launchBtnText2
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 14
                text: window.choiseVersion.lenght ? qsTr(window.choiseVersion) : qsTr("游  戏  版  本")
                color: "#273B42"
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    launchBtnBack.stop()
                    launchBtnTextBack.stop()
                    launchBtnHover.start()
                    launchBtnTextHover.start()
                }
                onExited: {
                    launchBtnHover.stop()
                    launchBtnTextHover.stop()
                    launchBtnBack.start()
                    launchBtnTextBack.start()
                }
            }
        }
        Rectangle{
            id: versionBtn
            anchors.bottom: parent.bottom
            anchors.bottomMargin:15
            anchors.left: parent.left
            anchors.leftMargin: 40
            width: (parent.width-80)/2-2.5
            height: 40
            color: "#D3BEB5"
            border.color: "#A28E85"
            radius: 5
            Text {
                id:versionBtnText
                anchors.centerIn: parent
                text: qsTr("版本选择")
                font.pixelSize: 16
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
            }
        }
        Rectangle{
            id: gameSetBtn
            anchors.bottom: parent.bottom
            anchors.bottomMargin:15
            anchors.right: parent.right
            anchors.rightMargin: 40
            width: (parent.width-80)/2-2.5
            height: 40
            color: "#D3BEB5"
            border.color: "#A28E85"
            radius: 5
            Text {
                id:gameSetBtnText
                anchors.centerIn: parent
                text: qsTr("游戏设置")
                font.pixelSize: 16
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
            }
        }
    }
    Rectangle{
        width: parent.width/2-20
        height: parent.height
        anchors.right: parent.right
        // color: "#fff"
    }





    PropertyAnimation{
        id:launchBtnHover
        target: launchBtn
        properties: "color"
        to: "#A28E85"
        duration: 200
    }
    PropertyAnimation{
        id:launchBtnTextHover
        targets: [launchBtnText1,launchBtnText2]
        properties: "color"
        to: "#f1f1f1"
        duration: 200
    }
    PropertyAnimation{
        id:launchBtnBack
        target: launchBtn
        properties: "color"
        to: "#D3BEB5"
        duration: 200
    }
    PropertyAnimation{
        id:launchBtnTextBack
        targets: [launchBtnText1,launchBtnText2]
        properties: "color"
        to: "#273B42"
        duration: 200
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

