import QtQuick 6.2

Item{
    Rectangle{
        id:homePage
        width: mainPage.width/2-40
        height: mainPage.height-40
        x:20
        y:20
        color:"transparent"
        Rectangle{
            //bg
            anchors.fill: parent
            color: "#fff"
            opacity: 0.6
            radius: 10
        }
        Rectangle{
            anchors.horizontalCenter: parent.horizontalCenter
            y: 20
            width: parent.width
            height: 200
            color: "transparent"
            Loader{
                asynchronous: true
                source: "/comp/Player.qml"
            }
        }
    }
    Rectangle{
        width: parent.width/2-20
        height: parent.height
        anchors.right: parent.right
        // color: "#fff"
    }


}

