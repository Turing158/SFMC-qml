import QtQuick
import "./"
MouseArea{
    property string textColor: window.deepColor_5
    property string bg: window.subColor
    property string borderColor: window.deepSubColor_1
    property string text: ""
    property int fontSize: 12
    property int radius: 5
    property int borderWidth: 1
    property int align: Text.AlignHCenter
    width: 80
    height: 30
    Rectangle{
        id: btnBg
        anchors.fill: parent
        color: bg
        border.color: borderColor
        border.width: borderWidth
        Text{
            id:btnText
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width-10
            x: 5
            font.pixelSize: fontSize
            color: textColor
            horizontalAlignment: align
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
            to: borderColor
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
            to: bg
        }
        PropertyAnimation{
            target: btnText
            properties: "color"
            to: textColor
        }
    }

    Component.onCompleted: {
        btnText.text = qsTr(text)
        btnBg.radius = radius
    }
    onTextChanged: {
        btnText.text = qsTr(text)
    }
}
