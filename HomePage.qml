import QtQuick 2.0
import QtQuick.Controls 2.15
import "NetworkInstance.js" as API

Rectangle {
    id: mainContainer
    width: parent.width
    height: parent.height
    property var thumbs: []

    Row {
        width: parent.width
        height: parent.width

        SideBar {
            id: sidebar
        }

        ScrollView {

            width: parent.width
            height: parent.height
            contentWidth: imageListLayout.width // The important part
            contentHeight: imageListLayout.height // Same
            clip: true // Prevent drawing column outside the scrollview borders

            Column {
                id: imageListLayout
                width: mainContainer.width - sidebar.width
                height: mainContainer.height

                Text {
                    text: qsTr("Newest Images")
                }

                ImageListView {
                    property var list: API.getNewestImagesThumb(1)
                    url_thumbs: list
                    function onImagesClicked(index) {
                        pageLoader.setSource("ImageViewer.qml", {
                                                 "image": list[index].url_image
                                             })
                    }
                }

                Text {
                    text: qsTr("Featured Images")
                }

                ImageListView {
                    property var list: API.getFeaturedImagesThumb(1)
                    url_thumbs: list
                    function onImagesClicked(index) {
                        pageLoader.setSource("ImageViewer.qml", {
                                                 "image": list[index].url_image
                                             })
                    }
                }

                Text {
                    text: qsTr("Popular Images")
                }

                ImageListView {
                    property var list: API.getPopularImagesThumb(1)
                    url_thumbs: list
                    function onImagesClicked(index) {
                        pageLoader.setSource("ImageViewer.qml", {
                                                 "image": list[index].url_image
                                             })
                    }
                }

                Text {
                    text: qsTr("Categories")
                }

                CategoryList {
                    property var list: API.getCategoryList()
                    categoryList: list
                    function onCategoryClicked(index) {
                        pageLoader.setSource("WallpaperList.qml", {
                                                 "id": list[index].id,
                                                 "wallpapertype": "category"
                                             })
                    }
                }
            }
        }
    }
}
