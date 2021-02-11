import QtQuick 2.0
import QtQuick.Controls 2.4
import "NetworkInstance.js" as API
import org.kde.kirigami 2.9 as Kirigami

Rectangle {
    property var wallpapertype
    property var url_thumbs: []
    property var id
    property int pageNo: 1

    width: parent.width
    height: parent.height
    color: Kirigami.Theme.backgroundColor

    Row {
        width: parent.width
        height: parent.height

        SideBar {
            id: sidebar
        }

        GridView {
            id: categoryGridList

            width: parent.width - sidebar.width
            height: parent.height
            cellHeight: 110
            cellWidth: 220

            ScrollBar.vertical: ScrollBar {}

            delegate: Image {
                width: 200
                height: 100
                source: model.url_thumb

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        pageLoader.setSource("ImageViewer.qml", {
                                                 "image": model.url_image
                                             })
                    }
                }
            }

            onAtYEndChanged: {
                if (categoryGridList.atYEnd) {
                    pageNo++
                    getWallpaper()
                }
            }
            model: gridModel

            Component.onCompleted: {
                getWallpaper()
            }

            ListModel {
                id: gridModel
            }
        }
    }

    function getWallpaper() {
        if (wallpapertype === "popular") {
            url_thumbs = API.getPopularImagesThumb(pageNo)
        } else if (wallpapertype === "featured") {
            url_thumbs = API.getFeaturedImagesThumb(pageNo)
        } else if (wallpapertype === "newest") {
            url_thumbs = API.getNewestImagesThumb(pageNo)
        } else if (wallpapertype === "category") {
            url_thumbs = API.getCategoryWallpaper(id, pageNo)
        }

        gridModel.append(url_thumbs)
    }
}
