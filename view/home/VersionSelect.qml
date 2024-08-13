import QtQuick
import Qt5Compat.GraphicalEffects
import QtQuick.Controls
import QtQuick.Dialogs
import "../../comp"
Item {
    id:versionSelect
    property var versions: []
    property int activeDirIndex: dirList.indexOf(launcher.selectDir)
    Rectangle{
        id:leftComp
        width: mainPage.width/2-120
        height: mainPage.height-40
        x:20
        y:20
        color:"transparent"
        clip: true
        ListView {
            id: dirListView
            y:10
             width: parent.width
             height: parent.height-10
             model: window.dirList
             delegate: Rectangle{
                 width: leftComp.width
                 height: 48
                 color: "transparent"
                 clip: true
                 Rectangle{
                     id: delegateBg
                     width: parent.width
                     height: 45
                     anchors.bottom: parent.bottom
                     radius: 10
                     color: activeDirIndex === index ? "#f1f1f1" : "transparent"
                 }
                 Text{
                     x: 10
                     anchors.top: parent.top
                     anchors.topMargin: 8
                     text: index === 0 ? qsTr("当前文件夹") : qsTr(getDirName())
                     font.pixelSize: 14
                     font.bold: Font.Bold
                     function getDirName(){
                         var tmp = modelData.split("/")
                         return tmp[tmp.length-2]
                     }
                 }
                 Text{
                     x: 10
                     width: parent.width-15
                     anchors.bottom: parent.bottom
                     anchors.bottomMargin: 3
                     text: qsTr(modelData)
                     elide: Text.ElideRight
                     color: "#666"
                     ThemeToolTip{
                         id: tips
                         y: -5
                         x: -5
                         height: 25
                         text: qsTr(modelData)
                         MouseArea{
                             width: delegateBg.width
                             height: delegateBg.height
                             onClicked: {
                                 if(activeDirIndex !== index){
                                     activeDirIndex = index
                                     launcher.selectDir = modelData
                                     changeDirAnimationBefore.stop()
                                     changeDirAnimationBefore.start()
                                     changeDirAnimation.stop()
                                     changeDirAnimation.start()
                                 }
                             }
                         }
                     }
                 }
                 Timer{
                    id: tipShow
                    interval: 500
                    onTriggered: {
                        tips.show()
                    }
                 }
                 MouseArea{
                     anchors.fill: parent
                     hoverEnabled: true
                     onEntered: {
                        tipShow.start()
                     }
                     onExited: {
                         tipShow.stop()
                         tips.hide()
                     }
                     onClicked: {
                         if(activeDirIndex !== index){
                             activeDirIndex = index
                             launcher.selectDir = modelData
                             changeDirAnimationBefore.stop()
                             changeDirAnimationBefore.start()
                             changeDirAnimation.stop()
                             changeDirAnimation.start()
                         }
                     }
                 }

                 ThemeButton{
                     anchors.right: parent.right
                     y: 16
                     anchors.rightMargin: 10
                     width: 20
                     height: 20
                     text: qsTr("×")
                     fontSize: 15
                     onClicked: {
                         window.dirList.splice(index,1)
                        if(activeDirIndex>index){
                            activeDirIndex -=1
                        }
                        else if(activeDirIndex === index){
                            activeDirIndex  = 0
                            launcher.selectDir = window.dirList[0]
                            console.log(window.dirList[0])
                            changeDirAnimationBefore.stop()
                            changeDirAnimationBefore.start()
                            changeDirAnimation.stop()
                            changeDirAnimation.start()
                        }
                        dirListView.model = window.dirList
                     }
                     visible: index !== 0
                 }
             }
         }
        Timer{
            id: changeDirAnimation
            onTriggered: {
                findVersion()
                changeDirAnimationAfter.start()
            }
            interval: 200
        }
        ThemeButton{
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.bottomMargin: 10
            anchors.rightMargin: 10
            width: 35
            height: 35
            radius: 35
            text: qsTr("+")
            fontSize: 20
            onClicked: {
                addFolder.open()
            }
        }
        FolderDialog{
            id: addFolder
            title: "请选择存放.minecraft的文件夹"
            onAccepted: {
                var path = selectedFolder.toString().substring(8)+"/.minecraft"
                if(window.dirList.indexOf(path) === -1){
                    window.dirList.push(path)
                    dirListView.model = window.dirList
                    globalTips.show("添加成功",path,path.length>40 ? "larger" : "")
                }
                else{
                    globalTips.show("","该文件夹路径已存在","")
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
        Loader{
            id: versionSelectLoader
             y:20
             width: parent.width
             height: parent.height-50
            sourceComponent: versionSelectComp
        }

        Component{
            id: versionSelectComp
            ListView {
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
                         color: launcher.selectVersion === modelData ? "#D3BEB5" : activeIndex  === index ? "#eaeaea" : "#f1f1f1"
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
                             text: qsTr(modelData)
                             font{
                                 pixelSize: 16
                                 bold: true
                             }
                         }
                         MouseArea{
                             anchors.fill: parent
                             hoverEnabled: true
                             onClicked: {
                                 launcher.selectVersion = modelData
                                 subWindowShow.stop()
                                 subWindowHide.start()
                                 subWindowTitle.text = qsTr("")
                                 launcher.initJavaPath()
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
                 Component.onCompleted: {
                     launcher.initJavaPath()
                 }
             }
        }

        Component{
            id: noVersions
            Item{
                anchors.fill: parent
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
        }
    }
    ParallelAnimation{
        id: changeDirAnimationBefore
        PropertyAnimation{
            target: versionSelectLoader
            properties: "opacity"
            to: 0
            duration: 100
        }
        PropertyAnimation{
            target: versionSelectLoader
            properties: "y"
            to: -versionSelectLoader.height
            duration: 200
        }
    }
    ParallelAnimation{
        id: changeDirAnimationAfter
        PropertyAnimation{
            target: versionSelectLoader
            properties: "opacity"
            to: 1
            duration: 200
        }
        PropertyAnimation{
            target: versionSelectLoader
            easing.type: Easing.OutBounce
            properties: "y"
            to: 20
            duration: 100
        }
    }

    Component.onCompleted: {
        findVersion()
    }
    signal findVersion()
    Connections{
        target: versionSelect
        function onFindVersion(){
            versions = launcherUtil.findVersion(launcher.selectDir)
            versionSelectLoader.sourceComponent = null
            if(versions.length === 0){
                launcher.selectVersion = ""
                versionSelectLoader.sourceComponent = noVersions
            }
            else{
                if(launcher.selectVersion == ""){
                    launcher.selectVersion = versions[0]
                }
                versionSelectLoader.sourceComponent = versionSelectComp
            }
        }
    }

    // launcherUtil

}
