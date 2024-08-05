import QtQuick
import "../../comp"
Item {
    Flickable{
        width: mainPage.width-leftComp.width-60
        height: mainPage.height-40
        contentHeight: content.height
        clip: true
        Column{
            id: content
            width: parent.width-80
            anchors.horizontalCenter: parent.horizontalCenter
            Item{height: 20;width: 1}
            ShadowRectangle{
                id: mcInfo
                width: parent.width
                height: 60
                radius: 10
                Rectangle{
                    id: mcIcon
                    x: 12
                    anchors.verticalCenter: mcInfo.verticalCenter
                    width: 43
                    height: 43
                }
                Text{
                    anchors{
                        left: mcIcon.right
                        leftMargin: 15
                        top: mcIcon.top
                        topMargin: 2
                    }
                    text: qsTr("Minecraft 1.12 Forge")
                    font.pixelSize: 15
                }
                Text{
                    anchors{
                        left: mcIcon.right
                        leftMargin: 15
                        bottom: mcIcon.bottom
                        bottomMargin: 2
                    }
                    text: qsTr("1.12 | Forge")
                    color: "#666"
                }
            }
            Item{height: 20;width: 1}
            ShadowRectangle{
                width: parent.width
                height: 100
                color: "#f1f1f1"
                radius: 10
            }
        }
    }
}
