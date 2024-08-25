import QtQuick 6.2
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
Item {
    property int online: window.isOnline
    property int onlineBg: window.isOnline
    property int isLogining: 0
    property int isLogined: player.onlinePlayerUser.length ? 1 : 0

    anchors.horizontalCenter: parent.horizontalCenter
    y: 15
    Rectangle {
        width: leftComp.width
        height: 200
        color:"transparent"
        Rectangle {
            width: 180
            height: 30
            color: "transparent"
            anchors.horizontalCenter: parent.horizontalCenter
            Rectangle{
                id:onlineBtn
                width: 70
                height: 25
                color: onlineBg===0 ? "transparent" : "#273B42"
                radius: width
                Text {
                    id:onlineBtnText
                    anchors.centerIn: parent
                    text: qsTr("🔗 正 版")
                    font.pixelSize: 12
                    color: onlineBg===0 ? "273B42" : "#D3BEB5"
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        if(online === 0){
                            onlineBtnHoveredFunc()
                        }
                    }
                    onExited: {
                        if(online === 0){
                            onlineBtnBackFunc()
                        }
                    }
                    onClicked: {
                        outlineBtnBackFunc()
                        onlineBtnHoveredFunc()
                        onlineChange0.stop()
                        onlineChange1.stop()
                        onlineChange1.start()
                        window.isOnline = 1
                        if(isLogining === 1){
                            playerInfoLoader.sourceComponent = logining
                        }
                        else{
                            if(isLogined === 1){
                                playerInfoLoader.sourceComponent = logined
                            }
                            else{
                                playerInfoLoader.sourceComponent = noLogin
                            }
                        }
                        launcher.username = player.onlinePlayerUser
                    }
                }
            }
            Rectangle{
                id: outlineBtn
                anchors.right: parent.right
                width: 70
                height: 25
                color: onlineBg===1 ? "transparent" : "#273B42"
                radius: width
                Text {
                    id:outlineBtnText
                    anchors.centerIn: parent
                    text: qsTr("🖇️ 离 线")
                    font.pixelSize: 12
                    color:onlineBg===1 ? "#273B42" : "#D3BEB5"
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        if(online === 1){
                            outlineBtnHoveredFunc()
                        }
                    }
                    onExited: {
                        if(online === 1){
                            outlineBtnBackFunc()
                        }

                    }
                    onClicked: {
                        onlineBtnBackFunc()
                        outlineBtnHoveredFunc()
                        window.isOnline = 0
                        launcher.username = player.outlinePlayerUser
                        launcher.uuid = qsTr(""+launcherUtil.generateUUID())
                        onlineChange1.stop()
                        onlineChange0.stop()
                        onlineChange0.start()
                        playerInfoLoader.sourceComponent = outlineUser
                    }

                }
            }
            Timer{
                id:onlineChange0
                interval: 200
                onTriggered: {
                    onlineBg = 0
                }
            }
            Timer{
                id:onlineChange1
                interval: 200
                onTriggered: {
                    onlineBg = 1
                }
            }
        }
        Rectangle{
            id:playerInfo
            y:60
            width: parent.width
            height: 140
            color: "transparent"
            Loader{
                id:playerInfoLoader
                asynchronous: true
                sourceComponent: online===0 ? outlineUser : isLogined === 0 ? noLogin : logined
                onSourceComponentChanged: {
                    changeLoader.stop()
                    changeLoader.start()
                }
            }
        }


    }
    Component{
        id:noLogin
        MouseArea{
            width: playerInfo.width
            height: playerInfo.height
            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                width: 60
                height: 60
                smooth: false
                source: "/img/steve.png"
                DropShadow{
                    source: parent
                    anchors.fill: parent
                    radius:5
                    samples: 11
                    color: "#aa000000"
                    z: -1
                }
            }

            Rectangle{
                id:loginBtn
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                width: 100
                height: 30
                radius: 5
                border.color: "#749DAD"
                color: "#AEC6CF"
                opacity: 0
                Text {
                    anchors.centerIn: parent
                    id: loginBtnText
                    text: qsTr("登    录")
                    font.pixelSize: 15
                    color: "#273B42"
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        playerInfoLoader.sourceComponent = logining
                        isLogining = 1
                    }
                    onEntered: {
                        noLoginBtnColorBack.stop()
                        noLoginBtnTextColorBack.stop()
                        noLoginBtnColorHovered.start()
                        noLoginBtnTextColorHovered.start()
                    }
                    onExited: {
                        noLoginBtnColorHovered.stop()
                        noLoginBtnTextColorHovered.stop()
                        noLoginBtnColorBack.start()
                        noLoginBtnTextColorBack.start()
                    }
                }
            }
            hoverEnabled: true
            onEntered: {
                noLoginBtnHide.stop()
                noLoginBtnShow.start()
            }
            onExited: {
                noLoginBtnShow.stop()
                noLoginBtnHide.start()
            }
            PropertyAnimation{
                id:noLoginBtnShow
                target: loginBtn
                properties: "opacity"
                to: 1
                duration: 200
            }
            PropertyAnimation{
                id:noLoginBtnHide
                target: loginBtn
                properties: "opacity"
                to: 0
                duration: 200
            }

            //未登录按钮颜色hover
            PropertyAnimation{
                id:noLoginBtnColorHovered
                target: loginBtn
                properties: "color"
                to: "#749DAD"
                duration: 200
            }
            //未登录按钮字体
            PropertyAnimation{
                id:noLoginBtnColorBack
                target: loginBtn
                properties: "color"
                to: "#AEC6CF"
                duration: 200
            }
            //未登录按钮字体颜色hover
            PropertyAnimation{
                id:noLoginBtnTextColorHovered
                target: loginBtnText
                properties: "color"
                to: "#f1f1f1"
                duration: 200
            }
            //未登录按钮字体颜色
            PropertyAnimation{
                id:noLoginBtnTextColorBack
                target: loginBtnText
                properties: "color"
                to: "#273B42"
                duration: 200
            }
        }
    }

    Component{
        id:logined
        Rectangle{
            width: playerInfo.width
            height: playerInfo.height
            color: "transparent"
            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                id: avatar
                width: 60
                height: 60
                smooth: false
                source: "/img/steve.png"
                DropShadow{
                    source: parent
                    anchors.fill: parent
                    radius:5
                    samples: 11
                    color: "#aa000000"
                    z: -1
                }
            }
            Text{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 45
                text: qsTr("Turing_ICE")
                font.pixelSize: 20
                font.family: "console"
            }
            MouseArea{
                id: operateBtn
                width: parent.width
                height: parent.height
                anchors.bottom: parent.bottom
                opacity: 0
                Rectangle{
                    id:settingInfo
                    anchors.left: parent.left
                    anchors.leftMargin: 80
                    anchors.bottom: parent.bottom
                    width: (parent.width-200)/2
                    height: 30
                    radius: 5
                    border.color: "#749DAD"
                    color: "#AEC6CF"
                    Text {
                        anchors.centerIn: parent
                        id: settingInfoText
                        text: qsTr("修改档案")
                        font.pixelSize: 15
                        color: "#273B42"
                    }
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            settingInfoColorBack.stop()
                            settingInfoTextColorBack.stop()
                            settingInfoColorHovered.start()
                            settingInfoTextColorHovered.start()
                        }
                        onExited: {
                            settingInfoColorHovered.stop()
                            settingInfoTextColorHovered.stop()
                            settingInfoColorBack.start()
                            settingInfoTextColorBack.start()
                        }
                    }
                }
                Rectangle{
                    id:reLogin
                    anchors.right: parent.right
                    anchors.rightMargin: 80
                    anchors.bottom: parent.bottom
                    width: (parent.width-200)/2
                    height: 30
                    radius: 5
                    border.color: "#749DAD"
                    color: "#AEC6CF"
                    Text {
                        anchors.centerIn: parent
                        id: reLoginText
                        text: qsTr("重新登录")
                        font.pixelSize: 15
                        color: "#273B42"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            playerInfoLoader.sourceComponent = logining
                            isLogining = 1
                        }
                        hoverEnabled: true
                        onEntered: {
                            reLoginColoBack.stop()
                            reLoginTextColorBack.stop()
                            reLoginColorHovered.start()
                            reLoginTextColorHovered.start()
                        }
                        onExited: {
                            reLoginColorHovered.stop()
                            reLoginTextColorHovered.stop()
                            reLoginColoBack.start()
                            reLoginTextColorBack.start()
                        }
                    }
                }
                hoverEnabled: true
                onEntered: {
                    operateBtnBack.stop()
                    operateBtnHovered.start()
                }
                onExited: {
                    operateBtnHovered.stop()
                    operateBtnBack.start()
                }
            }

            PropertyAnimation{
                id:settingInfoColorHovered
                target: settingInfo
                properties: "color"
                to: "#749DAD"
                duration: 200
            }
            PropertyAnimation{
                id:settingInfoTextColorHovered
                target: settingInfoText
                properties: "color"
                to: "#f1f1f1"
                duration: 200
            }
            PropertyAnimation{
                id:settingInfoColorBack
                target: settingInfo
                properties: "color"
                to: "#AEC6CF"
                duration: 200
            }
            PropertyAnimation{
                id:settingInfoTextColorBack
                target: settingInfoText
                properties: "color"
                to: "#273B42"
                duration: 200
            }



            PropertyAnimation{
                id:reLoginColorHovered
                target: reLogin
                properties: "color"
                to: "#749DAD"
                duration: 200
            }
            PropertyAnimation{
                id:reLoginTextColorHovered
                target: reLoginText
                properties: "color"
                to: "#f1f1f1"
                duration: 200
            }
            PropertyAnimation{
                id:reLoginColoBack
                target: reLogin
                properties: "color"
                to: "#AEC6CF"
                duration: 200
            }
            PropertyAnimation{
                id:reLoginTextColorBack
                target: reLoginText
                properties: "color"
                to: "#273B42"
                duration: 200
            }

            PropertyAnimation{
                id:operateBtnHovered
                target:operateBtn
                properties: "opacity"
                to: 1
                duration: 200
            }
            PropertyAnimation{
                id:operateBtnBack
                target:operateBtn
                properties: "opacity"
                to: 0
                duration: 200
            }
        }
    }


    Component{
        id:logining
        Rectangle{
            width: playerInfo.width
            height: playerInfo.height
            color: playerInfo.color
            Rectangle{
                width: parent.width-100
                height: 150
                anchors.horizontalCenter: parent.horizontalCenter
                color: "transparent"
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("已自动为您打开浏览器，并复制以下代码至剪切板")
                    font.pixelSize: 12
                }
                Text {
                    y:16
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("请根据浏览器内提示进行操作")
                    font.pixelSize: 12
                }
                Text {
                    y:32
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("A1B2C3D4")
                    font.pixelSize: 25
                    font.family: "console"
                    color: "#273B42"
                }
                Text {
                    y:60
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("若未打开浏览器，点击复制链接")
                    font.pixelSize: 12
                }
                Text {
                    y:75
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("然后自行打开浏览器，点击代码可以复制代码")
                    font.pixelSize: 12
                }
            }
            Rectangle{
                id:copyLink
                anchors.left: parent.left
                anchors.leftMargin: 80
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                width: (parent.width-200)/2
                height: 30
                radius: 5
                border.color: "#749DAD"
                color: "#AEC6CF"
                Text {
                    anchors.centerIn: parent
                    id: copyLinkText
                    text: qsTr("复制链接")
                    font.pixelSize: 15
                    color: "#273B42"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        // 复制链接



                        // 临时认证完成
                        isLogined = 1
                        isLogining = 0
                        playerInfoLoader.sourceComponent = logined
                    }
                    hoverEnabled: true
                    onEntered: {
                        copyLinkColorBack.stop()
                        copyLinkTextColorBack.stop()
                        copyLinkColorHovered.start()
                        copyLinkTextColorHovered.start()
                    }
                    onExited: {
                        copyLinkColorHovered.stop()
                        copyLinkTextColorHovered.stop()
                        copyLinkColorBack.start()
                        copyLinkTextColorBack.start()
                    }
                }
            }
            Rectangle{
                id:back
                anchors.right: parent.right
                anchors.rightMargin: 80
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                width: (parent.width-200)/2
                height: 30
                radius: 5
                border.color: "#749DAD"
                color: "#AEC6CF"
                Text {
                    anchors.centerIn: parent
                    id: backText
                    text: qsTr("返   回")
                    font.pixelSize: 15
                    color: "#273B42"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        isLogining = 0
                        if(isLogined === 1){
                            playerInfoLoader.sourceComponent = logined
                        }
                        else{
                            playerInfoLoader.sourceComponent = noLogin
                        }
                    }
                    hoverEnabled: true
                    onEntered: {
                        backColoBack.stop()
                        backTextColorBack.stop()
                        backColorHovered.start()
                        backTextColorHovered.start()
                    }
                    onExited: {
                        backColorHovered.stop()
                        backTextColorHovered.stop()
                        backColoBack.start()
                        backTextColorBack.start()
                    }
                }
            }



            PropertyAnimation{
                id:copyLinkColorHovered
                target: copyLink
                properties: "color"
                to: "#749DAD"
                duration: 200
            }
            PropertyAnimation{
                id:copyLinkTextColorHovered
                target: copyLinkText
                properties: "color"
                to: "#f1f1f1"
                duration: 200
            }
            PropertyAnimation{
                id:copyLinkColorBack
                target: copyLink
                properties: "color"
                to: "#AEC6CF"
                duration: 200
            }
            PropertyAnimation{
                id:copyLinkTextColorBack
                target: copyLinkText
                properties: "color"
                to: "#273B42"
                duration: 200
            }



            PropertyAnimation{
                id:backColorHovered
                target: back
                properties: "color"
                to: "#749DAD"
                duration: 200
            }
            PropertyAnimation{
                id:backTextColorHovered
                target: backText
                properties: "color"
                to: "#f1f1f1"
                duration: 200
            }
            PropertyAnimation{
                id:backColoBack
                target: back
                properties: "color"
                to: "#AEC6CF"
                duration: 200
            }
            PropertyAnimation{
                id:backTextColorBack
                target: backText
                properties: "color"
                to: "#273B42"
                duration: 200
            }

        }
    }




    Component{
        id:outlineUser
        Rectangle{
            width: playerInfo.width
            height: playerInfo.height
            color: playerInfo.color
            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                id: avatar
                width: 60
                height: 60
                smooth: false
                source: "/img/steve.png"
                DropShadow{
                    anchors.fill: parent
                    source: parent
                    radius:5
                    samples: 11
                    color: "#aa000000"
                    z: -1
                }
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    outlineInputShow.stop()
                    outlineInputHide.start()
                    if(outlineInputInput.focus === true){
                        player.outlinePlayerUser = outlineInputInput.text
                        launcher.username = outlineInputInput.text
                        launcher.uuid = qsTr(""+launcherUtil.generateUUID())
                    }
                    outlineInputInput.focus = false
                }
            }
            Rectangle{
                width: parent.width-100
                height: 35
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                color: "transparent"
                Text{
                    anchors.centerIn: parent
                    text: player.outlinePlayerUser.length ? qsTr(player.outlinePlayerUser) : qsTr("→点这里输入用户名")
                    font.pixelSize: player.outlinePlayerUser.length ? 20 : 15
                    font.family: "console"
                    font.bold: true
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        outlineInputInput.focus = true
                        outlineInputHide.stop()
                        outlineInputShow.start()
                        outlineInput.z = 1

                    }
                }
            }
            Rectangle{
                id:outlineInput
                width: parent.width-100
                height: 35
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#f1f1f1"
                radius: 10
                border.color: "#131313"
                border.width: 2
                z:-1
                opacity: 0
                TextInput{
                    id:outlineInputInput
                    anchors.fill: parent
                    anchors.top: parent.top
                    anchors.topMargin: 8
                    horizontalAlignment: "AlignHCenter"
                    maximumLength: 18
                    font.pixelSize: 18
                    focus: false
                    text: qsTr(player.outlinePlayerUser)
                }
                onOpacityChanged: {
                    if(opacity === 0){
                        outlineInput.z = -1
                    }
                }
            }
            PropertyAnimation{
                id:outlineInputShow
                target: outlineInput
                properties: "opacity"
                to: 1
                duration: 200
            }
            PropertyAnimation{
                id:outlineInputHide
                target: outlineInput
                properties: "opacity"
                to: 0
                duration: 200
            }
        }
    }
