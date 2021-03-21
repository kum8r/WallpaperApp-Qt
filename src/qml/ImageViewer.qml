import QtQuick 2.0
import org.kde.kirigami 2.4 as Kirigami
import com.blackgrain.qml.quickdownload 1.0
import QtQuick.Controls 2.12
import Qt.labs.platform 1.1

Kirigami.Page {
    property var imageSource

    Image {
        id: img
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        horizontalAlignment: Image.AlignHCenter
        verticalAlignment: Image.AlignVCenter
        source: imageSource
    }

    Button {
        text: "Download"
        onClicked: {
            download.start(imageSource)
        }
    }

    Component.onCompleted: {
        sideBar.drawerOpen = false
    }

    onBackRequested: {
        console.log("back requested")
        sideBar.drawerOpen  =true
    }

    Download {
        id: download
        destination: StandardPaths.writableLocation(
                         StandardPaths.DownloadLocation) + "/ImageViewer -"
                     + new Date().toLocaleTimeString(Qt.locale(
                                                         "en_US")) + ".jpg"
        onStarted: console.log('Started download', url)
        onError: console.error("error", errorString, url)
        onProgressChanged: console.log(url, 'progress:', progress)
        onFinished: console.info(url, 'done')
    }
}
