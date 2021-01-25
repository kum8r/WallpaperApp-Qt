import QtQuick 2.0

Item {

    height: parent.height
    width: 210

    Row {
        height: parent.height

        ListView {
            width: 200
            height: parent.height

            Component {
                id: listDelegate

                Rectangle {
                    id: wrapper
                    width: 180
                    height: 50

                    Text {
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
                            console.log(model.name)
                            onItemClicked(model.name)
                        }
                    }
                }
            }

            model: WallpaperType {}
            delegate: listDelegate
        }

        Rectangle {
            width: 1
            height: parent.height
            color: "black"
        }
    }

    function onItemClicked(name) {
        console.log(name)
        if (name === "Home") {
            pageLoader.setSource("HomePage.qml")
        } else if (name === "Newest Wallpapers") {

            pageLoader.setSource("WallpaperList.qml", {
                                     "wallpapertype": "newest"
                                 })
        } else if (name === "Featured Wallpapers") {

            pageLoader.setSource("WallpaperList.qml", {
                                     "wallpapertype": "featured"
                                 })
        } else if (name === "Popular Wallpapers") {

            pageLoader.setSource("WallpaperList.qml", {
                                     "wallpapertype": "popular"
                                 })
        }
    }
}
