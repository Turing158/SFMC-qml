import QtQuick
import Qt5Compat.GraphicalEffects
import "../../comp"
Item {
    id:versionSelect
    property var versions: []
    Rectangle{

        id:leftComp
        width: mainPage.width/2-120
        height: mainPage.height-40
        x:20
        y:20
        color:"transparent"
        ListView {
            y:10
             width: parent.width
             height: parent.height-10
             model: window.dirList


             delegate: Rectangle{
                 width: leftComp.width
                 height: 48
                 color: "transparent"
                 Rectangle{
                     width: parent.width
                     height: 45
                     anchors.bottom: parent.bottom
                     color: "transparent"
                 }
                 Text{
                     x: 10
                     anchors.top: parent.top
                     anchors.topMargin: 8
                     text: index === 0 ? qsTr("当前文件夹") : qsTr(getDirName())
                     font.pixelSize: 14
                     font.bold: Font.Bold
                     function getDirName(){
                         var tmp = window.dirList[index].split("/")
                         return tmp[tmp.length-2]
                     }
                 }
                 Text{
                     x: 10
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 3
                     text: qsTr(window.dirList[index])
                     color: "#666"
                 }
                 MouseArea{
                     anchors.fill: parent
                     hoverEnabled: true
                     onEntered: {

                     }
                 }
             }
         }
    }
    property int activeIndex: -1
    Rectangle{
        id: rightComp
        width: mainPage.width/2+20
        height: mainPage.height-40
        y:20
        anchors{
            left: leftComp.right
            leftMargin: 30
        }
        color: "transparent"

        ListView {
            y:20
             width: parent.width
             height: parent.height-50
             model: versions
             delegate: Rectangle{
                 width: rightComp.width
                 height: 55
                 color: "transparent"
                 Rectangle{
                     width: parent.width
                     height: 45
                     color: activeIndex  === index ? "#eaeaea" : "#f1f1f1"
                     Behavior on color{
                         PropertyAnimation{
                             easing.type: Easing.OutBounce
                            duration: 200
                         }
                     }
                     radius: 10
                     layer.enabled: true
                     layer.effect: DropShadow{
                         radius:6
                         samples: 13
                         color: activeIndex  === index ? "#496E7C" : "#999"
                         Behavior on color{
                             PropertyAnimation{
                                 easing.type: Easing.OutBounce
                                duration: 500
                             }
                         }
                     }
                     Text{
                         x: 20
                         anchors.verticalCenter: parent.verticalCenter
                         text: qsTr(versions[index])
                         font{
                             pixelSize: 16
                             bold: true
                         }
                     }
                     MouseArea{
                         anchors.fill: parent
                         hoverEnabled: true
                         onClicked: {
                             launcher.selectVersion = versions[index]
                             subWindowShow.stop()
                             subWindowHide.start()
                             subWindowTitle.text = qsTr("")
                         }
                         onEntered: {
                             activeIndex = index
                         }
                         onExited: {
                             activeIndex = -1
                         }
                     }

                 }
             }
         }
        ShadowRectangle{
            width: parent.width-100
            height: 60
            anchors.centerIn: parent
            radius: 10
            z: versions.length === 0 ? 1 : -999
            opacity: versions.length === 0 ? 1 : 0
            Text{
                anchors.centerIn: parent
                text: qsTr("未找到Minecraft版本")
                font.pixelSize: 20
            }
        }
    }
    signal findVersion()
    Component.onCompleted: {
        findVersion()
    }
    Connections{
        target: versionSelect
        function onFindVersion(){
            versions = launcherUtil.findVersion(launcher.selectDir)
        }
    }

    // launcherUtil

}
