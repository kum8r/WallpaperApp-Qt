import QtQuick 2.0
import org.kde.kirigami 2.13 as Kirigami
import QtQuick.Controls 2.12

Kirigami.Page {

    property var categoryList
    property bool isSubCategory
    property string subCategoryId

    ListView {

        width: parent.width
        height: parent.height

        Kirigami.PlaceholderMessage {

            anchors.centerIn: parent
            width: parent.width - (Kirigami.Units.largeSpacing * 4)
            visible: categoryList.length === 0

            BusyIndicator {}
        }

        delegate: Kirigami.BasicListItem {

            onDoubleClicked: {
                applicationWindow().pageStack.layers.push(
                            "qrc:/src/qml/CategoryImageList.qml", {
                                "categoryid": modelData.id
                            })
            }

            contentItem: Kirigami.Heading {

                level: 4
                text: modelData.name
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }

        model: categoryList

        WorkerScript {
            id: imageWorker2
            source: "qrc:/src/js/NetworkInstance.js"

            onMessage: {
                var list = messageObject.list
                categoryList = list
            }
        }

        Component.onCompleted: {

            if (!isSubCategory) {
                imageWorker2.sendMessage({
                                             "imageType": "categorylist"
                                         })
            } else {

                imageWorker2.sendMessage({
                                             "imageType": "subcategorylist",
                                             "categoryId": categoryId
                                         })
            }
        }
    }
}
