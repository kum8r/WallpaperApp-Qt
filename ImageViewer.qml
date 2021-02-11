import QtQuick 2.0
import QtQuick.Controls 2.15
import "NetworkInstance.js" as API

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
        text: "D"
        anchors.left: parent.left
        onClicked: {
            API.downloadFile(image)
        }
    }

    ToolButton {
        id: closeBtn
        text: "x"
        anchors.right: parent.right
        onClicked: {
            pageLoader.source = ""
        }
    }
}
