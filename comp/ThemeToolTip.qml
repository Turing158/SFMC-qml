import QtQuick
import QtQuick.Controls.Basic
ToolTip{
    id: tip
    height: 25
    topPadding: 5
    leftPadding: 5
    rightPadding: 5
    font.pixelSize: 12
    contentItem: Text{
        text: qsTr(tip.text)
        color: "#273B42"
        anchors.fill: parent
        font.pixelSize: tip.font.pixelSize
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
    background:Rectangle{
        anchors.fill: parent
        color: "#D3BEB5"
        border.color: "#A28E85"
        radius: 5
    }
    signal show()
    signal hide()
    onShow: {
        if(!tip.visible){
            hide.stop()
            show.start()
        }
        tip.visible = true
    }
    onHide: {
        show.stop()
        hide.start()
    }
    PropertyAnimation{
        id: show
        target: tip
        properties: "opacity"
        from: 0
        to: 1
        duration: 200
    }
    PropertyAnimation{
        id: hide
        target: tip
        properties: "opacity"
        from: 1
        to: 0
        duration: 200
        onFinished: {
            tip.visible = false
        }
    }
}