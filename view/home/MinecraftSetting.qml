import QtQuick
import QtQuick.Controls
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
                }
                Component{
                    id: selectJavaVersionComp
                    ComboBox{
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
                                anchors.rightMargin: 15
                                text: qsTr(modelData.value)
                                color: "#666"
                            }
                        }
                        onCurrentValueChanged: {
                            if(currentIndex == 0){
                                launcher.autoJava = 1
                                launcher.javaPath = suitableJavaPaht
                            }
                            else{
                                launcher.autoJava = 0
                                launcher.javaPath = currentValue
                            }
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
                                launcher.autoMemory = 1
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
                                launcher.autoMemory = 0
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
        }
        signal initMemory()
        signal findAllJavaVersion()
        Component.onCompleted: {
            findAllJavaVersion()
            selectJavaVersion.sourceComponent = selectJavaVersionComp
            initMemory()
        }
    }
    Connections{
        target: minecraftSetting
        function onFindAllJavaVersion(){
            var list = []
            javaVerions = []
            var map = launcherUtil.findAllJavaVersion()
            var tmpIndex = 0
            for(var i in map){
                tmpIndex++
                list.push({key:map[i],value:i})
                if(i === launcher.javaPath && launcher.autoJava !== 1){
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
        }
        function onInitMemory(){
            var map = launcherUtil.getMemory()
            usingMemory = map["using"]
            phyMemory = map["total"]
            var avalibleMemory = map["avalible"]
            var bottleMax = bottle.height/13*9
            var usingPer = usingMemory/phyMemory
            setMemory.enabled = true
            if(launcher.autoMemory === 1){
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
    }

}

