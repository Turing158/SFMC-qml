import QtQuick
import QtQuick.Controls.Basic

TextField {
    id: control
    property int radius: 5
    property string bg: "#f1f1f1"
    property string borderColor: "#273B42"
    property string activeColor: "#A28E85"
    property int borderWidth: 1
    placeholderText: qsTr("")
    background: Rectangle {
        id: controlBg
        implicitWidth: parent.width
        implicitHeight: parent.height
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

        radius: 0
    }
    color: borderColor
    Component.onCompleted: {
        controlBg.radius = radius
    }

}
