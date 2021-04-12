import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.4 as Kirigami
import "../js/NetworkInstance.js" as API

Kirigami.Page {
    property var pageNo: 1

    ColumnLayout {
        anchors.fill: parent
        RowLayout {
            width: parent.width

            Rectangle {
                Layout.fillWidth: true
                border.width: 3
                border.color: "#4b4b4b"
                color: "lightsteelblue"
                radius: 5
                TextInput {
                    id: searchBar
                    text: "Search..."
                    focus: true
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        text2.selectAll()
                    }
                }
            }

            Button {
                text: "Search"
                onClicked: {
                    pageNo = 1
                    getImages()
                }
            }
        }

        GridView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            cellHeight: 110
            cellWidth: 210

            onAtYEndChanged: {
                if (imageGridList.atYEnd) {
                    pageNo++
                    getImages()
                }
            }

            delegate: Kirigami.AbstractCard {
                width: 200
                height: 100

                contentItem: Image {
                    width: 200
                    height: 100
                    source: model.url_thumb

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            applicationWindow().pageStack.layers.push(
                                        "qrc:/src/qml/ImageViewer.qml", {
                                            "imageSource": model.url_image,
                                            "id": model.id
                                        })
                        }
                    }
                }
            }

            model: ListModel {
                id: searchModel
            }
        }
    }

    function getImages() {
        searchModel.clear()
        var url_thumbs = API.searchWallpaper(searchBar.text, pageNo)

        searchModel.append(url_thumbs)
    }
}
