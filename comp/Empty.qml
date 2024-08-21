import QtQuick

Item {
    property string orientation: "ver"
    property int num: 20
    width: orientation === "ver" ? 1 : num
    height: orientation === "ver" ? num : 1
}
