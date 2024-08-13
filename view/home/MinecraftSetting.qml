import QtQuick
import QtQuick.Controls
 import QtQuick.Dialogs
import "../../comp"
Item {
    property var javaVerions: []
    property int activeJavaVersionIndex: 0
    property string suitableJavaPaht: ""
    property int phyMemory: 0
    property int usingMemory: 0
    Flickable{
        id: minecraftSetting
        width: mainPage.width-leftComp.width-60
        height: mainPage.height-40
        contentHeight: content.height
        clip: true
        Column{
            id: content
            width: parent.width-80
            anchors.horizontalCenter: parent.horizontalCenter
            Item{height: 20;width: 1}
            ShadowRectangle{
                width: parent.width
                height: 80
                radius: 10
                Text{
                    x: 10
                    y: 10
                    text: qsTr("Java版本")
                }
                Loader{
                    id: selectJavaVersion
                    PropertyAnimation{
                        id: selectJavaVersionAnimation
                        target: parent
                        properties: "opacity"
                        from: 0
                        to: 1
                        duration: 200
                    }
                    onSourceComponentChanged: {
                        selectJavaVersionAnimation.stop()
                        selectJavaVersionAnimation.start()
                    }
                }
                Component{
                    id: selectJavaVersionComp
                    ComboBox{
                        id: selectJavaVersionComboBox
                        width: content.width-100
                        height: 30
                        x: 10
                        y: 35
                        textRole: "key"
                        font.pixelSize: 14
                        valueRole: "value"
                        currentIndex: activeJavaVersionIndex
                        enabled: javaVerions[0].value === "" ? false : true
                        model: javaVerions
                        delegate: ItemDelegate {
                            width: parent.width
                            height: 40
                            contentItem:Text{
                                anchors.verticalCenter: parent.verticalCenter
                                text: qsTr(modelData.key)
                                font.pixelSize: 14
                                color: index == currentIndex ? "#38555F" : "#131313"
                            }
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 35
                                text: qsTr(modelData.value)
                                color: "#666"
                            }
                            ThemeButton{
                                width: 20
                                height: 20
                                radius: 5
                                anchors.right: parent.right
                                anchors.rightMargin: 10
                                anchors.verticalCenter: parent.verticalCenter
                                text: qsTr("×")
                                fontSize: 15
                                onClicked: {
                                    minecraftSetting.deleteJavaVersion(index)
                                    globalTips.show("删除成功","java:"+modelData.key+"\npath:"+modelData.value,"")
                                }
                            }
                        }
                        background: Rectangle {
                            implicitWidth: 120
                            implicitHeight: 40
                            border.color: selectJavaVersionComboBox.pressed ? "#273B42" : "#496E7C"
                            border.width: 2
                            radius: 5
                            Behavior on border.color {
                                PropertyAnimation{
                                    duration: 200
                                }
                            }
                        }
                        onCurrentValueChanged: {
                            if(currentIndex == 0){
                                launcher.autoJava = true
                                launcher.javaPath = suitableJavaPaht
                            }
                            else{
                                launcher.autoJava = false
                                launcher.javaPath = currentValue
                            }
                        }
                    }
                }
                FileDialog{
                    id: addJavaPathFile
                    title: "选择安装的java目录下bin里的Javaw.exe或java.exe"
                    nameFilters: ["Executable Files (javaw.exe;java.exe)"]
                    onAccepted:{
                        if(currentFolder !== ""){
                            var str = currentFolder.toString().substring(8).split("/")
                            var fielDirName = str[str.length-2]
                            var fileDir = ""
                            str.pop()
                            for(var i=0;i<str.length;i++){
                                fileDir+=str[i]
                                if(str.length-1 !== i){
                                    fileDir+="\\"
                                }
                            }
                            var noExist = true
                            for(var j in javaVerions){
                                if(javaVerions[j].value === fileDir){
                                    noExist = false
                                    break;
                                }
                            }
                            if(noExist){
                                javaVerions.push({key:fielDirName,value:fileDir})
                                selectJavaVersion.sourceComponent = null
                                selectJavaVersion.sourceComponent = selectJavaVersionComp
                                globalTips.show("添加成功","java:"+fielDirName+"\npath:"+fileDir,"")
                            }
                            else{
                                globalTips.show("","此java路径已存在","")
                            }
                        }
                        else{
                            console.log("取消选择文件")
                        }
                    }
                }
                ThemeButton{
                    id: addJavaPath
                    width: 28
                    height: 28
                    x: parent.width-89
                    y: 36
                    text: "+"
                    fontSize: 20
                    onClicked: {
                        addJavaPathFile.open()
                    }
                }
                ThemeButton{
                    id: reloadJavaPath
                    width: 28
                    height: 28
                    anchors.left: addJavaPath.right
                    anchors.leftMargin: 1
                    anchors.top: addJavaPath.top
                    text: "↺"
                    fontSize: 20
                    onClicked: {
                        minecraftSetting.findAllJavaVersion()
                        globalTips.show("成功刷新java列表","java列表已重置并刷新","")
                    }
                }
            }
            Item{height: 20;width: 1}
            ShadowRectangle{
                id: settingMemory
                width: parent.width
                height: 100
                radius: 10
                Text{
                    x: 10
                    y: 10
                    text: qsTr("分配内存")
                }
                Item{
                    width: 200
                    x: 80
                    y: 30
                    ThemeRadio{
                        anchors.left: parent.left
                        text: qsTr("自动")
                        height: 15
                        checked: true
                        onCheckedChanged: {
                            if(checked){
                                launcher.autoMemory = true
                                minecraftSetting.initMemory()
                            }
                        }
                    }
                    ThemeRadio{
                        anchors.right: parent.right
                        text: qsTr("手动")
                        height: 15
                        onCheckedChanged: {
                            if(checked){
                                launcher.autoMemory = false
                                minecraftSetting.initMemory()
                            }
                        }
                    }
                }
                Image{
                    id:bottle
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    height: 90
                    width: 90
                    smooth: false
                    source: "/img/bottle.png"
                    clip: true
                    Rectangle{
                        id: workMemory
                        anchors.top: parent.bottom
                        // anchors.topMargin: -6.9//默认为0时
                        // anchors.topMargin: -18
                        anchors{
                            Behavior on topMargin {
                                PropertyAnimation{
                                    easing.type: "OutElastic"
                                    easing.amplitude: 1
                                    easing.period: 0.5
                                    duration: 1000
                                }
                            }
                        }
                        width: parent.width
                        height: parent.height
                        z: -1
                        color: "darkred"
                    }
                    Rectangle{
                        id: useMemory
                        anchors.top: workMemory.top
                        anchors{
                            Behavior on topMargin {
                                PropertyAnimation{
                                    easing.type: "OutElastic"
                                    easing.amplitude: 1
                                    easing.period: 0.5
                                    duration: 1000
                                }
                            }
                        }
                        width: parent.width
                        height: parent.height
                        z: -2
                        color: "darkgreen"
                    }
                    ThemeToolTip{
                        id: memoryInfo
                        visible: true
                        x: 0
                        y: -2
                        width: parent.width
                        height: parent.height+4
                        text: qsTr("空闲\n0000 MB\n已使用\n0000MB\n总可用内存\n000000 MB")
                        z: 0
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                memoryInfo.z = 0
                                memoryInfo.hide()
                            }
                        }
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            memoryInfo.z = 1
                            memoryInfo.show()
                        }
                    }
                }
                ThemeSlider{
                    id: setMemory
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 15
                    width: parent.width-120
                    height: 10
                    x: 10
                    from: 2
                    to: 100
                    value: launcher.memoryMax/phyMemory*100
                    onValueChanged: {
                        setMemoryTip.show()
                        currentMemory.text = qsTr("分配:"+(setMemory.value/100*phyMemory).toFixed(0)+" MB")
                        hideTip.stop()
                        hideTip.start()
                        useMemory.anchors.topMargin = -bottle.height/13*9*(value/100)
                    }
                    ThemeToolTip{
                        id: setMemoryTip
                        parent: setMemory.handle
                        y: -30
                        text: qsTr((setMemory.value/100*phyMemory).toFixed(0)+" MB")
                        Timer{
                            id: hideTip
                            interval: 1000
                            onTriggered: {
                                setMemoryTip.hide()
                            }
                        }
                    }
                }
                Text{
                    id: minMemory
                    anchors.left: setMemory.left
                    anchors.bottom: setMemory.top
                    anchors.bottomMargin: 10
                    text: qsTr("最小内存：")
                }
                Text{
                    id: currentMemory
                    anchors.right: setMemory.right
                    anchors.bottom: setMemory.top
                    anchors.bottomMargin: 10
                    text: qsTr("分配:0 MB")
                }
            }
            Item{height: 20;width:1}
            Row{
                width: parent.width
                height: 80
                ShadowRectangle{
                    width: parent.width/2-10
                    height: 80
                    radius: 10
                    Text{
                        x: 10
                        y: 10
                        text: qsTr("版本隔离")
                    }
                    Item{
                        y: 10
                        width: parent.width-100
                        height: 20
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        ThemeRadio{
                            id: noIsoChoice
                            height: 15
                            text: qsTr("无")
                            font.pixelSize: 12
                            checked: !launcher.isIsolate
                            onCheckedChanged: {
                                isoText.opacity = 0
                                noIsoText.opacity = 1
                                launcher.isIsolate = false
                            }
                        }
                        ThemeRadio{
                            id: isoChoice
                            anchors.left: noIsoChoice.right
                            anchors.leftMargin: 50
                            height: 15
                            text: qsTr("版本隔离")
                            font.pixelSize: 12
                            checked: launcher.isIsolate
                            onCheckedChanged: {
                                noIsoText.opacity = 0
                                isoText.opacity = 1
                                launcher.isIsolate = true
                            }
                        }
                    }
                    Item{
                        width: parent.width-20
                        height: parent.height-40
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10
                        x: 10
                        Text{
                            id: noIsoText
                            width: parent.width
                            text: qsTr("不使用版本隔离：即将模组文件夹地图文件夹等资源文件放在一起，不同版本之间都可以加载访问")
                            wrapMode: Text.Wrap
                            color: "#666"
                            opacity: 1
                            Behavior on opacity {
                                PropertyAnimation{
                                    duration: 200
                                }
                            }
                        }
                        Text{
                            id: isoText
                            width: parent.width
                            text: qsTr("使用版本隔离：即将模组文件夹地图文件夹等资源文件分开来存放，一般存放在\n\"/.minecraft/versions/版本名称\"")
                            wrapMode: Text.Wrap
                            color: "#666"
                            opacity: 0
                            Behavior on opacity {
                                PropertyAnimation{
                                    duration: 200
                                }
                            }
                        }
                    }
                }
                Item{width: 20;height: 1}
                ShadowRectangle{
                    width: parent.width/2-10
                    height: 80
                    radius: 10
                    Text{
                        x: 10
                        y: 10
                        text: qsTr("游戏窗口")
                    }
                    Item{
                        x: 35
                        y: 35
                        height: 30
                        ThemeTextInput{
                            id: settingWidth
                            width: 60
                            height: 30
                            text: qsTr(""+launcher.width)
                            horizontalAlignment: "AlignHCenter"
                            validator: IntValidator{ bottom: 1;top: 99999}
                            onTextChanged: {
                                launcher.width = text
                                if(text === "" || text === "0"){
                                    text = "1"
                                }
                            }
                        }
                        Text{
                            anchors.left: settingWidth.right
                            anchors.leftMargin: 5
                            text: qsTr("x")
                            font.pixelSize: 18
                        }
                        ThemeTextInput{
                            id: settingHeight
                            anchors.left: settingWidth.right
                            anchors.leftMargin: 20
                            width: 60
                            height: 30
                            text: qsTr(""+launcher.height)
                            horizontalAlignment: "AlignHCenter"
                            validator: IntValidator{ bottom: 1;top: 99999}
                            onTextChanged: {
                                if(text === "" || text === "0"){
                                    text = "1"
                                }
                                launcher.height = text
                            }
                        }
                        ThemeCheckBox{
                            id: settingFullscreen
                            anchors.left: settingHeight.right
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.leftMargin: 5
                            checked: launcher.isFullscreen
                            height: 20
                            width: 20
                            text: qsTr("全屏")
                            onCheckedChanged: {
                                launcher.isFullscreen = checked
                                if(checked){
                                    settingWidth.enabled = false
                                    settingHeight.enabled = false
                                }
                                else{
                                    settingWidth.enabled = true
                                    settingHeight.enabled = true
                                }
                            }
                        }
                    }
                    ThemeButton{
                        height: 25
                        width: 25
                        y: 5
                        anchors.right: parent.right
                        anchors.rightMargin: 5
                        text: qsTr("↺")
                        fontSize: 18
                        onClicked: {
                            settingWidth.text = "854"
                            settingHeight.text = "480"
                            settingFullscreen.checked = false
                            settingFullscreen.reloadAnimation()
                        }
                    }
                }
            }
            Item{height: 20;width: 1}
            ShadowRectangle{
                width: parent.width
                height: 150
                radius: 10
                Text{
                    x: 10
                    y: 10
                    text: qsTr("jvm额外参数")
                }

                ThemeTextArea{
                    x: 10
                    width: parent.width-20
                    height: parent.height-40
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    text: launcher.jvmExtraPara
                    onTextChanged: {
                        launcher.jvmExtraPara = text
                    }
                }
            }
            Item{height: 20;width: 1}
        }
        signal initMemory()
        signal findAllJavaVersion()
        signal deleteJavaVersion(var index)
        Component.onCompleted: {
            findAllJavaVersion()
            selectJavaVersion.sourceComponent = selectJavaVersionComp
            initMemory()
        }

    }
    Connections{
        target: minecraftSetting
        function onFindAllJavaVersion(){
            selectJavaVersion.sourceComponent = null
            var list = []
            javaVerions = []
            var map = launcherUtil.findAllJavaVersion()
            var tmpIndex = 0
            for(var i in map){
                tmpIndex++
                list.push({key:map[i],value:i})
                if(i === launcher.javaPath && !launcher.autoJava){
                    activeJavaVersionIndex = tmpIndex
                }
            }
            if(list.length === 0){
                javaVerions.push({key:"未找到java版本，请自行添加",value:""})
            }
            else{
                var sj = launcherUtil.getSuitableJava(launcher.selectDir, launcher.selectVersion)
                if(sj["name"] === ""){
                    javaVerions.push({key:"未找到适合的java版本",value:"无"})
                    suitableJavaPaht  = "java"
                }
                else{
                    javaVerions.push({key:"自动选择合适的java",value:sj["name"]})
                    suitableJavaPaht = sj["javaPath"]
                }
                javaVerions = javaVerions.concat(list)
            }
            selectJavaVersion.sourceComponent = selectJavaVersionComp
        }
        function onInitMemory(){
            var map = launcherUtil.getMemory()
            usingMemory = map["using"]
            phyMemory = map["total"]
            var avalibleMemory = map["avalible"]
            var bottleMax = bottle.height/13*9
            var usingPer = usingMemory/phyMemory
            setMemory.enabled = true
            if(launcher.autoMemory){
                launcher.memoryMax = avalibleMemory*0.55
                setMemory.enabled = false
            }
            setMemory.to = 100-usingPer*100
            setMemory.value = launcher.memoryMax/phyMemory*100
            workMemory.anchors.topMargin = -bottle.height/13-usingPer*bottleMax
            if(avalibleMemory < launcher.memoryMax){
                launcher.memoryMax = avalibleMemory
            }

            if(launcher.memoryMax <= 0.02*phyMemory){
                useMemory.anchors.topMargin = -0.02*bottleMax
            }
            else{
                useMemory.anchors.topMargin = -launcher.memoryMax/phyMemory*bottleMax
            }
            minMemory.text = qsTr((""+(0.02*phyMemory)).split(".")[0]+" MB")
            memoryInfo.text = qsTr("空闲\n"+avalibleMemory+" MB\n已使用\n"+usingMemory+" MB\n总可用内存\n"+phyMemory+" MB")
            memoryInfo.visible = false
        }
        function onDeleteJavaVersion(index){
            javaVerions.splice(index,1)
            selectJavaVersion.sourceComponent = null
            selectJavaVersion.sourceComponent = selectJavaVersionComp
        }
    }

}

