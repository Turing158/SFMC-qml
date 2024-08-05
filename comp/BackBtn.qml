import QtQuick

Item {
    Rectangle{
        id: backBtn
        width: 30
        height: 30
        radius: width
        rotation: 180
        z:10
        color: "#00000000"
        Rectangle{
            id:bg
            anchors.fill: parent
            color: "#f1f1f1"
            opacity: 0
            radius: width
        }
        Text{
            id:backBtnText
            x: parent.width/2-width/2
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr("→")
            font.pixelSize: 20
            color:  "#f1f1f1"
        }
        MouseArea{
            id: backBtnMA
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                btnBack.stop()
                btnHovered.start()
            }
            onExited: {
                btnHovered.stop()
                btnBack.start()
            }
            onClicked: {
                subWindowShow.stop()
                subWindowHide.start()
                subWindowTitle.text = qsTr("")
                leftCompBg.width = mainPage.width/2-100
            }
        }

    }

        // 动画




    ParallelAnimation{
        id:btnHovered
        PropertyAnimation{
            target: bg
            properties: "opacity"
            to: 0.5
        }
        PropertyAnimation{
            target: backBtn
            properties: "rotation"
            to: 540
            easing{
                type: Easing.OutElastic
                amplitude: 1
                period: 0.5
            }
            duration: 2000
        }
        PropertyAnimation{
            target: backBtnText
            properties: "color"
            to: "#131313"
        }
    }
    ParallelAnimation{
        id:btnBack
        PropertyAnimation{
            target: bg
            properties: "opacity"
            to: 0
        }
        PropertyAnimation{
            target: backBtn
            properties: "rotation"
            to: 180
            easing{
                type: Easing.OutElastic
                amplitude: 1
                period: 0.5
            }
            duration: 2000
        }
        PropertyAnimation{
            target: backBtnText
            properties: "color"
            to: "#f1f1f1"
        }
    }


}
