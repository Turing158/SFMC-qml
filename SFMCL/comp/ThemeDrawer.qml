import QtQuick

ShadowRectangle{
    id: popRectangle
    property bool isOpen: false
    property int initHeight: 50
    property int contentHeight: 0
    property string title: "Title标题"
    property int titleFontSize: 15
    property string titleColor: "#273B42"
    width: 50
    height: initHeight
    radius: 10
    clip: true
    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            titleText.color = titleColor
            arrow.color = titleColor
        }
        onExited: {
            titleText.color = "#131313"
            arrow.color = "#66131313"
        }
    }

    MouseArea{
        width: parent.width
        height: initHeight
        onClicked: {
            if(isOpen){
                popRectangle.height = initHeight
            }
            else{
                popRectangle.height = contentHeight+initHeight
            }
            isOpen = !isOpen
        }
    }
    Item{
        width: parent.width
        height: initHeight
        Text{
            id: titleText
            anchors.verticalCenter: parent.verticalCenter
            x: 10
            text: qsTr(title)
            font.pixelSize: titleFontSize
            color: "#131313"
            Behavior on color {
                PropertyAnimation{
                    duration: 200
                }
            }
        }
        Text{
            id: arrow
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 20
            text: qsTr("▼")
            color: "#66131313"
            font.pixelSize: 18
            rotation: 0
            Behavior on color {
                PropertyAnimation{
                    duration: 200
                }
            }
            Behavior on rotation {
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
    }
    Behavior on height {
        PropertyAnimation{
            easing{
                type: Easing.InOutElastic
                amplitude: 1
                period: 5
            }
            duration: 300
        }
    }
    Component.onCompleted: {
        titleText.text = qsTr(title)
        initHeight = popRectangle.height
    }
    onIsOpenChanged: {
        if(isOpen){
            arrow.rotation = 180
            openDrawer()
        }
        else{
            arrow.rotation = 0
            closeDrawer()
        }
    }
    signal openDrawer()
    signal closeDrawer()
}
