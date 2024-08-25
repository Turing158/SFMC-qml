import QtQuick 2.15
import "../../comp"
Item {
    Flickable{
        width: mainPage.width-leftComp.width-60
        height: mainPage.height-40
        contentHeight: content.height+40
        clip: true
        Column{
            id: content
            y: 20
            width: parent.width-80
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 20
            ShadowRectangle{
                width: parent.width
                height: 80
                radius: 10
                Text{
                    anchors.centerIn: parent
                    text: qsTr("在这里，你可以获取到一些奇奇怪怪有用的知识")
                    font.pixelSize: 20
                }
            }
            ShadowRectangle{
                width: parent.width
                height: 100
                radius: 10
                Text{
                    x: 10
                    y: 10
                    text: qsTr("Minecraft相关链接")
                }
                Row{
                    y: 40
                    width: parent.width-80
                    height: 40
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 40
                    ThemeButton{
                        width: 130
                        height: 40
                        align: Text.AlignRight
                        text: "Minecraft Wiki"
                        Image{
                            x: 4
                            anchors.verticalCenter: parent.verticalCenter
                            width: 32
                            height: 32
                            source: "https://static.wikia.nocookie.net/minecraft_zh_gamepedia/images/e/e6/Site-logo.png/revision/latest?cb=20211229054835"
                        }
                    }
                    ThemeButton{
                        width: 120
                        height: 40
                        align: Text.AlignRight
                        text: "MCmod 百科"
                        Image{
                            x: 4
                            anchors.verticalCenter: parent.verticalCenter
                            width: 32
                            height: 32
                            source: "https://www.mcmod.cn/images/favicon.ico"
                        }
                    }
                    ThemeButton{
                        width: 120
                        height: 40
                        align: Text.AlignRight
                        text: "MC 百度贴吧"
                        Image{
                            x: 4
                            anchors.verticalCenter: parent.verticalCenter
                            width: 32
                            height: 32
                            source: "https://tiebapic.baidu.com/forum/w%3D120%3Bh%3D120/sign=c1d4747080dda144da0968b0828cb89f/738b4710b912c8fc0ecd26aeeb039245d6882193.jpg?tbpicau=2024-09-05-05_fdecc715dcc56ed6b5fde7b32e808e9b"
                        }
                    }
                }
            }
        }
    }
}
