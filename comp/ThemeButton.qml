import QtQuick

MouseArea{
    property string textColor: "#273B42"
    property string bg: "#D3BEB5"
    property string borderColor: "#A28E85"
    property string text: ""
    property int fontSize: 12
    property int radius: 5
    property int borderWidth: 1
    width: 9
    height: 9
    Rectangle{
        id: btnBg
        anchors.fill: parent
        color: bg
        border.color: borderColor
        border.width: borderWidth
        Text{
            id:btnText
            anchors.centerIn: parent
            font.pixelSize: fontSize
            color: textColor
        }
    }
    hoverEnabled: true
    onEntered: {
        btnBack.stop()
        btnHover.start()
    }
    onExited: {
        btnHover.stop()
        btnBack.start()
    }

    ParallelAnimation{
        id: btnHover
        PropertyAnimation{
            target: btnBg
            properties: "color"
            to: "#A28E85"
        }
        PropertyAnimation{
            target: btnText
            properties: "color"
            to: "#f1f1f1"
        }
    }

    ParallelAnimation{
        id: btnBack
        PropertyAnimation{
            target: btnBg
            properties: "color"
            to: "#D3BEB5"
        }
        PropertyAnimation{
            target: btnText
            properties: "color"
            to: "#273B42"
        }
    }

    Component.onCompleted: {
        btnText.text = qsTr(text)
        btnBg.radius = radius
    }
}
