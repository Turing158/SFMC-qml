import QtQuick
import QtQuick.Controls.Basic
Popup {
    property string title: ""
    property bool titleFontBold: true
    property int titleFontSize: 15
    property string titleColor: "#131313"
    property string content: ""
    property bool contentFontBold: false
    property int contentFontSize: 12
    property string contentColor: "#131313"
    property string themeColor: "#38555F"
    property bool isShowConfirm: true
    property bool isShowCancle: false
    property int buttonWidth: 60
    property int buttonHeight: 25
    property int buttonFontSize: 13
     id: popup
     parent: mainPage
     anchors.centerIn: parent
     width: 300
     height: 150


     contentItem: Column {
         id: main
         transform: Scale{
             id: mainScale
             origin.x: popup.width/2
             origin.y: popup.height/2
             xScale: 0
             yScale: 0
         }
        Item{
            id: headerItem
            width: parent.width
            Text{
                id:titleText
                text: qsTr(title)
                font.bold: titleFontBold
                font.pixelSize: titleFontSize
                color: titleColor
            }
            height: titleText.font.pixelSize+2
        }
        Empty{num: 8}
        Rectangle{
            width: popup.width-4
            x: -10
            height: 2
            color: themeColor
        }
        Item{
            id: contentItem
            width: parent.width
            height: main.height-titleText.font.pixelSize-footerItem.height-8
            Text{
                id: contentText
                text: qsTr(content)
                anchors.centerIn: contentItem
                font.bold: contentFontBold
                font.pixelSize: contentFontSize
                color: contentColor
            }
        }
        Item{
            id: footerItem
            anchors.right: parent.right
            width: button.width
            height: buttonHeight
            Row{
                id: button
                ThemeButton{
                    width: buttonWidth
                    height: buttonHeight
                    text: qsTr("确认")
                    visible: isShowConfirm
                    fontSize: buttonFontSize
                    onClicked: {
                        popup.confirm()
                    }
                }
                Empty{orientation: "hor";num: 5;visible: isShowCancle}
                ThemeButton{
                    width: buttonWidth
                    height: buttonHeight
                    text: qsTr("取消")
                    visible: isShowCancle
                    fontSize: buttonFontSize
                    onClicked: {
                        popup.cancle()
                    }
                }
            }
        }
     }
     background: Rectangle {
         implicitWidth: parent.width
         implicitHeight: parent.height
         color: "#f1f1f1"
         radius: 5
         transform: Scale{
             id: bgScale
             origin.x: popup.width/2
             origin.y: popup.height/2
             xScale: 0
             yScale: 0
         }
     }
     Overlay.modal: Rectangle{
         color: "#131313"
         opacity: 0.5
         radius: 10
     }
    closePolicy: Popup.NoAutoClose
     modal: true
     signal confirm()
     onConfirm: {
        if(!isShowCancle){
            cancle()
        }
     }
     signal cancle()
     onCancle: {
         closeAnimation.start()
         closeAnimationAfter.start()
     }
     onOpened: {
         popup.modal = true
        openAnimation.start()
     }
     Timer{
         id: closeAnimationAfter
         interval: 100
         onTriggered: {
            popup.close()
         }
     }

     ParallelAnimation{
         id: openAnimation
         PropertyAnimation{
             targets: [bgScale,mainScale]
             properties: "yScale"
             easing{
                 type: Easing.OutElastic
                 amplitude: 1.5
                 period: 1
             }
             to: 1
             duration: 500
         }
         PropertyAnimation{
             targets: [bgScale,mainScale]
             properties: "xScale"
             easing{
                 type: Easing.OutElastic
                 amplitude: 1.5
                 period: 1
             }
             to: 1
             duration: 500
         }
     }
     ParallelAnimation{
         id: closeAnimation
         PropertyAnimation{
             targets: [bgScale,mainScale]
             properties: "yScale"
             easing{
                 type: Easing.OutElastic
                 amplitude: 1.5
                 period: 1
             }
             to: 0
             duration: 500
         }
         PropertyAnimation{
             targets: [bgScale,mainScale]
             easing{
                 type: Easing.OutElastic
                 amplitude: 1.5
                 period: 1
             }
             properties: "xScale"
             to: 0
             duration: 500
         }
     }
 }
