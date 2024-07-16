import QtQuick 6.2

Item {
    property int online: 1
    property int isLogining: 0
    property int isLogined: 0

    anchors.horizontalCenter: parent.horizontalCenter
    y: 20
    Rectangle {
        width: homePage.width
        height: 200
        color:"transparent"
        Rectangle {
            width: 180
            height: 30
            color: "transparent"
            anchors.horizontalCenter: parent.horizontalCenter
            Rectangle{
                id:onlineBtn
                width: 80
                height: 30
                color: "#273B42"
                radius: width
                Text {
                    id:onlineBtnText
                    anchors.centerIn: parent
                    text: qsTr("🔗 正 版")
                    font.pixelSize: 14
                    color: "#D3BEB5"
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        if(online !== 1){
                            onlineBtnHoveredFunc()
                        }
                    }
                    onExited: {
                        if(online !== 1){
                            onlineBtnBackFunc()
                        }
                    }
                    onClicked: {
                        if(online !== 1){
                            outlineBtnBackFunc()
                        }
                        online = 1
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
                    }
                }
            }
            Rectangle{
                id: outlineBtn
                anchors.right: parent.right
                width: 80
                height: 30
                color: "transparent"
                radius: width
                Text {
                    id:outlineBtnText
                    anchors.centerIn: parent
                    text: qsTr("🖇️ 离 线")
                    font.pixelSize: 14
                    color: "#273B42"
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        if(online !== 0){
                            outlineBtnHoveredFunc()
                        }
                    }
                    onExited: {
                        if(online !== 0){
                            outlineBtnBackFunc()
                        }
                    }
                    onClicked: {
                        if(online !== 0){
                            onlineBtnBackFunc()
                        }
                        online = 0
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
                sourceComponent: noLogin
                onSourceComponentChanged: {
                    changeLoader.stop()
                    changeLoader.start()
                }
            }
        }


    }
    Component{
        id:noLogin
        Rectangle{
            width: playerInfo.width
            height: playerInfo.height
            color: playerInfo.color
            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                width: 60
                height: 60
                smooth: false
                source: "/img/steve.png"
            }
            Rectangle{
                id:loginBtn
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                width: parent.width-50
                height: 30
                radius: 5
                border.color: "#749DAD"
                color: "#AEC6CF"
                Text {
                    anchors.centerIn: parent
                    id: loginBtnText
                    text: qsTr("登         录")
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
            }
            Text{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 45
                text: qsTr("Turing_ICE")
                font.pixelSize: 20
                font.family: "console"
            }
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
            }
            // Rectangle{
            //     id:settingInfo
            //     anchors.left: parent.left
            //     anchors.leftMargin: 80
            //     anchors.bottom: parent.bottom
            //     anchors.bottomMargin: 10
            //     width: (parent.width-200)/2
            //     height: 30
            //     radius: 5
            //     border.color: "#749DAD"
            //     color: "#AEC6CF"
            //     Text {
            //         anchors.centerIn: parent
            //         id: settingInfoText
            //         text: qsTr("修改档案")
            //         font.pixelSize: 15
            //     }
            // }
            // Rectangle{
            //     id:reLogin
            //     anchors.right: parent.right
            //     anchors.rightMargin: 80
            //     anchors.bottom: parent.bottom
            //     anchors.bottomMargin: 10
            //     width: (parent.width-200)/2
            //     height: 30
            //     radius: 5
            //     border.color: "#749DAD"
            //     color: "#AEC6CF"
            //     Text {
            //         anchors.centerIn: parent
            //         id: reLoginText
            //         text: qsTr("重新登录")
            //         font.pixelSize: 15
            //     }
            // }
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
        if(online != 1){

        }
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

