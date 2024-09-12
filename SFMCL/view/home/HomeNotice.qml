import QtQuick

import "../../comp"
Item {
    id: downloadMinecraft
    Flickable{
        width: mainPage.width-leftComp.width-60
        height: mainPage.height-40
        clip: true
        Column{
            id: content
            width: parent.width-40
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter
            ThemeDrawer{
                width: parent.width
                title: "公告"
                contentHeight: 50
                Text{
                    y: 50
                    width: parent.width
                    height: 40
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: qsTr("也是成功将这边的空白补全啦！")
                    font.pixelSize: 15
                }
            }
        }
    }
}
