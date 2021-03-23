import QtQuick 2.0
import QtQuick.Controls 2.12
import org.kde.kirigami 2.4 as Kirigami
import "../js/NetworkInstance.js" as API

GridView {
    property var image_type
    property var categoryId
    property var pageNo: 1
    id: imageGridList

    cellHeight: 110
    cellWidth: 210

    ScrollBar.vertical: ScrollBar {}

    delegate: Image {
        width: 200
        height: 100
        source: model.url_thumb

        MouseArea {
            anchors.fill: parent
            onClicked: {
                applicationWindow().pageStack.layers.push("qrc:/src/qml/ImageViewer.qml", {"imageSource":model.url_image, "id":model.id})
            }
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

    function getImages() {
        var url_thumbs
        if (image_type === "popular") {
            url_thumbs = API.getPopularImagesThumb(pageNo)
        } else if (image_type === "featured") {
            url_thumbs = API.getFeaturedImagesThumb(pageNo)
        } else if (image_type === "newest") {
            url_thumbs = API.getNewestImagesThumb(pageNo)
        } else if (image_type === "category") {
            url_thumbs = API.getCategoryWallpaper(categoryId, pageNo)
        }
        else if (image_type === "subcategory") {
            url_thumbs = API.getSubCategoryWallpaper(categoryId, pageNo)
        }

        gridModel.append(url_thumbs)
    }
}
