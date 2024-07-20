import QtQuick

Item {
    Rectangle{
        id:closeBtn
        width: 30
        height: 30
        radius: width
        rotation: 0
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
            id:closeBtnText
            x: parent.width/2-width/2
            y: -2
            text: qsTr("×")
            font.pixelSize: 25
            color:  "#f1f1f1"
        }
        MouseArea{
            id:closeBtnMA
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                btnColorBack.stop()
                btnRotationBack.stop()
                btnTextColorBack.stop()
                btnColorHovered.start()
                btnRotationHovered.start()
                btnTextColorHovered.start()
            }
            onExited: {
                btnColorHovered.stop()
                btnRotationHovered.stop()
                btnTextColorHovered.stop()
                btnColorBack.start()
                btnRotationBack.start()
                btnTextColorBack.start()
            }
            onClicked: {
                Qt.quit()
            }
        }

    }

        // 动画
    PropertyAnimation{
        id:btnColorHovered
        target: bg
        properties: "opacity"
        to: 0.5
    }
    PropertyAnimation{
        id:btnRotationHovered
        target: closeBtn
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
        id:btnTextColorHovered
        target: closeBtnText
        properties: "color"
        to: "#131313"
    }

    PropertyAnimation{
        id:btnColorBack
        target: bg
        properties: "opacity"
        to: 0
    }
    PropertyAnimation{
        id:btnRotationBack
        target: closeBtn
        properties: "rotation"
        to: 0
        easing{
            type: Easing.OutElastic
            amplitude: 1
            period: 0.5
        }
        duration: 2000
    }
    PropertyAnimation{
        id:btnTextColorBack
        target: closeBtnText
        properties: "color"
        to: "#f1f1f1"
    }



}
