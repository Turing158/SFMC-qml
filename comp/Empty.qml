import QtQuick

Item {
    property string orientation: "hor"
    property int num: 20
    width: orientation === "hor" ? 1 : num
    height: orientation === "hor" ? num : 1
}
