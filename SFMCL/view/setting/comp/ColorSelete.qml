import QtQuick 2.15
import "../../../comp"
ShadowRectangle {
    property string name: "灰蓝色"
    property string colorName: "grayBlue"
    property bool isCheck: window.currentColorName === colorName
    id: colorSelect
    width: parent.width
    height: 50
    radius: 10

    ThemeRadio{
        id: radio
        anchors.verticalCenter: parent.verticalCenter
        x: 10
        width: 15
        height: 15
        checked: isCheck
    }
    Text{
        anchors.verticalCenter: parent.verticalCenter
        x: 40
        text: qsTr(name)
        font.pixelSize: 15
    }
    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            colorSelect.color = "#e1e1e1"
        }
        onExited: {
            colorSelect.color = "#f1f1f1"
        }
        onClicked: {
            // isCheck = true
            window.currentColorName = colorName
        }
    }
    onIsCheckChanged: {
        radio.checked = isCheck
    }

    Component.onCompleted: {

    }
}
