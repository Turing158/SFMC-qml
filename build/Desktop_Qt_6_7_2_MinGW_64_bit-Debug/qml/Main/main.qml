import QtQuick
import QtQuick.Controls

Window{
    id:window
    width: 900
    height: 450
    visible: true
    flags: Qt.Window | Qt.FramelessWindowHint
    color: "#00000000"
    Rectangle{
        id:main
        anchors.fill: parent
        color: "#AEC6CF"
        radius: 10
        border.color: "#687E86"
        border.width: 2
        Rectangle{
            id:top
            width: parent.width
            height: 50
            color: "#687E86"
            topLeftRadius: 10
            topRightRadius: 10
            focus: true
            Rectangle{
                width: 30
                height: 30
                color: "#00000000"
                anchors.verticalCenter: parent.verticalCenter
                x:10
                Loader{
                    source: "/comp/Icon.qml"
                }
            }
            MouseArea{
                anchors.fill: parent
                property point clickPos: "0,0"
                onPressed: {
                    clickPos = Qt.point(mouseX, mouseY)
                }
                onPositionChanged: {
                    var delta = Qt.point(mouseX-clickPos.x, mouseY-clickPos.y)
                    window.setX(window.x+delta.x)
                    window.setY(window.y+delta.y)
                }
            }
            Rectangle{
                width: 30
                height: 30
                color: "#00000000"
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 10
                Loader{
                    asynchronous: true
                    source: "/comp/CloseBtn.qml"
                }
            }
            Rectangle{
                width: 30
                height: 30
                color: "#00000000"
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 50
                Loader{
                    asynchronous: true
                    source: "/comp/MiniBtn.qml"
                }
            }
        }
        Rectangle{
            id:mainPage
            y: top.height
            width: window.width
            height: window.height-top.height
            bottomLeftRadius: 10
            bottomRightRadius: 10
            color:"transparent"
            Loader{
                asynchronous: true
                source: "/Home.qml"
            }
        }
    }
    signal miniWindow()
    onMiniWindow: {
        showMinimized()
    }
}
