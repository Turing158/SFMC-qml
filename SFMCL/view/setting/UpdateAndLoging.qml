import QtQuick 2.15
import "../../comp"
Item {
    Flickable{
        width: mainPage.width-leftComp.width-60
        height: mainPage.height-40
        clip: true
        Column{
            id: content
            width: parent.width-80
            anchors.horizontalCenter: parent.horizontalCenter
            Empty{}
            ShadowRectangle{
                width: parent.width
                height: 80
                radius: 10
                Text{
                    anchors.centerIn: parent
                    text: qsTr("暂无更新")
                    font.pixelSize: 20
                }
            }
        }
    }
}
