import QtQuick 2.0
import org.kde.kirigami 2.4 as Kirigami
import QtQuick.Layouts 1.15
import "NetworkInstance.js" as API
import QtQuick.Controls 2.4

Kirigami.ScrollablePage {

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
            property var list: API.getPopularImagesThumb(1)
            url_thumbs: list
            Layout.fillWidth: true

            footer: Rectangle {
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
        }

        Kirigami.Heading {
            text: "Newest Wallpapers"
            level: 3
        }

        ImageList {
            property var list: API.getNewestImagesThumb(1)
            url_thumbs: list
            Layout.fillWidth: true

            footer: Rectangle {
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
        }

        Kirigami.Heading {
            text: "Featured Wallpapers"
            level: 3
        }

        ImageList {
            property var list: API.getFeaturedImagesThumb(1)
            url_thumbs: list
            Layout.fillWidth: true

            footer: Rectangle {
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
        }

    }
}
