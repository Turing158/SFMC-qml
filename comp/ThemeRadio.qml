import QtQuick
 import QtQuick.Controls.Basic

 RadioButton {
     property bool fullPoint: true
     id: control
     checked: false
     width: 20
     height: 20
     indicator: Rectangle {
         implicitWidth: control.height
         implicitHeight: control.height
         x: control.leftPadding
         y: parent.height / 2 - height / 2
         radius: control.width
         color: "transparent"
         border.color: control.down ? "#273B42" : "#38555F"
         Rectangle {
             x: control.height/2-(control.height-5)/2
             y: control.height/2-(control.height-5)/2
             width: control.height-5
             height: control.height-5
             radius: control.height
             color: control.down ? "#273B42" : "#38555F"
             visible: control.checked
         }
     }
     contentItem: Text {
         text: control.text
         font: control.font
         opacity: enabled ? 1.0 : 0.3
         color: control.down ? "#273B42" : "#38555F"
         verticalAlignment: Text.AlignVCenter
         leftPadding: control.indicator.width + control.spacing
     }
 }
