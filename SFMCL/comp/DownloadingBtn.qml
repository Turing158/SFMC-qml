import QtQuick

Rectangle{
    property bool hover: false
    id: donwloadingBtn
    width:30
    height: 30
    radius: 30
    color: hover ? deepSubColor_0 : subColor
    Behavior on color{
        ColorAnimation {
            duration: 200
        }
    }

    clip: true
    Text{
        id: arrow
        anchors.horizontalCenter: parent.horizontalCenter
        color: deepColor_5
        y: 6
        text: qsTr("↓")
        font.bold: true
        font.pixelSize: 15
    }
    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            subWindowTitle.text = qsTr("Downloading...")
            leftCompBg.width = mainPage.width/2+200
            subPageLoader.source = "/view/Downloading.qml"
            subWindowHide.stop()
            subWindowShow.start()

        }

        onEntered: {
            hover = true
        }
        onExited: {
            hover = false
        }
    }
    SequentialAnimation{
        running: true
        loops: Animation.Infinite
        PropertyAnimation{
            target: arrow
            properties: "y"
            to: 3
            duration: 50
        }
        PropertyAnimation{
            target: arrow
            properties: "y"
            to: 30
            duration: 150
        }
        PropertyAnimation{
            target: arrow
            properties: "y"
            easing.type: Easing.OutElastic
            to: -15
            duration: 0
        }
        PropertyAnimation{
            target: arrow
            properties: "y"
            to: 6
            duration: 150
        }
        PropertyAnimation{
            target: arrow
            properties: "y"
            to: 6
            duration: 1000
        }
    }
}
