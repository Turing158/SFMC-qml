import QtQuick
import QtQuick.Controls.Basic
Rectangle{
    property int blockWidth: 100
    property string textColor: window.subColor
    property string traceColor: window.mainColor
    property string blockColor: window.deepColor_4
    property string tips: ""
    id: progress
    color: window.deepColor_5
    radius: 10
    Text{
        id: tips
        width: progress.width
        anchors.horizontalCenter: parent.horizontalCenter
        y: 10
        font.pixelSize: 13
        text: qsTr("Tips提示")
        horizontalAlignment: Text.AlignHCenter
        color: textColor
        elide: Text.ElideRight
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
             color: traceColor
             radius: 3
         }
         contentItem: Item {
             implicitWidth: control.width
             implicitHeight: 4
             Rectangle {
                 width: control.visualPosition * parent.width
                 height: parent.height
                 radius: 2
                 color: blockColor
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
                             color: blockColor
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
        onClicked: {
            progress.clicked()
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
    signal setIndeterminate(var flag)
    onSetIndeterminate:function(flag) {
        control.indeterminate = flag
    }
    signal clicked()
}
