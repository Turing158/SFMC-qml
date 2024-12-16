import QtQuick 2.15
import "../../comp"
import "./comp"

Item {
    property string currentColor: window.currentColorName
    Flickable{
        width: mainPage.width-leftComp.width-60
        height: mainPage.height-40
        clip: true
        Column{
            width: parent.width-80
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter
            y: 20
            ShadowRectangle{
                width: parent.width
                height: 100
                radius: 10
            }
            ColorSelete{
                colorName: "grayBlue"
            }
            ColorSelete{
                name: "巧克力色"
                colorName: "chocolate"
            }
        }
    }
}
