import QtQuick
 import QtQuick.Controls.Basic

 RadioButton {
     property string btnColor: window.deepColor_4
     property string activeColor: window.deepColor_5
     property int buttonRadius: control.height
     id: control
     checked: false
     width: 20
     height: 20
     indicator: Rectangle {
         implicitWidth: control.height
         implicitHeight: control.height
         x: control.leftPadding
         y: parent.height / 2 - height / 2
         radius: buttonRadius
         color: "transparent"
         border.color: control.down ? activeColor : btnColor
         Rectangle {
             id: activePoint
             height: control.height*0.7
             width: activePoint.height
             x: control.height/2-(activePoint.height)/2
             y: control.height/2-(activePoint.height)/2
             radius: buttonRadius
             color: control.down ? activeColor : btnColor
             transform: Scale {
                 id: activePointScale
                 origin.x: activePoint.width/2
                 origin.y: activePoint.height/2
                 xScale: control.checked ? 1 : 0
                 yScale: control.checked ? 1 : 0
                 Behavior on xScale {
                     PropertyAnimation{
                         easing{
                             type: Easing.OutElastic
                             amplitude: 1.5
                             period: 5
                         }
                         duration: 500
                     }
                 }
                 Behavior on yScale {
                     PropertyAnimation{
                         easing{
                             type: Easing.OutElastic
                             amplitude: 1.5
                             period: 5
                         }
                         duration: 500
                     }
                 }
             }
             Behavior on color {
                 PropertyAnimation{
                     duration: 100
                 }
             }
         }
     }
     contentItem: Text {
         text: control.text
         font: control.font
         opacity: enabled ? 1.0 : 0.3
         color: activeColor
         verticalAlignment: Text.AlignVCenter
         leftPadding: control.indicator.width + control.spacing
     }
     onCheckedChanged: {
         changeChecked()
     }
     onPressed: {
         activePointScale.xScale = 0.6
         activePointScale.yScale = 0.6
     }
     onReleased: {
         changeChecked()
     }
     onCanceled: {
         changeChecked()
     }
     signal reloadAnimation()
     onReloadAnimation: {
         changeChecked()
     }
     function changeChecked(){
         if(checked){
             activePointScale.xScale = 1
             activePointScale.yScale = 1
         }
         else{
             activePointScale.xScale = 0
             activePointScale.yScale = 0
         }
     }
 }
