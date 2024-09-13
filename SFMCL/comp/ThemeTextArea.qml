import QtQuick
import QtQuick.Controls.Basic

Rectangle{
    id: main
    property string bg: "#f1f1f1"
    property string borderColor: window.deepColor_5
    property string activeColor: window.deepSubColor_1
    property int borderWidth: 1
    property string text: ""
    width: parent.width
    height: parent.height
    color: bg
    border{
        color: control.focus ? activeColor : borderColor
        width: borderWidth
        Behavior on color {
            PropertyAnimation{
                duration: 200
            }
        }
    }
    radius: 5
    ScrollView{
        id: scroll
        width: parent.width
        height: parent.height
        TextArea {
            id: control
            width: parent.width
            placeholderText: qsTr("")
            text: main.text
            color: borderColor
            Component.onCompleted: {
                // controlBg.radius = radius
            }
            onTextChanged: {
                main.text = control.text
            }
            wrapMode: "Wrap"
        }
    }
}


