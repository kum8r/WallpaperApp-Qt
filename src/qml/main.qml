import QtQuick 2.1
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.13 as Kirigami

Kirigami.ApplicationWindow {
    id: root
    width: 1000
    height: 700

    globalDrawer: Kirigami.GlobalDrawer {
        id: sideBar
        drawerOpen: true
        modal: false
        width: root.width * 0.3

        actions: [
            Kirigami.Action {
                text: "Home"
                onTriggered: {
                    while (!main.isCurrentPage) {
                        applicationWindow().pageStack.layers.pop()
                    }
                    stack.currentIndex = 0
                }
            },

            Kirigami.Action {
                text: "Newest Wallpapers"
                onTriggered: {
                    while (!main.isCurrentPage) {
                        applicationWindow().pageStack.layers.pop()
                    }
                    stack.currentIndex = 3
                }
            },

            Kirigami.Action {
                text: "Featured Wallpapers"
                onTriggered: {
                    while (!main.isCurrentPage) {
                        applicationWindow().pageStack.layers.pop()
                    }

                    stack.currentIndex = 1
                }
            },

            Kirigami.Action {
                text: "Popular Wallpapers"
                onTriggered: {
                    while (!main.isCurrentPage) {
                        applicationWindow().pageStack.layers.pop()
                    }

                    stack.currentIndex = 2
                }
            },

            Kirigami.Action {
                text: "Categories"
                onTriggered: {
                    while (!main.isCurrentPage) {
                        applicationWindow().pageStack.layers.pop()
                    }
                    stack.currentIndex = 4
                }
            },

            Kirigami.Action {
                text: "Search"
                onTriggered: {
                    while (!main.isCurrentPage) {
                        applicationWindow().pageStack.layers.pop()
                    }
                    stack.currentIndex = 5
                }
            }
        ]
    }

    menuBar: MenuBar {
        Menu {
            title: qsTr("&File")

            Kirigami.Action {
                text: qsTr("&Downloads")
                onTriggered: downloadDialog.open()
            }

            Menu {
                title: qsTr("&Style")

                Kirigami.Action {
                    text: "Default"
                }

                Kirigami.Action {
                    text: "Material"
                }
            }

            MenuSeparator {}

            Kirigami.Action {
                text: qsTr("&Quit")
                onTriggered: {
                    Qt.quit()
                }
            }
        }
        Menu {
            title: qsTr("&Help")
            Action {
                text: qsTr("&About")
            }
        }
    }

    pageStack.initialPage: main

    Kirigami.Page {
        id: main

        actions {
            contextualActions: [
                Kirigami.Action {
                    text: "Downloads"
                    icon.name: "download"
                    onTriggered: downloadDialog.open()
                }
            ]
        }

        StackLayout {
            width: parent.width
            height: parent.height
            id: stack
            currentIndex: 0
            property var catId: 0

            HomePage {}

            ImageGridList {
                image_type: "featured"
            }

            ImageGridList {
                image_type: "popular"
            }

            ImageGridList {
                image_type: "newest"
            }

            CategoryList {}

            SearchPage {}
        }
    }

    DownloadDialog {
        id: downloadDialog
    }
}
