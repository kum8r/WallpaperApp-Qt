import org.kde.kirigami 2.4 as Kirigami
import QtQuick.Controls 2.12
import QtQuick 2.0
import QtQuick.Layouts 1.15
import "../js/NetworkInstance.js" as API

Kirigami.Page {
    property var categoryid

    header: Button {
        text: "Sub Category"

        onClicked: {


            applicationWindow().pageStack.layers.push(
                        "qrc:/src/qml/CategoryList.qml", {
                            "isSubCategory": true,
                            "subCategoryId": categoryid
                        })
        }
    }

    ImageGridList {
        width: parent.width
        height: parent.height
        categoryId: categoryid
        image_type: "category"
    }
}
