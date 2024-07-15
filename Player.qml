import QtQuick 6.2

Item {
    anchors.horizontalCenter: parent.horizontalCenter
    y: 20
    property int online: 1
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
                    }
                }
            }
        }
        Rectangle{
            y:50
            width: parent.width
            height: 140
            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                id: avatar
                width: 60
                height: 60
                smooth: false
                source: "/img/steve.png"
            }
        }


    }


    PropertyAnimation{
        id:outlineBtnColorHovered
        target: outlineBtn
        properties: "color"
        to: "#273B42"
        duration: 200
    }

    PropertyAnimation {
        id: outlineBtnTextColorHovered
        target: outlineBtnText
        properties: "color"
        to: "#D3BEB5"
        duration: 200
    }
    PropertyAnimation{
        id:outlineBtnColorBack
        target: outlineBtn
        properties: "color"
        to: "transparent"
        duration: 200
    }

    PropertyAnimation {
        id: outlineBtnTextColorBack
        target: outlineBtnText
        properties: "color"
        to: "#273B42"
        duration: 200
    }


    PropertyAnimation{
        id:onlineBtnColorHovered
        target: onlineBtn
        properties: "color"
        to: "#273B42"
        duration: 200
    }

    PropertyAnimation {
        id: onlineBtnTextColorHovered
        target: onlineBtnText
        properties: "color"
        to: "#D3BEB5"
        duration: 200
    }
    PropertyAnimation{
        id:onlineBtnColorBack
        target: onlineBtn
        properties: "color"
        to: "transparent"
        duration: 200
    }

    PropertyAnimation {
        id: onlineBtnTextColorBack
        target: onlineBtnText
        properties: "color"
        to: "#273B42"
        duration: 200
    }

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
}

