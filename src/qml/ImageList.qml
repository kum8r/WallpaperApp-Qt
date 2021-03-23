import QtQuick 2.0

ListView {
    property var url_thumbs

    height: 120
    orientation: ListView.Horizontal
    spacing: 5

    delegate: Image {
        width: 150
        height: 100
        source: modelData.url_thumb

        MouseArea {
            anchors.fill: parent
            onClicked: {
                applicationWindow().pageStack.layers.push(
                            "qrc:/src/qml/ImageViewer.qml", {
                                "imageSource": modelData.url_image,
                                "id":modelData.id
                            })
            }
        }
    }

    model: url_thumbs
}