//顶部切换按钮动画
    //离线按钮颜色hover
    PropertyAnimation{
        id:outlineBtnColorHovered
        target: outlineBtn
        properties: "color"
        to: "#273B42"
        duration: 200
    }
    //离线按钮字体颜色hover
    PropertyAnimation {
        id: outlineBtnTextColorHovered
        target: outlineBtnText
        properties: "color"
        to: "#D3BEB5"
        duration: 200
    }
    //离线按钮颜色
    PropertyAnimation{
        id:outlineBtnColorBack
        target: outlineBtn
        properties: "color"
        to: "transparent"
        duration: 200
    }
    //离线按钮字体颜色
    PropertyAnimation {
        id: outlineBtnTextColorBack
        target: outlineBtnText
        properties: "color"
        to: "#273B42"
        duration: 200
    }

    //正版登录按钮颜色hover
    PropertyAnimation{
        id:onlineBtnColorHovered
        target: onlineBtn
        properties: "color"
        to: "#273B42"
        duration: 200
    }
    //正版登录按钮字体颜色hover
    PropertyAnimation {
        id: onlineBtnTextColorHovered
        target: onlineBtnText
        properties: "color"
        to: "#D3BEB5"
        duration: 200
    }
    //正版登录按钮颜色
    PropertyAnimation{
        id:onlineBtnColorBack
        target: onlineBtn
        properties: "color"
        to: "transparent"
        duration: 200
    }
    //正版登录按钮字体颜色
    PropertyAnimation {
        id: onlineBtnTextColorBack
        target: onlineBtnText
        properties: "color"
        to: "#273B42"
        duration: 200
    }



    //顶部切换按钮动画方法
    function onlineBtnHoveredFunc(){
        onlineBtnColorBack.stop()
        onlineBtnTextColorBack.stop()
        onlineBtnColorHovered.start()
        onlineBtnTextColorHovered.start()
    }

    function onlineBtnBackFunc(){
        onlineBtnColorHovered.stop()
        onlineBtnTextColorHovered.stop()
        onlineBtnColorBack.start()
        onlineBtnTextColorBack.start()
    }

    function outlineBtnHoveredFunc(){
        outlineBtnColorBack.stop()
        outlineBtnTextColorBack.stop()
        outlineBtnColorHovered.start()
        outlineBtnTextColorHovered.start()
    }

    function outlineBtnBackFunc(){
        outlineBtnColorHovered.stop()
        outlineBtnTextColorHovered.stop()
        outlineBtnColorBack.start()
        outlineBtnTextColorBack.start()
    }

    PropertyAnimation{
        id:changeLoader
        target: playerInfoLoader
        properties: "opacity"
        from: 0
        to: 1
        duration: 200
    }


}

