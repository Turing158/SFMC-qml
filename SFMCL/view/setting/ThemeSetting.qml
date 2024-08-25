import QtQuick 2.15

Item {
    Flickable{
        width: mainPage.width-leftComp.width-60
        height: mainPage.height-40
        clip: true
        Text{
            anchors.centerIn: parent
            text: qsTr("未完成")
            font.pixelSize: 30
            font.bold: Font.Bold
        }
    }
}
