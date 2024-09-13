import QtQuick 2.15
import DownloadUtil 1.0

import "../../comp"
Item {

    property var latest: []
    property var snapshot: []
    property var release: []
    property var fools: []
    property var oldVersions: []
    id: downloadMinecraft
    Flickable{
        id: flickable
        width: mainPage.width-leftComp.width-60
        height: mainPage.height-40
        contentHeight: 20*6+50*5
        clip: true
        onContentHeightChanged: {
            if(flickable.contentHeight <= 20*6+50*5){
                flickable.contentHeight = 20*6+50*5
            }
        }
        Behavior on contentHeight{
            PropertyAnimation{
                easing{
                    type: Easing.OutElastic
                    amplitude: 1
                    period: 1
                }
                duration: 500
            }
        }

        DownloadUtil{
            id: downloadUtil
            onReturnGetMinecraftList: function(data){
                latest = data["latest"]
                release = data["release"]
                snapshot = data["snapshot"]
                fools = data["fools"]
                oldVersions = data["olds"]

                latestRepeater.model = latest
                releaseList.model = release
                snapshotList.model = snapshot
                foolsList.model = fools
                oldVersionsList.model = oldVersions


                latestDrawer.contentHeight = latest.length*(50+10)+5

                releaseDrawer.contentHeight = 415
                snapshotDrawer.contentHeight = 415
                foolsDrawer.contentHeight = 415
                oldVersionsDrawer.contentHeight = 415


            }
        }
        Column{
            id: content
            width: parent.width-80
            y: 20
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter
            ThemeDrawer{
                id: latestDrawer
                width: parent.width
                color: window.subColor
                title: "最新版"
                Column{
                    id: latestColumn
                    width: parent.width
                    y: 55
                    spacing: 10
                    Repeater{
                        id: latestRepeater
                        model: latest
                        ShadowRectangle{
                            width: parent.width-40
                            anchors.horizontalCenter: parent.horizontalCenter
                            height: 50
                            radius: 10
                            color: "#f1f1f1"
                            Image{
                                x: 10
                                y: 8
                                width: 35
                                height: 35
                                smooth: false
                                source: index === 0 ? "/img/Minecraft.png" : "/img/CraftingTable.png"
                            }
                            Text{
                                x: 50
                                anchors.verticalCenter: parent.verticalCenter
                                text: qsTr(latest[index])
                                font.pixelSize: 15
                            }
                            Row{
                                width: 170
                                height: 35
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 55
                                spacing: 10
                                visible: index === 0
                                Rectangle{
                                    width: 35
                                    height: 35
                                    color: "transparent"
                                    Behavior on color {
                                        PropertyAnimation{
                                            duration: 200
                                        }
                                    }
                                    radius: 10
                                    Image {
                                        width: 30
                                        height: 30
                                        anchors.centerIn: parent
                                        smooth: false
                                        source: "/img/Minecraft.png"
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onEntered: {
                                            parent.color = "#aaa"
                                        }
                                        onExited: {
                                            parent.color = "transparent"
                                        }
                                        onClicked: {

                                        }
                                    }
                                }

                                Rectangle{
                                    width: 35
                                    height: 35
                                    color: "transparent"
                                    Behavior on color {
                                        PropertyAnimation{
                                            duration: 200
                                        }
                                    }
                                    radius: 10
                                    Image {
                                        width: 30
                                        height: 30
                                        anchors.centerIn: parent
                                        smooth: false
                                        source: "/img/Optifine.png"
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onEntered: {
                                            parent.color = "#aaa"
                                        }
                                        onExited: {
                                            parent.color = "transparent"
                                        }
                                        onClicked: {

                                        }
                                    }
                                }

                                Rectangle{
                                    width: 35
                                    height: 35
                                    color: "transparent"
                                    Behavior on color {
                                        PropertyAnimation{
                                            duration: 200
                                        }
                                    }
                                    radius: 10
                                    Image {
                                        width: 30
                                        height: 30
                                        anchors.centerIn: parent
                                        smooth: false
                                        source: "/img/Forge.png"
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onEntered: {
                                            parent.color = "#aaa"
                                        }
                                        onExited: {
                                            parent.color = "transparent"
                                        }
                                        onClicked: {

                                        }
                                    }
                                }

                                Rectangle{
                                    width: 35
                                    height: 35
                                    color: "transparent"
                                    Behavior on color {
                                        PropertyAnimation{
                                            duration: 200
                                        }
                                    }
                                    radius: 10
                                    Image {
                                        width: 30
                                        height: 30
                                        anchors.centerIn: parent
                                        smooth: false
                                        source: "/img/Fabric.png"
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onEntered: {
                                            parent.color = "#aaa"
                                        }
                                        onExited: {
                                            parent.color = "transparent"
                                        }
                                        onClicked: {

                                        }
                                    }
                                }

                            }
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 10
                                text: qsTr(index == 0 ? "正式版" : "快照版")
                            }
                            Behavior on color{
                                PropertyAnimation{
                                    duration: 200
                                }
                            }

                            MouseArea{
                                anchors.fill: parent
                                visible: index !== 0
                                hoverEnabled: true
                                onEntered: {
                                    parent.color = "#e1e1e1"
                                }
                                onExited: {
                                    parent.color = "#f1f1f1"
                                }
                                onClicked: {

                                }
                            }
                        }
                    }
                }
                onOpenDrawer: {
                    flickable.contentHeight += 125
                }
                onCloseDrawer: {
                    flickable.contentHeight -= 125
                }
            }



            ThemeDrawer{
                id: releaseDrawer
                width: parent.width
                color: window.subColor
                title: "稳定版"
                ListView{
                    id: releaseList
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: 55
                    width: parent.width-40
                    height: 400
                    model: release
                    clip: true
                    delegate:Item {
                        width: releaseList.width
                        height: 60
                        ShadowRectangle{
                            width: parent.width
                            height: 50
                            radius: 10
                            Image{
                                x: 10
                                y: 8
                                width: 35
                                height: 35
                                smooth: false
                                source: "/img/Minecraft.png"
                            }
                            Text{
                                x: 50
                                anchors.verticalCenter: parent.verticalCenter
                                text: qsTr(modelData)
                                font.pixelSize: 15
                            }
                            Row{
                                width: 170
                                height: 35
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 10
                                spacing: 10
                                Rectangle{
                                    width: 35
                                    height: 35
                                    color: "transparent"
                                    Behavior on color {
                                        PropertyAnimation{
                                            duration: 200
                                        }
                                    }
                                    radius: 10
                                    Image {
                                        width: 30
                                        height: 30
                                        anchors.centerIn: parent
                                        smooth: false
                                        source: "/img/Minecraft.png"
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onEntered: {
                                            parent.color = "#aaa"
                                        }
                                        onExited: {
                                            parent.color = "transparent"
                                        }
                                        onClicked: {

                                        }
                                    }
                                }

                                Rectangle{
                                    width: 35
                                    height: 35
                                    color: "transparent"
                                    Behavior on color {
                                        PropertyAnimation{
                                            duration: 200
                                        }
                                    }
                                    radius: 10
                                    Image {
                                        width: 30
                                        height: 30
                                        anchors.centerIn: parent
                                        smooth: false
                                        source: "/img/Optifine.png"
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onEntered: {
                                            parent.color = "#aaa"
                                        }
                                        onExited: {
                                            parent.color = "transparent"
                                        }
                                        onClicked: {

                                        }
                                    }
                                }

                                Rectangle{
                                    width: 35
                                    height: 35
                                    color: "transparent"
                                    Behavior on color {
                                        PropertyAnimation{
                                            duration: 200
                                        }
                                    }
                                    radius: 10
                                    Image {
                                        width: 30
                                        height: 30
                                        anchors.centerIn: parent
                                        smooth: false
                                        source: "/img/Forge.png"
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onEntered: {
                                            parent.color = "#aaa"
                                        }
                                        onExited: {
                                            parent.color = "transparent"
                                        }
                                        onClicked: {

                                        }
                                    }
                                }

                                Rectangle{
                                    width: 35
                                    height: 35
                                    color: "transparent"
                                    Behavior on color {
                                        PropertyAnimation{
                                            duration: 200
                                        }
                                    }
                                    radius: 10
                                    Image {
                                        width: 30
                                        height: 30
                                        anchors.centerIn: parent
                                        smooth: false
                                        source: "/img/Fabric.png"
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onEntered: {
                                            parent.color = "#aaa"
                                        }
                                        onExited: {
                                            parent.color = "transparent"
                                        }
                                        onClicked: {

                                        }
                                    }
                                }

                            }

                        }
                    }
                }
                onOpenDrawer: {
                    flickable.contentHeight += 415
                }
                onCloseDrawer: {
                    flickable.contentHeight -= 415
                }
            }


            ThemeDrawer{
                id: snapshotDrawer
                width: parent.width
                color: window.subColor
                title: "快照版"
                ListView{
                    id: snapshotList
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: 55
                    width: parent.width-40
                    height: 400
                    model: snapshot
                    clip: true
                    delegate:Item {
                        width: snapshotList.width
                        height: 60
                        ShadowRectangle{
                            width: parent.width
                            height: 50
                            radius: 10
                            Image{
                                x: 10
                                y: 8
                                width: 35
                                height: 35
                                smooth: false
                                source: "/img/CraftingTable.png"
                            }
                            Text{
                                x: 50
                                anchors.verticalCenter: parent.verticalCenter
                                text: qsTr(modelData)
                                font.pixelSize: 15
                            }

                            Behavior on color{
                                PropertyAnimation{
                                    duration: 200
                                }
                            }

                            MouseArea{
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: {
                                    parent.color = "#e1e1e1"
                                }
                                onExited: {
                                    parent.color = "#f1f1f1"
                                }
                                onClicked: {

                                }
                            }
                        }
                    }
                }
                onOpenDrawer: {
                    flickable.contentHeight += 415
                }
                onCloseDrawer: {
                    flickable.contentHeight -= 415
                }
            }


            ThemeDrawer{
                id: foolsDrawer
                width: parent.width
                color: window.subColor
                title: "愚人节版本"
                ListView{
                    id: foolsList
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: 55
                    width: parent.width-40
                    height: 400
                    model: fools
                    clip: true
                    delegate:Item {
                        width: foolsList.width
                        height: 60
                        ShadowRectangle{
                            width: parent.width
                            height: 50
                            radius: 10
                            Image{
                                x: 10
                                y: 8
                                width: 35
                                height: 35
                                smooth: false
                                source: "/img/fools_ico/"+modelData+".png"
                            }
                            Text{
                                x: 50
                                anchors.verticalCenter: parent.verticalCenter
                                text: qsTr(modelData)
                                font.pixelSize: 15
                            }
                            Behavior on color{
                                PropertyAnimation{
                                    duration: 200
                                }
                            }

                            MouseArea{
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: {
                                    parent.color = "#e1e1e1"
                                }
                                onExited: {
                                    parent.color = "#f1f1f1"
                                }
                                onClicked: {

                                }
                            }
                        }
                    }
                }
                onOpenDrawer: {
                    flickable.contentHeight += 415
                }
                onCloseDrawer: {
                    flickable.contentHeight -= 415
                }
            }


            ThemeDrawer{
                id: oldVersionsDrawer
                width: parent.width
                color: window.subColor
                title: "远古版"
                ListView{
                    id: oldVersionsList
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: 55
                    width: parent.width-40
                    height: 400
                    model: oldVersions
                    clip: true
                    delegate:Item {
                        width: oldVersionsList.width
                        height: 60
                        ShadowRectangle{
                            width: parent.width
                            height: 50
                            radius: 10
                            Image{
                                x: 10
                                y: 8
                                width: 35
                                height: 35
                                smooth: false
                                source: "/img/oldVersion_ico/" + (
                                            modelData.substring(0,1) === "b" ? "beta" :
                                            modelData.substring(0,1) === "a" ? "alpha" :
                                            modelData.substring(0,1) === "c" ? "classic" :
                                            modelData.substring(0,1) === "r" ? "pre-classic" : "indev"
                                            ) +".png"
                            }
                            Text{
                                x: 50
                                anchors.verticalCenter: parent.verticalCenter
                                text: qsTr(modelData)
                                font.pixelSize: 15
                            }
                            Behavior on color{
                                PropertyAnimation{
                                    duration: 200
                                }
                            }

                            MouseArea{
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: {
                                    parent.color = "#e1e1e1"
                                }
                                onExited: {
                                    parent.color = "#f1f1f1"
                                }
                                onClicked: {

                                }
                            }
                        }
                    }
                }
                onOpenDrawer: {
                    flickable.contentHeight += 415
                }
                onCloseDrawer: {
                    flickable.contentHeight -= 415
                }
            }




        }
    }
    Component.onCompleted: {
        downloadUtil.getMinecraftList()
    }
}
