import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.4 as Kirigami
import "../js/NetworkInstance.js" as API

Kirigami.Page {
    property var pageNo: 1

    header: Rectangle {
        id: header
        width: parent.width
        height: 30

        Row {
            width: parent.width

            TextField {
                id: searchBar
                placeholderText: "Search..."
                width: parent.width - 100
            }
            Button {
                id: searchBtn
                text: "Search"
                width: 100
                onClicked: {
                    pageNo = 1
                    getImages()
                }
            }
        }
    }

    GridView {
        id: searchImageList
        anchors.fill: parent
        cellHeight: 110
        cellWidth: 210

        onAtYEndChanged: {
            if (searchImageList.atYEnd) {
                pageNo++
                getImages()
            }
        }

        delegate: Kirigami.AbstractListItem {
            width: 200
            height: 100

            onDoubleClicked: {
                applicationWindow().pageStack.layers.push(
                            "qrc:/src/qml/ImageViewer.qml", {
                                "imageSource": model.url_image,
                                "id": model.id
                            })
            }

            contentItem: Image {
                height: 200
                width: 100
                source: model.url_thumb
            }
        }

        model: ListModel {
            id: searchModel
        }
    }

    WorkerScript {
        id: imageWorker2
        source: "qrc:/src/js/NetworkInstance.js"

        onMessage: {
            var searchText = message.searchText

            var images = messageObject.images
            searchModel.append(images)
        }
    }

    function getImages() {
        searchModel.clear()

        imageWorker2.sendMessage({
                                     "imageType": "search",
                                     "pageNo": pageNo,
                                     "searchText": searchBar.text
                                 })

    }
}
