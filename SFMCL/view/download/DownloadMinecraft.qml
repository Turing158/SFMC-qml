import QtQuick 2.15
import DownloadUtil 1.0

import "../../comp"
Item {
    property var latest: []
    property var snapshot: []
    property var release: []
    property var beta: []
    property var alpha: []
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
                beta = data["beta"]
                alpha = data["alpha"]

                latestRepeater.model = latest
                releaseList.model = release
                snapshotList.model = snapshot
                betaList.model = beta
                alphaList.model = alpha


                latestDrawer.contentHeight = latest.length*(50+10)+5

                releaseDrawer.contentHeight = 415
                snapshotDrawer.contentHeight = 415
                betaDrawer.contentHeight = 415
                alphaDrawer.contentHeight = 415


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
                color: "#D3BEB5"
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
                                source: index == 0 ? "/img/Minecraft.png" : "/img/table.png"
                            }
                            Text{
                                x: 50
                                anchors.verticalCenter: parent.verticalCenter
                                text: qsTr(latest[index])
                                font.pixelSize: 15
                            }
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 10
                                text: qsTr(index == 0 ? "正式版" : "快照版")
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
                color: "#D3BEB5"
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
                color: "#D3BEB5"
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
                                source: "/img/table.png"
                            }
                            Text{
                                x: 50
                                anchors.verticalCenter: parent.verticalCenter
                                text: qsTr(modelData)
                                font.pixelSize: 15
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
                id: betaDrawer
                width: parent.width
                color: "#D3BEB5"
                title: "Beta版"
                ListView{
                    id: betaList
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: 55
                    width: parent.width-40
                    height: 400
                    model: beta
                    clip: true
                    delegate:Item {
                        width: betaList.width
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
                                source: "/img/table.png"
                            }
                            Text{
                                x: 50
                                anchors.verticalCenter: parent.verticalCenter
                                text: qsTr(modelData)
                                font.pixelSize: 15
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
                id: alphaDrawer
                width: parent.width
                color: "#D3BEB5"
                title: "Alpha版"
                ListView{
                    id: alphaList
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: 55
                    width: parent.width-40
                    height: 400
                    model: alpha
                    clip: true
                    delegate:Item {
                        width: alphaList.width
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
                                source: "/img/table.png"
                            }
                            Text{
                                x: 50
                                anchors.verticalCenter: parent.verticalCenter
                                text: qsTr(modelData)
                                font.pixelSize: 15
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
