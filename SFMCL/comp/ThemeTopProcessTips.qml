import QtQuick
import QtQuick.Controls.Basic
Rectangle{
    property int blockWidth: 100
    property string tips: ""
    id: progress
    color: "#273B42"
    radius: 10
    anchors.horizontalCenter: parent.horizontalCenter
    Text{
        id: tips
        width: progress.width
        anchors.horizontalCenter: parent.horizontalCenter
        y: 10
        font.pixelSize: 13
        text: qsTr("Tips提示")
        horizontalAlignment: Text.AlignHCenter
        color: "#D3BEB5"
    }
    ProgressBar{
        id: control
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        indeterminate: true
        width: progress.width-10
        background: Rectangle {
             implicitWidth: control.width
             implicitHeight: 6
             color: "#AEC6CF"
             radius: 3
         }
         contentItem: Item {
             implicitWidth: control.width
             implicitHeight: 4
             Rectangle {
                 width: control.visualPosition * parent.width
                 height: parent.height
                 radius: 2
                 color: "#38555F"
                 visible: !control.indeterminate
             }
             Item {
                 anchors.fill: parent
                 visible: control.indeterminate
                 clip: true
                 Row {
                     spacing: blockWidth
                     Repeater {
                         model: control.width / blockWidth*2 + 1
                         Rectangle {
                             color: "#38555F"
                             width: blockWidth
                             height: control.height
                         }
                     }
                     XAnimator on x {
                         from: -blockWidth
                         to: blockWidth
                         loops: Animation.Infinite
                         running: control.indeterminate
                         duration: 200*blockWidth
                     }
                 }
             }
         }
    }
    MouseArea{
        anchors.fill: parent
        property point clickPos: "0,0"
        onPressed: {
            clickPos = Qt.point(mouseX, mouseY)
        }
        onPositionChanged: {
            var delta = Qt.point(mouseX-clickPos.x, mouseY-clickPos.y)
            window.setX(window.x+delta.x)
            window.setY(window.y+delta.y)
        }
    }
    signal setTips(var text)
    onSetTips: function (text){
        tips.text = text
    }
}
