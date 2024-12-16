import QtQuick 2.15

Item {

    width: mainPage.width-20
    height: mainPage.height-40
    Item{
        width: 160
        height: mainPage.height-40
        anchors.right: parent.right
        y: 20
        Rectangle{
            id: rightBg
            anchors.fill: parent
            color: "#fff"
            opacity: 0.6
            radius: 10
            border.color: window.deepColor_4
            border.width: 2
            Item{
                id: process
                width: parent.width
                height: 0
                Behavior on height {
                    PropertyAnimation{
                        easing.type: "OutElastic"
                        easing.amplitude: 1
                        easing.period: 0.5
                        duration: 1000
                    }
                }

                clip: true
                anchors.bottom: parent.bottom
                anchors.bottomMargin: rightBg.border.width
                Rectangle{
                    width: rightBg.width-(rightBg.border.width*2)
                    height: rightBg.height-(rightBg.border.width*2)
                    color: window.deepColor_0
                    radius: 10-rightBg.border.width
                    anchors.bottom: parent.bottom
                    x: rightBg.border.width
                    opacity: 0.8
                }
            }
        }
        Text{
            id: remainingTaskText
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("0")
            anchors.top: parent.top
            anchors.topMargin: 50
            color: window.deepColor_5
            font.bold: true
            font.pixelSize: 17
        }
        Rectangle{
            id: line
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: remainingTaskText.bottom
            anchors.bottomMargin: -5
            width: parent.width-60
            height: 2
            radius: 2
            color: window.deepColor_5
        }
        Text{
            id: totalTaskText
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("0")
            anchors.top: line.top
            anchors.topMargin: 5
            color: window.deepColor_5
            font.bold: true
            font.pixelSize: 17
        }

        Text{
            id: processText
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("0%")
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 50
            color: window.deepColor_5
            font.bold: true
            font.pixelSize: 20
        }
    }
    Item{
        x: 20
        y: 20
        width :mainPage.width/2+200
        height: mainPage.height-40
        clip: true
        ListView{
            id: infoView
            y: 10
            x: 10
            width :mainPage.width/2+200-20
            height: mainPage.height-40-10
            model: launcherUtil.tasks
            delegate:Item{
                width: mainPage.width/2+200
                height: 35
                Item{
                    id: status
                    width: 60
                    height: 30
                    anchors.verticalCenter: parent.verticalCenter
                    Rectangle{
                        id: label
                        anchors.centerIn: parent
                        width: 40
                        height: 22.5
                        color: "#EB7C79"
                        radius: 5
                        border{
                            color: window.deepColor_5
                            width: 1
                        }
                        Text{
                            id: labelText
                            anchors.centerIn: parent
                            text: qsTr( "错误")
                            font.pixelSize: 11
                        }
                    }
                    Component.onCompleted: {
                        var status = launcherUtil.tasksStatus[launcherUtil.tasks.length-1-index]
                        if (status === "success"){
                            labelText.text = qsTr("完成")
                            label.color = "#3EB489"
                        }else if (status === "downloading"){
                            labelText.text = qsTr("下载")
                            label.color = "#89CFF0"
                        }else{
                            labelText.text = qsTr("错误")
                            label.color = "#EB7C79"
                        }
                    }
                }
                Text{
                    width: parent.width-status.width-30
                    height: 18
                    anchors.left: status.right
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr(modelData)
                    font.pixelSize: 15
                    elide: Text.ElideRight
                }
            }
        }
    }

    function setRightInfo(percent,total,remaining){
        var percentStr = ""+percent
        var percentInt = percentStr.split(".")[0]
        process.height = percent/100*(rightBg.height-2)
        processText.text = qsTr(percentInt+"%")
        totalTaskText.text = qsTr(""+total)
        remainingTaskText.text = qsTr(""+remaining)
    }

    function setMainInfo(filename,status){
        var index = launcherUtil.tasks.indexOf(filename)
        launcherUtil.tasks.push(filename)
        launcherUtil.tasksStatus.push(status)
        var tmpTasks = launcherUtil.tasks
        tmpTasks.reverse()
        infoView.model = tmpTasks
    }
}


