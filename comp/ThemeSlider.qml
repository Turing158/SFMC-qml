import QtQuick
import QtQuick.Controls.Basic

 Slider {
     id: control
     background: Rectangle {
         x: control.leftPadding
         y: control.topPadding + control.availableHeight / 2 - height / 2
         implicitWidth: 200
         implicitHeight: 4
         width: control.availableWidth
         height: implicitHeight
         radius: 2
         color: "#AEC6CF"
         Rectangle {
             width: control.visualPosition * parent.width
             height: parent.height
             color: "#273B42"
             radius: 2
         }
         Rectangle{
             anchors.fill: parent
             color: "#999"
             opacity: control.enabled ? 0 : 0.6
         }
     }

     handle: Rectangle {
         x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
         y: control.topPadding + control.availableHeight / 2 - height / 2
         implicitWidth: 15
         implicitHeight: 15
         radius: 15
         color: control.pressed ? "#BAA59D" : "#D3BEB5"
         border.color: "#A28E85"
     }
 }
