import QtQuick 6.2
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import LoginMinecraft 1.0
Item {

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
                id: activeBlock
                width: 70
                height: 25
                color: "#273B42"
                radius: width
                x: window.isOnline ? 0 : 110
                Behavior on x{
                    PropertyAnimation{
                        easing{
                            type: Easing.OutElastic
                            amplitude: 1
                            period: 1
                        }
                        duration: 300
                    }
                }
            }
            Rectangle{
                id:onlineBtn
                width: 70
                height: 25
                color: "transparent"
                Text {
                    id:onlineBtnText
                    anchors.centerIn: parent
                    text: qsTr("🔗 正 版")
                    font.pixelSize: 12
                    color: window.isOnline ? "#D3BEB5" : "#273B42"
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {

                    }
                    onExited: {

                    }
                    onClicked: {

                        window.isOnline = true
                        if(window.isLogining === 1){
                            playerInfoLoader.sourceComponent = logining
                        }
                        else{
                            if(window.isLogined === 1){
                                playerInfoLoader.sourceComponent = logined
                            }
                            else{
                                playerInfoLoader.sourceComponent = noLogin
                            }
                        }
                        launcher.username = player.onlinePlayerUser
                        launcher.uuid = player.onlineUuid
                        launcher.token = player.onlineAccessToken
                    }
                }
            }
            Rectangle{
                id: outlineBtn
                anchors.right: parent.right
                width: 70
                height: 25
                color: "transparent"
                Text {
                    id:outlineBtnText
                    anchors.centerIn: parent
                    text: qsTr("🖇️ 离 线")
                    font.pixelSize: 12
                    color: !window.isOnline ? "#D3BEB5" : "#273B42"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        window.isOnline = false
                        launcher.username = player.outlinePlayerUser
                        launcher.uuid = qsTr(""+launcherUtil.generateUUID())
                        playerInfoLoader.sourceComponent = outlineUser
                    }
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
                sourceComponent: !window.isOnline ? outlineUser : window.isLogining === 1 ? logining : window.isLogined === 0 ? noLogin : logined
                opacity: 1
                onSourceComponentChanged: {
                    playerInfoLoader.opacity = 0
                    playerInfoLoaderAfter.stop()
                    playerInfoLoaderAfter.start()
                }
                Behavior on opacity {
                    PropertyAnimation{
                        duration: 200
                    }
                }
                Timer{
                    id: playerInfoLoaderAfter
                    interval: 200
                    onTriggered: {
                        playerInfoLoader.opacity = 1
                    }
                }
            }
        }
        LoginMinecraft{
            id:loginMc
            onGetMicrosoftDeviceCodeSignal: {
                processTips.setTips("获取代码中. . .")
            }
            onGetMicrosoftTokenSignal: {
                processTips.setTips("登录Microsoft中. . .")
            }
            onGetXBoxLiveTokenAndAuthenticateSignal: {
                processTips.setTips("验证XBoxLive中. . .")
            }
            onGetXSTSTokenAndAuthenticateSignal: {
                processTips.setTips("验证XSTS中. . .")
            }
            onGetMinecraftTokenSignal: {
                processTips.setTips("登录Minecraft中. . .")
            }
            onGetMinecraftUUIDSignal: {
                processTips.setTips("获取Minecraft信息中. . .")
            }
            onGetMicrosoftDeviceCodeData: {
                playerInfoLoader.item.refleshCode()
                openUrl("https://www.microsoft.com/link")
                repeatGetMicrosoftTokenTimer.start()
            }
            onFinishGetMicrosoftToken: {
                repeatGetMicrosoftTokenTimer.stop()
            }
            onFinishLogin:function (success,msg) {
                window.topProcessHide()
                window.isLogining = 0
                if(success){
                    window.isLogined = 1
                    playerInfoLoader.sourceComponent = logined
                }
                else{
                    window.isLogined = 0
                    playerInfoLoader.sourceComponent = noLogin
                }
                globalTips.show("",msg,"")
            }
            onSuccessLogin: function (username,UUID,accessToken,skin){
                player.onlineAccessToken = accessToken
                player.onlinePlayerUser = username
                player.onlineUuid = UUID
                player.onlineSkin = skin
            }
            signal openUrl(var url)
            signal cancleLogin()
            onCancleLogin: {
                repeatGetMicrosoftTokenTimer.stop()
                loginMc.clearLoginInfo()
            }
        }
        Connections{
            target: loginMc
            function onOpenUrl(url){
                if(launcherUtil.openWebUrl(url)){
                    globalTips.show("","已打开链接到浏览器\n若未打开，请等一下\n真打不开就是真的打不开了","larger")
                }
                else{
                    globalTips.show("","无法打开链接到浏览器","")
                }
            }
        }
        Timer{
            id:repeatGetMicrosoftTokenTimer
            interval: 3000
            onTriggered: {
                loginMc.getMicrosoftToken()
            }
            repeat: true
        }
    }







    Component{
        id:noLogin
        MouseArea{
            width: playerInfo.width
            height: playerInfo.height
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
            ThemeButton{
                id:loginBtn
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                width: 100
                height: 30
                radius: 5
                borderColor: "#749DAD"
                opacity: 0
                text: qsTr("登    录")
                fontSize: 15
                onClicked: {
                    loginBtn.loginFunc()
                    playerInfoLoader.sourceComponent = logining
                    window.isLogining = 1
                    window.topProcessShow()
                }
                signal loginFunc()
                Connections{
                    target: loginBtn
                    function onLoginFunc(){
                        loginMc.getMicrosoftDeviceCode()
                    }
                }
                Behavior on opacity {
                    PropertyAnimation{
                        duration: 200
                    }
                }
            }
            hoverEnabled: true
            onEntered: {
                loginBtn.opacity = 1
            }
            onExited: {
                loginBtn.opacity = 0
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
                id: onlineSkinIn
                anchors.horizontalCenter: parent.horizontalCenter
                width: 60
                height: 60
                smooth: false
                source: player.onlineSkin
                sourceClipRect{
                    x: 8
                    y: 8
                    width: 8
                    height: 8
                }
                DropShadow{
                    source: parent
                    anchors.fill: parent
                    radius:8
                    samples: 17
                    color: "#22000000"
                    z: -1
                }
            }
            Image {
                id: onlineSkinOut
                anchors.horizontalCenter: parent.horizontalCenter
                width: 65
                height: 65
                smooth: false
                source: player.onlineSkin
                y:-4
                sourceClipRect{
                    x: 40
                    y: 8
                    width: 8
                    height: 8
                }
                DropShadow{
                    source: parent
                    anchors.fill: parent
                    radius:8
                    samples: 17
                    color: "#55000000"
                    z: -2
                }
            }
            Text{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 45
                text: qsTr(player.onlinePlayerUser)
                font.pixelSize: 20
                font.family: "console"
            }
            MouseArea{
                id: operateBtn
                width: parent.width
                height: parent.height
                anchors.bottom: parent.bottom
                opacity: 0
                ThemeButton{
                    id:settingInfo
                    anchors.left: parent.left
                    anchors.leftMargin: 80
                    anchors.bottom: parent.bottom
                    width: (parent.width-200)/2
                    height: 30
                    radius: 5
                    borderColor: "#749DAD"
                    text: qsTr("修改档案")
                    fontSize: 13
                    onClicked: {
                        globalTips.show("","功能未实现","")
                    }
                }
                ThemeButton{
                    id:outLogin
                    anchors.right: parent.right
                    anchors.rightMargin: 80
                    anchors.bottom: parent.bottom
                    width: (parent.width-200)/2
                    height: 30
                    radius: 5
                    borderColor: "#749DAD"
                    text: qsTr("退出登录")
                    fontSize: 13
                    onClicked: {
                        outLoginDialog.open()

                    }
                }
                hoverEnabled: true
                onEntered: {
                    operateBtn.opacity = 1
                }
                onExited: {
                    operateBtn.opacity = 0
                }
                Behavior on opacity {
                    PropertyAnimation{
                        duration: 200
                    }
                }
            }
            ThemeDialog{
                id: outLoginDialog
                title: qsTr("是否退出登录")
                content: qsTr("退出登录代表着将当前储存的正版账号信息清除，需要重新登录")
                isShowCancle: true
                onConfirm: {
                    playerInfoLoader.sourceComponent = noLogin
                    window.isLogining = 1
                    player.clearInfo()
                }
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
                height: 200
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
                    id: loginingCode
                    y:34
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr(loginMc.user_code.length === 0?"加载中...":loginMc.user_code)
                    font.pixelSize: 25
                    font.bold: true
                    font.family: "console"
                    color: "#273B42"
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            if(loginMc.user_code.length === 0){
                                globalTips.show("","请等待代码加载！","");
                            }
                            else{
                                launcherUtil.copyTextToClipboard(loginMc.user_code);
                                globalTips.show("已复制代码",loginMc.user_code,"");
                            }
                        }
                    }
                }
                Text {
                    y:66
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("若未打开浏览器，点击复制链接")
                    font.pixelSize: 12
                }
                Text {
                    y:80
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("然后自行打开浏览器，点击代码可以复制代码")
                    font.pixelSize: 12
                }
            }
            ThemeButton{
                id:copyLink
                anchors.left: parent.left
                anchors.leftMargin: 80
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                width: (parent.width-200)/2
                height: 30
                radius: 5
                borderColor: "#749DAD"
                text: qsTr("复制链接")
                onClicked: {
                    // 复制链接
                    launcherUtil.copyTextToClipboard("https://www.microsoft.com/link");
                    globalTips.show("已复制链接","https://www.microsoft.com/link","");
                }
            }
            ThemeButton{
                id:back
                anchors.right: parent.right
                anchors.rightMargin: 80
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                width: (parent.width-200)/2
                height: 30
                radius: 5
                borderColor: "#749DAD"
                text: qsTr("返   回")
                fontSize: 15
                onClicked: {
                    loginMc.cancleLogin()
                    window.isLogining = 0
                    window.topProcessHide()
                    if(window.isLogined === 1){
                        playerInfoLoader.sourceComponent = logined
                    }
                    else{
                        playerInfoLoader.sourceComponent = noLogin
                    }
                }
            }
            function refleshCode(){
                loginingCode.text = loginMc.user_code
                launcherUtil.copyTextToClipboard(loginMc.user_code);
                globalTips.show("已复制代码",loginMc.user_code,"");
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
                    outlineInput.opacity = 0
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
                        outlineInput.opacity = 1
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
                Behavior on opacity {
                    PropertyAnimation{
                        duration: 200
                    }
                }
            }
        }
    }
}

