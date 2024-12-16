import QtQuick
import QtQuick.Controls
import Qt.labs.settings
import Player 1.0
import LauncherUtil 1.0
import Launcher 1.0
import "./comp"

Window{

    property int isOnline: 1
    property string choiseVersion: ""
    property var dirList: []
    property int isLogining: 0
    property int isLogined: player.onlinePlayerUser.length ? 1 : 0
    id:window
    width: 850
    height: 450
    visible: true
    flags: Qt.Window | Qt.FramelessWindowHint
    color: "#00000000"

    property string currentColorName: "grayBlue"


    property string mainColor: "#AEC6CF"
    property string deepMainColor_0: "#96ADB6"
    property string deepMainColor_1: "#7E959E"
    property string deepMainColor_2: "#687E86"
    property string subColor: "#D3BEB5"
    property string deepSubColor_0: "#BAA59D"
    property string deepSubColor_1: "#A28E85"
    property string deepColor_0: "#91B2BE"
    property string deepColor_1: "#749DAD"
    property string deepColor_2: "#5B8899"
    property string deepColor_3: "#496E7C"
    property string deepColor_4: "#38555F"
    property string deepColor_5: "#273B42"

    Rectangle{
        id:main
        anchors.fill: parent
        color: mainColor
        Behavior on color {
            PropertyAnimation{
                duration: 150
            }
        }
        radius: 10
        border{
            color: deepColor_5
            Behavior on color {
                PropertyAnimation{
                    duration: 150
                }
            }
        }
        border.width: 2
        clip: true

        Rectangle{
            id:top
            width: parent.width
            height: 50
            color: deepColor_5
            Behavior on color {
                PropertyAnimation{
                    duration: 150
                }
            }
            topLeftRadius: 10
            topRightRadius: 10
            focus: true
            z: 999
            Rectangle{
                id: mainWindowElement
                color: "#00000000"
                width: parent.width
                height: parent.height
                opacity: 1
                Rectangle{
                    width: 30
                    height: 30
                    color: "#00000000"
                    anchors.verticalCenter: parent.verticalCenter
                    x:10
                    z:999
                    Icon{}
                }
                Text{
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 50
                    text: qsTr("StarFall Minecraft Launcher")
                    font.pixelSize: 18
                    font.family: "console"
                    color: "#f1f1f1"
                }
            }
            Text{
                id: subWindowTitle
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 50
                text: qsTr("")
                font.pixelSize: 18
                font.family: "console"
                color: "#f1f1f1"
                opacity: 0
            }
            MouseArea{
                anchors.fill: parent
                property point clickPos: "0,0"
                onPressed: {
                    clickPos = Qt.point(mouseX, mouseY)
                }
                onPositionChanged: {
                    var delta = Qt.point(mouseX-clickPos.x, mouseY-clickPos.y)
                    window.setX(window.x+delta.x)
                    window.setY(window.y+delta.y)
                }
            }
            CloseBtn{
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 10
            }
            MiniBtn{
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 50
            }
            TopBtn{
                id: topBtn
                width:200
                height: 50
            }
            DownloadingBtn{
                id: downloadBtn
                anchors.right: parent.right
                anchors.rightMargin: 100
                anchors.verticalCenter: parent.verticalCenter
                visible: false
                Behavior on opacity {
                    PropertyAnimation{
                        duration: 200
                    }
                }
                opacity: 0
                onOpacityChanged: {
                    if (downloadBtn.opacity <= 0){
                        downloadBtn.visible = false
                    }
                    else {
                        downloadBtn.visible = true
                    }
                }
            }

            Item{
                id: topProcess
                width: parent.width
                height: parent.height
                y: -50
                z: 999
                ThemeTopProcessTips{
                    id: processTips
                    width: 250
                    height: 50
                    anchors.horizontalCenter: parent.horizontalCenter
                    // onClicked: {
                    //     downloadInfo.opacity = 1
                    //     downloadInfo.width = 700
                    // }
                }
                // ThemeTopProcessTips{
                //     id: downloadInfo
                //     width: 0
                //     height: 50
                //     blockWidth: 300
                //     x: 50
                //     z: -999
                //     visible: false
                //     opacity: 0
                //     Behavior on width {
                //         PropertyAnimation{
                //             easing{
                //                 type: Easing.OutElastic
                //                 amplitude: 1
                //                 period: 1
                //             }
                //             duration: 200
                //         }
                //     }
                //     Behavior on opacity {
                //         PropertyAnimation{
                //             duration: 200
                //         }
                //     }

                //     onOpacityChanged: {
                //         if(downloadInfo.opacity <= 0.01){
                //             downloadInfo.z = -1
                //             downloadInfo.visible= false
                //         }
                //         else{
                //             downloadInfo.z = 1
                //             downloadInfo.visible= true
                //         }
                //     }
                //     Component.onCompleted: {
                //         downloadInfo.setIndeterminate(false)
                //         downloadInfo.setTips("- 暂无下载任务 -")
                //     }
                //     onClicked: {
                //         downloadInfo.opacity = 0
                //         downloadInfo.width = 0
                //     }
                // }
            }

            BackBtn{
                id: backBtn
                x: -50
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Rectangle{
            id:mainPage
            y: top.height
            width: window.width
            height: window.height-top.height
            bottomLeftRadius: 10
            bottomRightRadius: 10
            color:"transparent"
            Rectangle{
                id:leftCompBg
                width: mainPage.width/2-100
                height: mainPage.height-40
                color: "#fff"
                opacity: 0.6
                radius: 10
                x:20
                y:20
                Behavior on width{
                    animation: bounce
                }
            }

            Loader{
                id:mainPageLoader
                asynchronous: true
                x: 0
                source: "/view/Home.qml"
                onSourceChanged: {
                    changePgaeOpacity.start()
                }
                onOpacityChanged: {
                    if(mainPageLoader.opacity <= 0.01){
                        mainPageLoader.z = -999
                        mainPageLoader.x = parent.width
                    }
                    else{
                        mainPageLoader.z = 1
                        mainPageLoader.x = 0
                    }
                }

            }
            Loader{
                id:subPageLoader
                asynchronous: true
                source: ""
                opacity: 0
                z: -999
                x: parent.width
                onSourceChanged: {
                    subChangePgaeOpacity.start()
                }
                onLoaded: {
                    if(subPageLoader.source === "/view/Downloading.qml"){
                        subPageLoader.item.setRightInfo(launcherUtil.taskPercentStore,launcherUtil.taskTotalStore,launcherUtil.remainingTaskStore)
                    }
                }

                onOpacityChanged: {
                    if(subPageLoader.opacity <= 0.01){
                        subPageLoader.z = -999
                        subPageLoader.x = parent.width
                    }
                    else{
                        subPageLoader.z = 1
                        subPageLoader.x = 0
                    }
                }
            }
            GlobalTips{
                id: globalTips
            }

        }
        PlayerInfo{
            id: player
            signal clearInfo()
            onClearInfo: {
                onlineAccessToken = ""
                onlinePlayerUser = ""
                onlineUuid = ""
            }
        }
        LauncherUtil{
            id: launcherUtil
            property int taskPercentStore: 0
            property int taskTotalStore: 0
            property int remainingTaskStore: 0
            property var tasks: []
            property var tasksStatus: []

            signal copyText(var text)
            onDownloading: function(text){
                // downloadInfo.setTips(text)
                // finishDownload.stop()
                downloadBtn.opacity = 1
            }
            onDownloadFinished: function(text){
                // downloadInfo.setTips(text)
                // finishDownload.start()
                taskTotalStore = 0
                remainingTaskStore = 0
                downloadBtn.opacity = 0
            }
            onTopProcessTips: function(text){
                if(text === ""){
                    window.topProcessHide()
                }
                else{
                    window.topProcessShow()
                    processTips.setTips(text)
                }
            }
            onTouchGlobalTips: function(title,text){
                globalTips.show(title,text,"")
            }
            onTouchGlobalTipsLarger: function(title,text){
                globalTips.show(title,text,"larger")
            }
            onTouchGlobalTipsSmall: function(title,text){
                globalTips.show(title,text,"small")
            }
            onStartDownload: {
                tasks = []
                tasksStatus = []
            }

            onDownloadNumberStatus: function(taskTotal,remainingTask){
                if (remainingTask !== 0){
                    taskTotalStore = taskTotal
                    remainingTaskStore = remainingTask
                    taskPercentStore = (taskTotal-remainingTask)/taskTotal*100
                    if (subPageLoader.source == "/view/Downloading.qml"){
                        subPageLoader.item.setRightInfo(taskPercentStore,taskTotalStore,remainingTaskStore)
                    }
                    downloadBtn.opacity = 1
                }

            }
            onDownloadStatus: function(filename,status){
                if (subPageLoader.source == "/view/Downloading.qml"){
                    subPageLoader.item.setMainInfo(filename,status)
                }
            }
        }
        Timer{
            id:finishDownload
            interval: 5000
            onTriggered: {
                downloadInfo.setTips("- 暂无下载任务 -")
                window.topProcessHide()
            }
        }

        Connections{
            target: launcherUtil
            function onCopyText(text){
                launcherUtil.copyTextToClipboard(text)
            }
        }
        Launcher{
            id: launcher

            selectDir: ""
            selectVersion: ""
            autoMemory: true
            memoryMax: 2000
            username: ""
            uuid: ""
            token: ""
            autoJava: true
            isIsolate: false
            isFullscreen: false
            javaPath: ""
            jvmExtraPara: ""

            signal initLauncher()
            signal initJavaPath()
            signal initMemory()
            Component.onCompleted: {
                initLauncher()
                initJavaPath()
            }

            onInitLauncherSetting: {
                window.topProcessShow()
                processTips.setTips("正在加载Minecraft设置. . .")
            }
            onFixAssetsFile: {
                processTips.setTips("正在检查修补资源文件. . .")
            }
            onGetLib: {
                processTips.setTips("正在获取所需libraries文件. . .")
            }
            onFixNeedLibFile: {
                processTips.setTips("正在检查修补libraries文件. . .")
            }
            onReadyLaunch: {
                processTips.setTips("正在准备启动Minecraft. . .")

            }
            onStartLaunch: function(version){
                processTips.setTips("正在启动"+version+"中. . .")
                waitFinishProcessTips.start()
                mainPageLoader.item.finishLaunch()
            }
            onFinishLaunch: {
                window.topProcessHide()
                waitFinishProcessTips.stop()
            }
        }
        Timer{
            id:waitFinishProcessTips
            interval: 8000
            onTriggered: {
                window.topProcessHide()
                globalTips.show("游戏已启动，请等待窗口","若长时间未出现窗口，请重新启动","")
            }
        }

        Connections{
            target: launcher
            function onInitLauncher(){
                launcher.selectDir = launcherUtil.getCurrentPath()+"/.minecraft"
                dirList.push(launcher.selectDir)
                dirList.push("G:/Game/Minecraft/test/.minecraft")
                var list = launcherUtil.findVersion(launcher.selectDir)
                if(list.length !== 0){
                    launcher.selectVersion = list[0]
                }
            }
            function onInitJavaPath(){
                var sj = launcherUtil.getSuitableJava(launcher.selectDir, launcher.selectVersion)
                if(sj["name"] === ""){
                    launcher.javaPath = "java"
                }
                else{
                    launcher.javaPath = sj["javaPath"]
                }
            }
            function onInitMemory(){
                if(launcher.autoMemory){
                    launcher.memoryMax = launcherUtil.getMemory()["avalible"]*0.55
                }

            }
        }

    }


    PropertyAnimation{
        id:changePgaeOpacity
        target: mainPageLoader
        properties: "opacity"
        from: 0
        to: 1
        duration: 200
    }
    PropertyAnimation{
        id:subChangePgaeOpacity
        target: subPageLoader
        properties: "opacity"
        from: 0
        to: 1
        duration: 200
    }
    PropertyAnimation{
        id:bounce
        easing{
            type: Easing.OutElastic
            amplitude: 1
            period: 1
        }
        duration: 200
    }
    signal miniWindow()
    onMiniWindow: {
        showMinimized()
    }
    ParallelAnimation{
        id: subWindowShow
        PropertyAnimation{
            target: mainWindowElement
            properties: "opacity"
            to: 0
            duration: 200
        }
        PropertyAnimation{
            target: subWindowTitle
            properties: "opacity"
            to: 1
            duration: 200
        }
        PropertyAnimation{
            target: topBtn
            properties: "y"
            easing{
                type: Easing.OutElastic
                amplitude: 1
                period: 1
            }
            to: -50
            duration: 100
        }
        PropertyAnimation{
            target: backBtn
            properties: "opacity"
            to: 1
            duration: 200
        }
        PropertyAnimation{
            target: backBtn
            properties: "x"
            easing{
                type: Easing.OutElastic
                amplitude: 1
                period: 1
            }
            to: 10
            duration: 200
        }
        PropertyAnimation{
            target: mainPageLoader
            properties: "opacity"
            to: 0
            duration: 100
        }
        PropertyAnimation{
            target: subPageLoader
            properties: "opacity"
            to: 1
            duration: 200
        }
    }
    ParallelAnimation{
        id: subWindowHide
        PropertyAnimation{
            target: mainWindowElement
            properties: "opacity"
            to: 1
            duration: 200
        }
        PropertyAnimation{
            target: subWindowTitle
            properties: "opacity"
            to: 0
            duration: 200
        }
        PropertyAnimation{
            target: topBtn
            easing{
                type: Easing.OutElastic
                amplitude: 1
                period: 1
            }
            properties: "y"
            to: 0
            duration: 200
        }
        PropertyAnimation{
            target: backBtn
            properties: "opacity"
            to: 0
            duration: 200
        }
        PropertyAnimation{
            target: backBtn
            properties: "x"
            easing{
                type: Easing.OutElastic
                amplitude: 1
                period: 1
            }
            to: -50
            duration: 200
        }
        PropertyAnimation{
            target: mainPageLoader
            properties: "opacity"
            to: 1
            duration: 200
        }
        PropertyAnimation{
            target: subPageLoader
            properties: "opacity"
            to: 0
            duration: 100
        }
    }
    PropertyAnimation{
        id: topProcessShowAnimate
        target: topProcess
        easing{
            type: Easing.OutElastic
            amplitude: 1
            period: 1
        }
        properties: "y"
        to: 0
        duration: 200
    }
    PropertyAnimation{
        id: topProcessHideAnimate
        target: topProcess
        properties: "y"
        easing{
            type: Easing.InElastic
            amplitude: 1
            period: 0.5
        }
        to: -50
        duration: 100
    }
    function topProcessShow(){

        topProcessHideAnimate.stop()
        topProcessShowAnimate.start()
    }
    function topProcessHide(){
        processTips.setTips("")
        topProcessShowAnimate.stop()
        topProcessHideAnimate.start()
    }
    onCurrentColorNameChanged: {
        if(currentColorName === "grayBlue"){
            mainColor = "#AEC6CF"
            deepMainColor_0 = "#96ADB6"
            deepMainColor_1 = "#7E959E"
            deepMainColor_2 = "#687E86"
            subColor = "#D3BEB5"
            deepSubColor_0 = "#BAA59D"
            deepSubColor_1 = "#A28E85"
            deepColor_0 = "#91B2BE"
            deepColor_1 = "#749DAD"
            deepColor_2 = "#5B8899"
            deepColor_3 = "#496E7C"
            deepColor_4 = "#38555F"
            deepColor_5 = "#273B42"
        }
        else if(currentColorName === "chocolate"){
            mainColor = "#71625C"
            deepMainColor_0 = "#5B4D47"
            deepMainColor_1 = "#453833"
            deepMainColor_2 = "#312520"
            subColor = "#96ADB6"
            deepSubColor_0 = "#7E959E"
            deepSubColor_1 = "#687E86"
            deepColor_0 = "#B09386"
            deepColor_1 = "#9E7A6B"
            deepColor_2 = "#846456"
            deepColor_3 = "#694F44"
            deepColor_4 = "#4D3A32"
            deepColor_5 = "#312520"
        }

    }
}
