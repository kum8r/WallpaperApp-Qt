import QtQuick 2.0
import org.kde.kirigami 2.4 as Kirigami
import QtQuick.Controls 2.12
import "../js/NetworkInstance.js" as API

GridView {
    property var categoryList

    width: parent.width
    height: parent.height
    cellHeight: 110
    cellWidth: 110
    interactive: false

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
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                applicationWindow().pageStack.layers.push(
                            "qrc:/src/qml/CategoryImageList.qml", {
                                "categoryid": modelData.id
                            })
            }
        }
    }

    model: categoryList

    Component.onCompleted: {
        categoryList = API.getCategoryList()
    }
}
