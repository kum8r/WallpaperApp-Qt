import QtQuick 2.0

ListView {
    function onImagesClicked(index) {}
    property var url_thumbs

    width: parent.width
    height: 100
    orientation: ListView.Horizontal
    delegate: Image {
        width: 200
        height: 100
        source: modelData.url_thumb

        MouseArea {
            anchors.fill: parent
            onClicked: {
                onImagesClicked(index)
            }
        }
    }

    model: url_thumbs
}
