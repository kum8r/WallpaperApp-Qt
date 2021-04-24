import QtQuick 2.0
import org.kde.kirigami 2.4 as Kirigami
import com.blackgrain.qml.quickdownload 1.0
import QtQuick.Controls 2.12
import Qt.labs.platform 1.1
import "../js/NetworkInstance.js" as API

Kirigami.Page {
    property var imageSource
    property var id
    property string filename

    ProgressBar {
        id: imgProgress
        value: img.progress
        width: parent.width
    }

    Image {
        id: img
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        horizontalAlignment: Image.AlignHCenter
        verticalAlignment: Image.AlignVCenter
        source: imageSource

        onProgressChanged: {
            if (img.progress == 1) {
                imgProgress.visible = false
            }
        }
    }

    Rectangle {
        id: infoRect
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: 250
        color: "gray"
        opacity: 0.8

        Component {
            id: infoDelegate

            Rectangle {
                height: 30
                width: valusView.width
                color: "transparent"

                Rectangle {
                    id: tagName
                    width: 100
                    height: parent.height
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    color: "transparent"

                    Kirigami.Heading {
                        level: 4
                        width: parent.width
                        height: parent.height
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        horizontalAlignment: Text.AlignRight
                        verticalAlignment: Text.AlignVCenter
                        color: "white"
                        wrapMode: Text.WordWrap
                        text: model.name + ": "
                    }
                }

                Rectangle {
                    width: parent.width - tagName.width - 5
                    height: parent.height - 4
                    anchors.left: tagName.right
                    anchors.verticalCenter: parent.verticalCenter
                    color: "transparent"

                    Kirigami.Heading {
                        level: 4
                        id: valueEdit
                        width: parent.width
                        height: parent.height
                        anchors.centerIn: parent
                        horizontalAlignment: TextEdit.AlignLeft
                        verticalAlignment: TextEdit.AlignVCenter
                        color: "white"

                        text: model.value
                    }
                }
            }
        }

        ListView {
            id: valusView
            clip: true
            anchors.fill: parent
            width: parent.width
            model: ListModel {
                id: infoModel
            }

            footer: Button {
                text: "Download"
                onClicked: {
                    filename = settings.getFilename()

                    download.start(imageSource)
                }
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                width: 200
                height: 30
            }

            delegate: infoDelegate
        }
    }

    Component.onCompleted: {
        sideBar.drawerOpen = false
        var info = API.getWallpaperInfo(id)
        infoModel.append({
                             "name": "name",
                             "value": info.name
                         })
        infoModel.append({
                             "name": "width",
                             "value": info.width
                         })
        infoModel.append({
                             "name": "height",
                             "value": info.height
                         })
        infoModel.append({
                             "name": "file size",
                             "value": info.file_size
                         })
    }

    onBackRequested: {
        sideBar.drawerOpen = true
    }

    Download {
        id: download
        destination: filename
        onStarted: console.log('Started download', url)
        onError: console.error("error", errorString, url)
        onProgressChanged: console.log(url, 'progress:', progress)
        onFinished: {
            console.info(url, 'done')
            settings.addDownloadedFiles(download.destination)
        }
    }
}
