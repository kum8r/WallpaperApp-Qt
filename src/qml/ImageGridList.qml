import QtQuick 2.0
import QtQuick.Controls 2.12
import org.kde.kirigami 2.4 as Kirigami

GridView {
    property string image_type
    property var categoryId
    property var pageNo: 1
    id: imageGridList

    cellHeight: 110
    cellWidth: 210

    ScrollBar.vertical: ScrollBar {}


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

    ListModel {
        id: gridModel
    }

    model: gridModel

    Component.onCompleted: {
        getImages()
    }

    onAtYEndChanged: {
        if (imageGridList.atYEnd) {
            pageNo++
            getImages()
        }
    }

    WorkerScript {
        id: imageWorker2
        source: "qrc:/src/js/NetworkInstance.js"

        onMessage: {
            var images = messageObject.images
            gridModel.append(images)
        }
    }

    function getImages() {
        if (image_type === "popular" || image_type === "featured"
                || image_type === "newest") {
            imageWorker2.sendMessage({
                                         "pageNo": pageNo,
                                         "imageType": image_type
                                     })
        } else if (image_type === "category" || image_type === "subcategory") {
            imageWorker2.sendMessage({
                                         "pageNo": pageNo,
                                         "imageType": image_type,
                                         "categoryId": categoryId
                                     })
        }
    }
}
