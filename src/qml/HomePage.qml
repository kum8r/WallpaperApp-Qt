import QtQuick 2.0
import org.kde.kirigami 2.4 as Kirigami
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.4

Kirigami.ScrollablePage {

    property bool isNewestLoading: false
    property bool isPopularLoading: false
    property bool isFeaturedLoading: false

    title: "Home"
    anchors.fill: parent
    clip: true
    contentWidth: column.width
    contentHeight: column.height

    ScrollBar.vertical: ScrollBar {}

    ColumnLayout {
        id: column
        width: parent.width

        Kirigami.Heading {
            text: "Popular Wallpapers"
            level: 3
        }

        ImageList {
            id: popularImages
            Layout.fillWidth: true

            footer: Rectangle {
                visible: !isPopularLoading
                id: popularLoadMore
                width: 150
                height: 100
                color: Kirigami.Theme.backgroundColor

                Kirigami.Heading {
                    level: 5
                    text: "Load More"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.fill: parent
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        stack.currentIndex = 3
                    }
                }
            }

            WorkerScript {
                id: popularImageWorker
                source: "qrc:/src/js/NetworkInstance.js"

                onMessage: {
                    popularImages.url_thumbs = messageObject.images
                    isPopularLoading = false
                }
            }

            Component.onCompleted: {

                popularImageWorker.sendMessage({
                                                   "pageNo": 1,
                                                   "imageType": "popular"
                                               })
                isPopularLoading = true
            }
        }

        Kirigami.Heading {
            text: "Newest Wallpapers"
            level: 3
        }

        ImageList {
            id: newestImages
            Layout.fillWidth: true

            footer: Rectangle {
                visible: !isNewestLoading
                id: newestLoadMore
                width: 150
                height: 100
                color: Kirigami.Theme.backgroundColor

                Kirigami.Heading {
                    level: 5
                    text: "Load More"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.fill: parent
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        stack.currentIndex = 2
                    }
                }
            }

            WorkerScript {
                id: newestImageWorker
                source: "qrc:/src/js/NetworkInstance.js"

                onMessage: {
                    newestImages.url_thumbs = messageObject.images

                    isNewestLoading = false
                }
            }

            Component.onCompleted: {

                newestImageWorker.sendMessage({
                                                  "pageNo": 1,
                                                  "imageType": "newest"
                                              })

                isNewestLoading = true
            }
        }

        Kirigami.Heading {
            text: "Featured Wallpapers"
            level: 3
        }

        ImageList {
            id: featuredImages
            Layout.fillWidth: true

            footer: Rectangle {
                visible: !isFeaturedLoading
                id: featuredLoadMore
                width: 150
                height: 100
                color: Kirigami.Theme.backgroundColor

                Kirigami.Heading {
                    level: 5
                    text: "Load More"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.fill: parent
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        stack.currentIndex = 1
                    }
                }
            }

            WorkerScript {
                id: featuredImageWorker
                source: "qrc:/src/js/NetworkInstance.js"

                onMessage: {
                    featuredImages.url_thumbs = messageObject.images

                    isFeaturedLoading = false
                }
            }

            Component.onCompleted: {

                featuredImageWorker.sendMessage({
                                                    "pageNo": 1,
                                                    "imageType": "featured"
                                                })
                isFeaturedLoading = true
            }
        }
    }
}
