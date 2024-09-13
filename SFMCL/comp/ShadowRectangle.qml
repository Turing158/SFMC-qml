import QtQuick
import Qt5Compat.GraphicalEffects
Rectangle{
    id: box
    property string shadowColor: "#496E7C"
    property string shadowColor_TRUE: ""
    Component.onCompleted: {
        var sp = shadowColor.split("#")
        shadowColor_TRUE = "#66"+sp[1]
    }
    onShadowColorChanged: {
        var sp = shadowColor.split("#")
        shadowColor_TRUE = "#66"+sp[1]
    }
    color: "#f1f1f1"
    radius: 0
    DropShadow{
        id: boxShadow
        source: parent
        height: parent.height
        width: parent.width
        radius: 6
        samples: 13
        color: "#22000000"
        z: -1
    }
    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            boxBack.stop()
            boxHover.start()
        }
        onExited: {
            boxHover.stop()
            boxBack.start()
        }
    }
    PropertyAnimation{
        id: boxHover
        target: boxShadow
        properties: "color"
        to: shadowColor_TRUE
    }
    PropertyAnimation{
        id: boxBack
        target: boxShadow
        properties: "color"
        to: "#22000000"
    }

}
