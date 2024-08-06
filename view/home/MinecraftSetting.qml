import QtQuick
import QtQuick.Controls
import "../../comp"
Item {
    property var javaVerions: []
    property string suitableJava: ""
    Flickable{
        id: minecraftSetting
        width: mainPage.width-leftComp.width-60
        height: mainPage.height-40
        contentHeight: content.height
        clip: true
        Column{
            id: content
            width: parent.width-80
            anchors.horizontalCenter: parent.horizontalCenter
            Item{height: 20;width: 1}
            ShadowRectangle{
                width: parent.width
                height: 80
                radius: 10
                Text{
                    x: 10
                    y: 10
                    text: qsTr("Java版本")
                }
                Loader{
                    id: selectJavaVersion
                }
                Component{
                    id: selectJavaVersionComp
                    ComboBox{
                        width: content.width-100
                        height: 30
                        x: 10
                        y: 35
                        textRole: "key"
                        font.pixelSize: 14
                        valueRole: "value"
                        model: javaVerions
                        delegate: ItemDelegate {
                            width: parent.width
                            height: 40
                            contentItem:Text{
                                anchors.verticalCenter: parent.verticalCenter
                                text: qsTr(modelData.key)
                                font.pixelSize: 14
                                color: index == currentIndex ? "#38555F" : "#131313"
                            }
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 15
                                text: qsTr(modelData.value === "auto" ? "" : modelData.value)
                                color: "#666"
                            }
                        }
                    }
                }
                ThemeButton{
                    id: addJavaPath
                    width: 28
                    height: 28
                    x: parent.width-89
                    y: 36
                    text: "+"
                    fontSize: 20
                }
                ThemeButton{
                    id: reloadJavaPath
                    width: 28
                    height: 28
                    anchors.left: addJavaPath.right
                    anchors.leftMargin: 1
                    anchors.top: addJavaPath.top
                    text: "↺"
                    fontSize: 20
                }
            }
            ShadowRectangle{
                width: parent.width
                height: 40

            }
        }
        signal findAllJavaVersion()
        Component.onCompleted: {
            findAllJavaVersion()
            selectJavaVersion.sourceComponent = selectJavaVersionComp
        }
    }
    Connections{
        target: minecraftSetting
        function onFindAllJavaVersion(){
            var list = []
            javaVerions = []
            var map = launcherUtil.findAllJavaVersion()
            for(var i in map){
                list.push({key:map[i],value:i})
            }
            if(list.length === 0){
                javaVerions.push({key:"未找到java版本，请自行添加",value:""})
            }
            else{
                var sj = launcherUtil.getSuitableJava(launcher.selectDir, launcher.selectVersion)
                console.log(sj)
                if(sj === 0){
                    javaVerions.push({key:"未找到适合的java版本",value:"noSuit"})
                }
                else if(sj < 10){
                    javaVerions.push({key:"自动选择合适的java",value:"1."+sj})
                }
                else{
                    javaVerions.push({key:"自动选择合适的java",value:""+sj})
                }
                javaVerions = javaVerions.concat(list)
            }



        }
    }

}

