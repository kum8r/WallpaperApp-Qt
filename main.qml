import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    width: 900
    height: 600
    visible: true
    title: qsTr("Wallpaper App")

    Loader {
        id: pageLoader
        width: parent.width
        height: parent.width
        Component.onCompleted: {
            pageLoader.setSource("HomePage.qml")
        }
    }
}
