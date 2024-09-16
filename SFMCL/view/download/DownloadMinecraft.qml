import QtQuick 2.15
import DownloadUtil 1.0
import QtQuick.Controls
import "../../comp"
Item {

    property var latest: []
    property var snapshot: []
    property var release: []
    property var fools: []
    property var oldVersions: []
    property var supprotOptifine: []
    property var supprotForge: []
    property var supprotFabric: []
    id: downloadMinecraft
    width: mainPage.width-leftComp.width-60
    height: mainPage.height-40
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

            waitProcess.width = 280
            process.width = 280
            process.setTips("正在获取Optifine支持的Minecraft版本中...")
        }
        onReturnMinecraftOfSupportingOptifine: function(data){
            supprotOptifine = data
            process.setTips("正在获取Forge支持的Minecraft版本中...")
        }
        onReturnMinecraftOfSupportingForge: function(data){
            supprotForge = data
            process.setTips("正在获取Fabric支持的Minecraft版本中...")
        }
        onReturnMinecraftOfSupportingFabric: function(data){
            supprotFabric = data

            endingLoading()
        }
        onErrorGetMinecraftList: {
            waitProcess.height = 100
            waitProcess.y = downloadMinecraft.height/2-waitProcess.height/2
            process.opacity = 0
            errorLoading.opacity = 1
            longTimeNotLoad.stop()
        }
        signal endingLoading()
        onEndingLoading: {
            waitProcess.y = -waitProcess.height
            waitProcess.opacity = 0

            flickable.y = 0
            flickable.opacity = 1
            longTimeNotLoad.stop()
        }
    }
    Component.onCompleted: {
        downloadUtil.getMinecraftList()
        waitProcess.y = downloadMinecraft.height/2-waitProcess.height/2
        waitProcess.opacity = 1
        longTimeNotLoad.start()
    }
    Timer{
        id: longTimeNotLoad
        interval: 3000
        onTriggered: {
            globalTips.show("","如果过久没有加载出Minecraft列表，可尝试切换页面刷新","")
        }
    }
    ShadowRectangle{
        id: waitProcess
        visible: flickable.y !== 0
        width: 200
        height: 60
        radius: 10
        y: height
        anchors.horizontalCenter: parent.horizontalCenter
        Column{
            id: errorLoading
            width: parent.width
            opacity: 0
            Text{
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("×")
                font.bold: true
                font.pixelSize: 40
                color: "darkred"
            }
            Text{
                width: parent.width
                text: qsTr("加载Minecraft列表失败！\n请检查网络重试")
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 14
            }
            Behavior on opacity {
                PropertyAnimation{
                    duration: 200
                }
            }
        }

        ThemeTopProcessTips{
            id: process
            width: parent.width
            height: 60
            isCanWindowMove: false
            tipsText: "正在加载Minecraft版本中..."
            Behavior on opacity {
                PropertyAnimation{
                    duration: 200
                }
            }
        }
        Behavior on y {
            PropertyAnimation{
                easing{
                    type: Easing.OutElastic
                    amplitude: 1
                    period: 1
                }
                duration: 500
            }
        }
        Behavior on opacity {
            PropertyAnimation{
                duration: 200
            }
        }
    }


    Flickable{
        id: flickable
        width: mainPage.width-leftComp.width-60
        height: mainPage.height-40
        contentHeight: 20*6+50*5
        clip: true
        y: -mainPage.height-40
        opacity: 0
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
        Behavior on y {
            PropertyAnimation{
                easing{
                    type: Easing.OutElastic
                    amplitude: 1
                    period: 1
                }
                duration: 500
            }
        }
        Behavior on opacity {
            PropertyAnimation{
                duration: 200
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
                                height: 35
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 55
                                spacing: 10
                                visible: supprotOptifine.indexOf(latest[index]) !== -1 || supprotForge.indexOf(latest[index]) !== -1 || supprotFabric.indexOf(latest[index]) !== -1
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
                                            confirmVersionName.tipsVersion(latest[index])
                                            confirmVersionName.open()
                                        }
                                    }
                                }
                                Rectangle{
                                    width: 35
                                    height: 35
                                    color: "transparent"
                                    visible: supprotOptifine.indexOf(latest[index]) !== -1
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
                                            globalTips.show("","功能开发中","")
                                        }
                                    }
                                }

                                Rectangle{
                                    width: 35
                                    height: 35
                                    color: "transparent"
                                    visible: supprotForge.indexOf(latest[index]) !== -1
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
                                            globalTips.show("","功能开发中","")
                                        }
                                    }
                                }

                                Rectangle{
                                    width: 35
                                    height: 35
                                    color: "transparent"
                                    visible: supprotFabric.indexOf(latest[index]) !== -1
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
                                            globalTips.show("","功能开发中","")
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
                                visible: !(supprotOptifine.indexOf(latest[index]) !== -1 || supprotForge.indexOf(latest[index]) !== -1 || supprotFabric.indexOf(latest[index]) !== -1)
                                hoverEnabled: true
                                onEntered: {
                                    parent.color = "#e1e1e1"
                                }
                                onExited: {
                                    parent.color = "#f1f1f1"
                                }
                                onClicked: {
                                    confirmVersionName.tipsVersion(modelData)
                                    confirmVersionName.open()
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
                                height: 35
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 10
                                spacing: 10
                                visible: supprotOptifine.indexOf(modelData) !== -1 || supprotForge.indexOf(modelData) !== -1 || supprotFabric.indexOf(modelData) !== -1
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
                                            confirmVersionName.tipsVersion(modelData)
                                            confirmVersionName.open()
                                        }
                                    }
                                }
                                Rectangle{
                                    width: 35
                                    height: 35
                                    color: "transparent"
                                    visible: supprotOptifine.indexOf(modelData) !== -1
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
                                            globalTips.show("","功能开发中","")
                                        }
                                    }
                                }

                                Rectangle{
                                    width: 35
                                    height: 35
                                    color: "transparent"
                                    visible: supprotForge.indexOf(modelData) !== -1
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
                                            globalTips.show("","功能开发中","")
                                        }
                                    }
                                }

                                Rectangle{
                                    width: 35
                                    height: 35
                                    color: "transparent"
                                    visible: supprotFabric.indexOf(modelData) !== -1
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
                                            globalTips.show("","功能开发中","")
                                        }
                                    }
                                }

                            }
                            Behavior on color{
                                PropertyAnimation{
                                    duration: 200
                                }
                            }
                            MouseArea{
                                anchors.fill: parent
                                visible: !(supprotOptifine.indexOf(modelData) !== -1 || supprotForge.indexOf(modelData) !== -1 || supprotFabric.indexOf(modelData) !== -1)
                                hoverEnabled: true
                                onEntered: {
                                    parent.color = "#e1e1e1"
                                }
                                onExited: {
                                    parent.color = "#f1f1f1"
                                }
                                onClicked: {
                                    confirmVersionName.tipsVersion(modelData)
                                    confirmVersionName.open()
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

                            Row{
                                height: 35
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 10
                                spacing: 10
                                visible: supprotOptifine.indexOf(modelData) !== -1 || supprotForge.indexOf(modelData) !== -1 || supprotFabric.indexOf(modelData) !== -1
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
                                            confirmVersionName.tipsVersion(modelData)
                                            confirmVersionName.open()
                                        }
                                    }
                                }
                                Rectangle{
                                    width: 35
                                    height: 35
                                    color: "transparent"
                                    visible: supprotOptifine.indexOf(modelData) !== -1
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
                                            globalTips.show("","功能开发中","")
                                        }
                                    }
                                }

                                Rectangle{
                                    width: 35
                                    height: 35
                                    color: "transparent"
                                    visible: supprotForge.indexOf(modelData) !== -1
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
                                            globalTips.show("","功能开发中","")
                                        }
                                    }
                                }

                                Rectangle{
                                    width: 35
                                    height: 35
                                    color: "transparent"
                                    visible: supprotFabric.indexOf(modelData) !== -1
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
                                            globalTips.show("","功能开发中","")
                                        }
                                    }
                                }

                            }
                            Behavior on color{
                                PropertyAnimation{
                                    duration: 200
                                }
                            }
                            MouseArea{
                                anchors.fill: parent
                                visible: !(supprotOptifine.indexOf(modelData) !== -1 || supprotForge.indexOf(modelData) !== -1 || supprotFabric.indexOf(modelData) !== -1)
                                hoverEnabled: true
                                onEntered: {
                                    parent.color = "#e1e1e1"
                                }
                                onExited: {
                                    parent.color = "#f1f1f1"
                                }
                                onClicked: {
                                    confirmVersionName.tipsVersion(modelData)
                                    confirmVersionName.open()
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
                            Row{
                                height: 35
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 10
                                spacing: 10
                                visible: supprotOptifine.indexOf(modelData) !== -1 || supprotForge.indexOf(modelData) !== -1 || supprotFabric.indexOf(modelData) !== -1
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
                                            confirmVersionName.tipsVersion(modelData)
                                            confirmVersionName.open()
                                        }
                                    }
                                }
                                Rectangle{
                                    width: 35
                                    height: 35
                                    color: "transparent"
                                    visible: supprotOptifine.indexOf(modelData) !== -1
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
                                            globalTips.show("","功能开发中","")
                                        }
                                    }
                                }

                                Rectangle{
                                    width: 35
                                    height: 35
                                    color: "transparent"
                                    visible: supprotForge.indexOf(modelData) !== -1
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
                                            globalTips.show("","功能开发中","")
                                        }
                                    }
                                }

                                Rectangle{
                                    width: 35
                                    height: 35
                                    color: "transparent"
                                    visible: supprotFabric.indexOf(modelData) !== -1
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
                                            globalTips.show("","功能开发中","")
                                        }
                                    }
                                }

                            }
                            Behavior on color{
                                PropertyAnimation{
                                    duration: 200
                                }
                            }
                            MouseArea{
                                anchors.fill: parent
                                visible: !(supprotOptifine.indexOf(modelData) !== -1 || supprotForge.indexOf(modelData) !== -1 || supprotFabric.indexOf(modelData) !== -1)
                                hoverEnabled: true
                                onEntered: {
                                    parent.color = "#e1e1e1"
                                }
                                onExited: {
                                    parent.color = "#f1f1f1"
                                }
                                onClicked: {
                                    confirmVersionName.tipsVersion(modelData)
                                    confirmVersionName.open()
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
                                    confirmVersionName.tipsVersion(modelData)
                                    confirmVersionName.open()
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
        Popup{
            id: confirmVersionName
            width: 500
            height: 250
            modal: true
            background:Rectangle{
                color: "#f1f1f1"
                radius: 10
            }
            contentItem: Column{
                Text{
                    id: dialogTitile
                    width: parent.width
                    height: 30
                    text: qsTr("选择下载 ")
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                }
                Rectangle{
                    width: parent.width-20
                    height: 5
                    radius: 10
                    color: window.deepColor_5
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Item{
                    width: parent.width
                    height: 160
                    Column{
                        width: parent.width
                        y: 30
                        spacing: 10
                        Text{
                            width: parent.width
                            horizontalAlignment: Text.AlignHCenter
                            text: qsTr("给你下载的Minecraft版本起个名字")
                            font.pixelSize: 15
                        }
                        ThemeTextInput{
                            id: nameInput
                            width: parent.width-40
                            height: 30
                            placeholderText: "请输入版本名称"
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            onTextChanged: {
                                var flag = false
                                if(text.length === 0){
                                    inputTips.text = "版本名称不能为空"
                                }
                                else if(text.substring(0,1) === " "){
                                    inputTips.text = "版本名称开头不能为空格"
                                }
                                else if(text.substring(text.length-1,text.length) === " "){
                                    inputTips.text = "版本名称不能以空格结尾"
                                }
                                else if(text.indexOf("\\") !== -1){
                                    inputTips.text = "版本名称不能有 \\ 符号"
                                }
                                else if(text.indexOf("|") !== -1){
                                    inputTips.text = "版本名称不能有 | 符号"
                                }
                                else if(text.indexOf("/") !== -1){
                                    inputTips.text = "版本名称不能为空"
                                    console.log("版本名称不能有 / 符号")
                                }
                                else if(text.indexOf(";") !== -1){
                                    inputTips.text = "版本名称不能有 ; 符号"
                                }
                                else if(text.substring(text.length-1,text.length) === "."){
                                    inputTips.text = "版本名称不能以 . 符号结尾"
                                }
                                else{
                                    flag = true
                                }
                                if(flag){
                                    nameInput.borderColor = window.deepColor_5
                                    nameInput.activeColor = window.deepSubColor_1
                                    inputTips.opacity = 0
                                }
                                else{
                                    nameInput.borderColor = "darkred"
                                    nameInput.activeColor = "darkred"
                                    inputTips.opacity = 1

                                }
                            }
                        }
                        Text{
                            id: inputTips
                            width: parent.width
                            horizontalAlignment: Text.AlignHCenter
                            text: qsTr("")
                            font.pixelSize: 14
                            color: "darkred"
                            Behavior on opacity {
                                PropertyAnimation{
                                    duration: 200
                                }
                            }
                        }
                    }
                }
                Item{
                    width: parent.width
                    height: parent.height-200
                    Row{
                        width: 210
                        spacing: 10
                        anchors.right: parent.right
                        ThemeButton{
                            width: 100
                            height: 35
                            text: qsTr("开始安装")
                            fontSize: 14
                            onClicked: {
                                globalTips.show("","功能开发中","")
                                confirmVersionName.close()
                            }
                        }
                        ThemeButton{
                            width: 100
                            height: 35
                            text: qsTr("取消安装")
                            fontSize: 14
                            onClicked: {
                                confirmVersionName.close()
                            }
                        }
                    }
                }
            }

            signal tipsVersion(var text)
            onTipsVersion: function(text){
                dialogTitile.text = qsTr("下载安装 Minecraft "+text)
                nameInput.text = text
            }
        }
    }
}
