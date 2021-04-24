import QtQuick 2.0
import org.kde.kirigami 2.15 as Kirigami
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Kirigami.OverlaySheet {
    property var downloadedList

    header: Kirigami.Heading {
        text: "Downloads"
    }

    ListView {

        delegate: Kirigami.BasicListItem {
            contentItem: RowLayout {
                Kirigami.Heading {
                    level: 4
                    text: modelData
                    Layout.fillWidth: true
                }

                ButtonGroup {
                    buttons: column.children
                }

                Row {
                    id: column

                    Button {
                        icon.name: "document-open"
                        onClicked: {
                            settings.openFile(modelData)
                        }
                    }

                    Button {
                        icon.name: "delete"
                        onClicked: {
                            settings.removeDownloadedFiles(modelData)
                        }
                    }
                }
            }
        }

        Connections {
            target: settings

            function onDownloadedFilesChanged(downloadedlist) {
                downloadedList = downloadedlist
            }
        }

        model: downloadedList

        Component.onCompleted: {
            settings.loadDownloadedFiles()
        }
    }
}
