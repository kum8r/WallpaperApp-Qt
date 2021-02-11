import QtQuick 2.0
import org.kde.kirigami 2.9 as Kirigami

ListView {
    function onImagesClicked(index) {}
    function onLoadMoreClicked() {}
    property var url_thumbs

    width: parent.width
    height: 100
    orientation: ListView.Horizontal
    spacing: 5

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

    footer: Rectangle {
        color: Kirigami.Theme.backgroundColor
        width: 200
        height: 100

        Kirigami.Heading {
            anchors.fill: parent
            level: 4
            text: "Load More"
            horizontalAlignment: "AlignHCenter"
            verticalAlignment: "AlignVCenter"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                onLoadMoreClicked()
            }
        }
    }

    model: url_thumbs
}
