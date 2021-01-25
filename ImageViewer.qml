import QtQuick 2.0
import QtQuick.Controls 2.15

Rectangle {
    property var image
    width: parent.width
    height: parent.height

    Image {
        source: image
        sourceSize.height: height
        sourceSize.width: width
        width: parent.width
        height: parent.height
    }

    ToolButton {
        text: "d"
        anchors.left: parent.left
        onClicked: {
            imagedownloader.setImageUrl(image)
            imagedownloader.download()
        }
    }

    ToolButton {
        id: closeBtn
        text: "x"
        anchors.right: parent.right
        onClicked: {
            pageLoader.setSource("HomePage.qml")
        }
    }
}
