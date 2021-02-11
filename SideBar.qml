import QtQuick 2.0
import org.kde.kirigami 2.9 as Kirigami

Rectangle {
    color: Kirigami.Theme.backgroundColor
    height: parent.height
    width: 210

    Row {
        height: parent.height

        ListView {
            id: sideBarList
            width: 200
            height: parent.height

            Component {
                id: listDelegate

                Rectangle {
                    id: wrapper
                    width: 200
                    height: 50
                    color: Kirigami.Theme.backgroundColor

                    Kirigami.Heading {
                        level: 4
                        id: listInfo
                        text: model.name
                        anchors.centerIn: parent
                    }

                    Rectangle {
                        color: "black"
                        width: parent.width
                        height: 1
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            onItemClicked(model.name)
                        }
                    }
                }
            }

            model: ImagesTypes {
                id: imagelist
            }
            delegate: listDelegate
        }

        Rectangle {
            width: 1
            height: parent.height
            color: "black"
        }
    }

    function addItem(n) {
        imagelist.append({
                             "name": name
                         })
        console.log(n)
    }

    function onItemClicked(name) {
        if (name === "Home") {
            pageLoader.setSource("HomePage.qml")
        } else if (name === "Newest Wallpapers") {
            pageLoader.setSource("ImageGridList.qml", {
                                     "wallpapertype": "newest"
                                 })
        } else if (name === "Featured Wallpapers") {
            pageLoader.setSource("ImageGridList.qml", {
                                     "wallpapertype": "featured"
                                 })
        } else if (name === "Popular Wallpapers") {
            pageLoader.setSource("ImageGridList.qml", {
                                     "wallpapertype": "popular"
                                 })
        } else if (name === "Category") {
            pageLoader.setSource("CategoryGridList.qml")
        }
    }
}
