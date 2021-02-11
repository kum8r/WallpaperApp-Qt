import QtQuick 2.0
import QtQuick.Controls 2.15
import "NetworkInstance.js" as API
import org.kde.kirigami 2.9 as Kirigami

Rectangle {
    property var thumbs: []

    id: mainContainer
    width: parent.width
    height: parent.height
    color: Kirigami.Theme.backgroundColor

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

                Kirigami.Heading {
                    level: 3
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
                    function onLoadMoreClicked() {
                        pageLoader.setSource("ImageGridList.qml", {
                                                 "wallpapertype": "newest"
                                             })
                    }
                }

                Kirigami.Heading {
                    level: 3
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
                    function onLoadMoreClicked() {
                        pageLoader.setSource("ImageGridList.qml", {
                                                 "wallpapertype": "featured"
                                             })
                    }
                }

                Kirigami.Heading {
                    level: 3
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
                    function onLoadMoreClicked() {
                        pageLoader.setSource("ImageGridList.qml", {
                                                 "wallpapertype": "popular"
                                             })
                    }
                }

                Kirigami.Heading {
                    level: 3
                    text: qsTr("Categories")
                }

                CategoryList {
                    property var list: API.getCategoryList()
                    categoryList: list
                    function onCategoryClicked(index) {
                        pageLoader.setSource("ImageGridList.qml", {
                                                 "id": list[index].id,
                                                 "wallpapertype": "category"
                                             })

                        sidebar.addItem("Sub Category")
                    }
                }
            }
        }
    }
    Component.onCompleted: {
        API.getSubCategoryList(10)
    }
}
