import org.kde.kirigami 2.4 as Kirigami
import QtQuick.Controls 2.12
import QtQuick 2.0
import QtQuick.Layouts 1.15
import "../js/NetworkInstance.js" as API

Kirigami.Page {
    property var categoryid

    Column {
        width: parent.width
        height: parent.height
        GridView {
            property var categoryList

            width: parent.width
            height: parent.height * .30
            //        height: model.length * 50
            cellHeight: 110
            cellWidth: 110

            ScrollBar.vertical: ScrollBar {}

            delegate: Rectangle {

                width: 100
                height: 50
                radius: 5
                color: Kirigami.Theme.backgroundColor
                border.color: Kirigami.Theme.highlightColor

                Kirigami.Heading {
                    level: 4
                    text: modelData.name
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        applicationWindow().pageStack.layers.push(
                                    "qrc:/src/qml/SubCategoryImageList.qml", {
                                        "categoryid": modelData.id
                                    })
                    }
                }
            }

            model: categoryList

            Component.onCompleted: {
                categoryList = API.getSubCategoryList(categoryid)
            }
        }

        ImageGridList {
            width: parent.width
            height: parent.height
            categoryId: categoryid
            image_type: "category"
        }
    }
}
