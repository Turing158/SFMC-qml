import QtQuick 6.2

Item {
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
            id:downloadMc
            y:15
            width: parent.width
            height: 45
            color: "transparent"
            Rectangle{
                id:downloadMcBg
                anchors.fill: parent
                color: "#687E86"
                opacity: 0
            }
            Text {
                id:downloadMcText
                anchors.centerIn: parent
                text: qsTr("Minecraft")
                font.pixelSize: 16
                color: "#38555F"
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    downloadMCBack.stop()
                    downloadMCHover.start()
                }
                onExited: {
                    downloadMCHover.stop()
                    downloadMCBack.start()
                }
                onClicked: {
                    downloadMCActiveBack.stop()
                    downloadMCActive.start()

                    downloadOptifineActiveBack.start()
                    downloadForgeActiveBack.start()
                    downloadFabricActiveBack.start()

                    activeBlock.y = 15+10
                }
            }

        }
        Rectangle{
            id: downloadOptifine
            y:60
            width: parent.width
            height: 45
            color: "transparent"
            Rectangle{
                id:downloadOptifineBg
                anchors.fill: parent
                color: "#687E86"
                opacity: 0
            }
            Text {
                id :downloadOptifineText
                anchors.centerIn: parent
                text: qsTr("Optifine")
                font.pixelSize: 16
                color: "#131313"
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    downloadOptifineBack.stop()
                    downloadOptifineHover.start()
                }
                onExited: {
                    downloadOptifineHover.stop()
                    downloadOptifineBack.start()
                }
                onClicked: {
                    downloadOptifineActiveBack.stop()
                    downloadOptifineActive.start()

                    downloadMCActiveBack.start()
                    downloadForgeActiveBack.start()
                    downloadFabricActiveBack.start()

                    activeBlock.y = 15+10+(45*1)
                }
            }
        }
        Rectangle{
            id: downloadForge
            y:105
            width: parent.width
            height: 45
            color: "transparent"
            Rectangle{
                id:downloadForgeBg
                anchors.fill: parent
                color: "#687E86"
                opacity: 0
            }
            Text {
                id: downloadForgeText
                anchors.centerIn: parent
                text: qsTr("Forge")
                font.pixelSize: 16
                color: "#131313"
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    downloadForgeBack.stop()
                    downloadForgeHover.start()
                }
                onExited: {
                    downloadForgeHover.stop()
                    downloadForgeBack.start()
                }
                onClicked: {
                    downloadForgeActiveBack.stop()
                    downloadForgeActive.start()

                    downloadMCActiveBack.start()
                    downloadOptifineActiveBack.start()
                    downloadFabricActiveBack.start()
                    activeBlock.y = 15+10+(45*2)
                }
            }
        }
        Rectangle{
            id: downloadFabric
            y:150
            width: parent.width
            height: 45
            color: "transparent"
            Rectangle{
                id:downloadFabricBg
                anchors.fill: parent
                color: "#687E86"
                opacity: 0
            }
            Text {
                id: downloadFabricText
                anchors.centerIn: parent
                text: qsTr("Fabric")
                font.pixelSize: 16
                color: "#131313"
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    downloadFabricBack.stop()
                    downloadFabricHover.start()
                }
                onExited: {
                    downloadFabricHover.stop()
                    downloadFabricBack.start()
                }
                onClicked: {
                    downloadFabricActiveBack.stop()
                    downloadFabricActive.start()

                    downloadMCActiveBack.start()
                    downloadOptifineActiveBack.start()
                    downloadForgeActiveBack.start()

                    activeBlock.y = 15+10+(45*3)
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
        Text{
            anchors.centerIn: parent
            text: qsTr("未完成")
            font.pixelSize: 30
            font.bold: Font.Bold
        }

        // Loader{
        //     asynchronous: true
        // }
    }


    PropertyAnimation{
        id:downloadMCHover
        target: downloadMcBg
        properties: "opacity"
        to: 0.3
    }
    PropertyAnimation{
        id:downloadOptifineHover
        target: downloadOptifineBg
        properties: "opacity"
        to: 0.3
    }
    PropertyAnimation{
        id:downloadForgeHover
        target: downloadForgeBg
        properties: "opacity"
        to: 0.3
    }
    PropertyAnimation{
        id:downloadFabricHover
        target: downloadFabricBg
        properties: "opacity"
        to: 0.3
    }


    PropertyAnimation{
        id:downloadMCBack
        target: downloadMcBg
        properties: "opacity"
        to: 0
    }
    PropertyAnimation{
        id:downloadOptifineBack
        target: downloadOptifineBg
        properties: "opacity"
        to: 0
    }
    PropertyAnimation{
        id:downloadForgeBack
        target: downloadForgeBg
        properties: "opacity"
        to: 0
    }
    PropertyAnimation{
        id:downloadFabricBack
        target: downloadFabricBg
        properties: "opacity"
        to: 0

    }


    PropertyAnimation{
        id: downloadMCActive
        target: downloadMcText
        properties: "color"
        to: "#38555F"
        duration: 200
    }
    PropertyAnimation{
        id: downloadOptifineActive
        target: downloadOptifineText
        properties: "color"
        to: "#38555F"
        duration: 200
    }
    PropertyAnimation{
        id: downloadForgeActive
        target: downloadForgeText
        properties: "color"
        to: "#38555F"
        duration: 200
    }
    PropertyAnimation{
        id: downloadFabricActive
        target: downloadFabricText
        properties: "color"
        to: "#38555F"
        duration: 200
    }






    PropertyAnimation{
        id: downloadMCActiveBack
        target: downloadMcText
        properties: "color"
        to: "#131313"
        duration: 200
    }
    PropertyAnimation{
        id: downloadOptifineActiveBack
        target: downloadOptifineText
        properties: "color"
        to: "#131313"
        duration: 200
    }
    PropertyAnimation{
        id: downloadForgeActiveBack
        target: downloadForgeText
        properties: "color"
        to: "#131313"
        duration: 200
    }
    PropertyAnimation{
        id: downloadFabricActiveBack
        target: downloadFabricText
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
