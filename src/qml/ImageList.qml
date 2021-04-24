import QtQuick 2.0
import QtQuick.Controls 2.0
import org.kde.kirigami 2.13 as Kirigami

ListView {
    property var url_thumbs

    height: 120
    orientation: ListView.Horizontal
    spacing: 5

    delegate: Kirigami.AbstractListItem {
        width: 150
        height: 100

        onDoubleClicked: {
            applicationWindow().pageStack.layers.push(
                        "qrc:/src/qml/ImageViewer.qml", {
                            "imageSource": modelData.url_image,
                            "id": modelData.id
                        })
        }

        contentItem: Image {
            width: 150
            height: 100
            source: modelData.url_thumb
        }
    }

    Kirigami.PlaceholderMessage {
        anchors.centerIn: parent
        width: parent.width - (Kirigami.Units.largeSpacing * 4)

        visible: url_thumbs.length === 0

        BusyIndicator {}
    }

    model: url_thumbs
}
