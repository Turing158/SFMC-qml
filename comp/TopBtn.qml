import QtQuick 6.2

Item {
    property int activeBtn: 0


    anchors.centerIn: parent
    Rectangle{
        id:topBtn
        width: 200
        height: 50
        color: "transparent"

        Rectangle{
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            width: 60
            height: 26
            color: "transparent"
            Rectangle{
                id:startBtnBg
                anchors.fill: parent
                color: "#D3BEB5"
                radius: width
                opacity: 1
            }
            Text {
                id:startBtnText
                anchors.centerIn: parent
                text: qsTr("启 动")
                font.pixelSize: 12
                color: "#273B42"
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    if(activeBtn !== 0){
                        startBtnHover()
                    }
                }
                onExited: {
                    if(activeBtn !== 0){
                        startBtnBack()
                    }
                }
                onClicked: {
                    startBtnActive()
                    activeBtn = 0
                    mainPageLoader.source = "/view/Home.qml"
                    leftCompBg.width = mainPage.width/2-100
                }
            }
        }
        Rectangle{
            anchors.verticalCenter: parent.verticalCenter
            anchors.centerIn: parent
            width: 60
            height: 26
            color: "transparent"
            radius: width
            Rectangle{
                id:downloadBtnBg
                anchors.fill: parent
                color: "#D3BEB5"
                radius: width
                opacity: 0
            }
            Text {
                id:downloadBtnText
                anchors.centerIn: parent
                text: qsTr("下 载")
                font.pixelSize: 12
                color: "#f1f1f1"
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    if(activeBtn !== 1){
                        downloadBtnHover()
                    }

                }
                onExited: {
                    if(activeBtn !== 1){
                        downloadBtnBack()
                    }
                }
                onClicked: {
                    downloadBtnActive()
                    activeBtn = 1
                    mainPageLoader.source = "/view/Download.qml"
                    leftCompBg.width = 150
                }
            }
        }
        Rectangle{
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            width: 60
            height: 26
            color: "transparent"
            radius: width
            Rectangle{
                id:settingBtnBg
                anchors.fill: parent
                color: "#D3BEB5"
                radius: width
                opacity: 0
            }
            Text {
                id:settingBtnText
                anchors.centerIn: parent
                text: qsTr("设 置")
                font.pixelSize: 12
                color: "#f1f1f1"
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    if(activeBtn !== 2){
                        settingBtnHover()
                    }
                }
                onExited: {
                    if(activeBtn !== 2){
                        settingBtnBack()
                    }
                }
                onClicked: {
                    settingBtnActive()
                    activeBtn = 2
                    mainPageLoader.source = "/view/Setting.qml"
                    leftCompBg.width = 150
                }
            }
        }



        PropertyAnimation{
            id: startBtnBgHover
            target: startBtnBg
            properties: "opacity"
            to: 0.3
            duration: 200
        }
        PropertyAnimation{
            id: downloadBtnBgHover
            target: downloadBtnBg
            properties: "opacity"
            to: 0.3
            duration: 200
        }
        PropertyAnimation{
            id: settingBtnBgHover
            target: settingBtnBg
            properties: "opacity"
            to: 0.3
            duration: 200
        }


        PropertyAnimation{
            id: startBtnBgBack
            target: startBtnBg
            properties: "opacity"
            to: 0
            duration: 200
        }
        PropertyAnimation{
            id: downloadBtnBgBack
            target: downloadBtnBg
            properties: "opacity"
            to: 0
            duration: 200
        }
        PropertyAnimation{
            id: settingBtnBgBack
            target: settingBtnBg
            properties: "opacity"
            to: 0
            duration: 200
        }




        PropertyAnimation{
            id: startBtnBgActive
            target: startBtnBg
            properties: "opacity"
            to: 1
            duration: 200
        }
        PropertyAnimation{
            id: downloadBtnBgActive
            target: downloadBtnBg
            properties: "opacity"
            to: 1
            duration: 200
        }
        PropertyAnimation{
            id: settingBtnBgActive
            target: settingBtnBg
            properties: "opacity"
            to: 1
            duration: 200
        }



        PropertyAnimation{
            id: startBtnTextActive
            target: startBtnText
            properties: "color"
            to: "#273B42"
            duration: 200
        }
        PropertyAnimation{
            id: downloadBtnTextActive
            target: downloadBtnText
            properties: "color"
            to: "#273B42"
            duration: 200
        }
        PropertyAnimation{
            id: settingBtnTextActive
            target: settingBtnText
            properties: "color"
            to: "#273B42"
            duration: 200
        }




        PropertyAnimation{
            id: startBtnTextNormal
            target: startBtnText
            properties: "color"
            to: "#f1f1f1"
            duration: 200
        }
        PropertyAnimation{
            id: downloadBtnTextNormal
            target: downloadBtnText
            properties: "color"
            to: "#f1f1f1"
            duration: 200
        }
        PropertyAnimation{
            id: settingBtnTextNormal
            target: settingBtnText
            properties: "color"
            to: "#f1f1f1"
            duration: 200
        }




    }
    function startBtnHover(){
        startBtnBgActive.stop()
        startBtnTextActive.stop()
        startBtnBgBack.stop()
        startBtnBgHover.start()
    }
    function downloadBtnHover(){
        downloadBtnBgActive.stop()
        downloadBtnTextActive.stop()
        downloadBtnBgBack.stop()
        downloadBtnBgHover.start()
    }

    function settingBtnHover(){
        settingBtnBgActive.stop()
        settingBtnTextActive.stop()
        settingBtnBgBack.stop()
        settingBtnBgHover.start()
    }






    function startBtnBack(){
        startBtnBgActive.stop()
        startBtnTextActive.stop()
        startBtnBgHover.stop()
        startBtnBgBack.start()
    }
    function downloadBtnBack(){
        downloadBtnBgActive.stop()
        downloadBtnTextActive.stop()
        downloadBtnBgHover.stop()
        downloadBtnBgBack.start()
    }

    function settingBtnBack(){
        settingBtnBgActive.stop()
        settingBtnTextActive.stop()
        settingBtnBgHover.stop()
        settingBtnBgBack.start()
    }






    function startBtnActive(){
        startBtnBgHover.stop()
        startBtnBgBack.stop()
        startBtnBgActive.start()
        startBtnTextActive.start()

        downloadBtnTextNormal.start()
        downloadBtnBgBack.start()
        settingBtnTextNormal.start()
        settingBtnBgBack.start()
    }
    function downloadBtnActive(){
        downloadBtnBgHover.stop()
        downloadBtnBgBack.stop()
        downloadBtnBgActive.start()
        downloadBtnTextActive.start()

        startBtnTextNormal.start()
        startBtnBgBack.start()
        settingBtnTextNormal.start()
        settingBtnBgBack.start()
    }
    function settingBtnActive(){
        settingBtnBgHover.stop()
        settingBtnBgBack.stop()
        settingBtnBgActive.start()
        settingBtnTextActive.start()

        startBtnTextNormal.start()
        startBtnBgBack.start()
        downloadBtnTextNormal.start()
        downloadBtnBgBack.start()
    }





}
