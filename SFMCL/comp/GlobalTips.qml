import QtQuick
import "./"
ShadowRectangle{
    id: globalTips
    y: 10
    width: 150
    height: 60
    anchors{
        right: parent.right
        rightMargin: -350
        Behavior on rightMargin{
            PropertyAnimation{
                easing{
                    type: Easing.OutElastic
                    amplitude: 1
                    period: 1
                }
                duration: 500
            }
        }
    }
    color: window.subColor
    border.color: window.deepSubColor_1
    z: 9999
    radius: 10
    Text{
        id: globalTipsTitle
        text: qsTr("")
        font.pixelSize: 15
        font.bold: true
        x: 10
        y: 10
        color: window.deepColor_5
    }
    Text{
        id: globalTipsContent
        x: 10
        width: parent.width-20
        height: parent.height-38
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.Wrap
        text: qsTr("")
        font.pixelSize: 13
        color: window.deepColor_5
    }
    transform: Scale{
        id: globalTipsScale
        xScale: 1
        yScale: 1
        Behavior on xScale {
            PropertyAnimation{
                easing.type: Easing.OutBounce
                duration: 100
            }
        }
        Behavior on yScale {
            PropertyAnimation{
                easing.type: Easing.OutBounce
                duration: 100
            }
        }
    }
    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        onPressed: {
            globalTipsScale.xScale = 0.95
            globalTipsScale.yScale = 0.95
        }
        onReleased: {
            scaleTo1()
        }
        onClicked: {
            hide()
        }
        onEntered: {
            showTimer.stop()
        }
        onExited: {
            showTimer.start()
            scaleTo1()
        }
        function scaleTo1(){
            globalTipsScale.xScale = 1
            globalTipsScale.yScale = 1
        }
    }

    signal show(var title,var content,var size)
    signal hide()

    Timer{
        id: showTimer
        interval: 3000
        onTriggered: {
            hide()
        }
    }
    Timer{
        id: reflesh
        interval: 100
        onTriggered: {
            globalTipsScale.xScale = 1
            globalTipsScale.yScale = 1
        }
    }

    Connections{
        target: globalTips
        function onShow(title,content,size){
            if(showTimer.running){
                reflesh.stop()
                globalTipsScale.xScale = 0.95
                globalTipsScale.yScale = 0.95
                reflesh.start()
            }
            onHide()
            if(size === "larger"){
                globalTips.width = 300
                globalTips.height = 100
            }
            else if(size === "small"){
                globalTips.width = 150
                globalTips.height = 60
            }
            else{
                globalTips.width = 200
                globalTips.height = 80
            }
            if(title.length === 0){
                globalTipsContent.height = globalTips.height-10
                globalTipsContent.font.pixelSize = 15
                globalTipsTitle.text = qsTr("")
            }
            else{
                globalTipsContent.height = globalTips.height-38
                globalTipsContent.font.pixelSize = 13
                globalTipsTitle.text = qsTr(title)
            }
            globalTipsScale.origin.x = globalTips.width/2
            globalTipsScale.origin.y = globalTips.height/2
            globalTipsContent.text = qsTr(content)
            globalTips.anchors.rightMargin = 10
            showTimer.start()
        }
        function onHide() {
            showTimer.stop()
            globalTips.anchors.rightMargin = -350
            globalTipsTitle.text = qsTr("")
            globalTipsContent.text = qsTr("")
        }
    }

}
