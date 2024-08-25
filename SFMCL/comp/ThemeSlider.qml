import QtQuick
import QtQuick.Controls.Basic

 Slider {
     id: control
     property string rightColor: "#273B42"
     property string leftColor: "#AEC6CF"
     property string activeBtnColor: "#BAA59D"
     property string btnColor: "#D3BEB5"
     property string btnBorderColor: "#A28E85"
     background: Rectangle {
         x: control.leftPadding
         y: control.topPadding + control.availableHeight / 2 - height / 2
         implicitWidth: 200
         implicitHeight: 4
         width: control.availableWidth
         height: implicitHeight
         radius: 2
         color: leftColor
         Rectangle {
             width: control.visualPosition * parent.width
             height: parent.height
             color: rightColor
             radius: 2
             Behavior on width {
                 PropertyAnimation{
                     duration: 50
                 }
             }
         }
         Rectangle{
             anchors.fill: parent
             color: "#999"
             opacity: control.enabled ? 0 : 0.6
             Behavior on opacity {
                 PropertyAnimation{
                     duration: 200
                 }
             }
         }
     }
     handle: Rectangle {
         x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
         y: control.topPadding + control.availableHeight / 2 - height / 2
         implicitWidth: 15
         implicitHeight: 15
         radius: 15
         color: control.pressed ? activeBtnColor : btnColor
         border.color: btnBorderColor
         Behavior on x {
             PropertyAnimation{
                 duration: 50
             }
         }
     }
 }
