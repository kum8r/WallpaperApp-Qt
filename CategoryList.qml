import QtQuick 2.0
import org.kde.kirigami 2.9 as Kirigami

Rectangle {
    function onCategoryClicked(index) {}
    property var categoryList

    width: parent.width
    height: parent.height
    color: Kirigami.Theme.backgroundColor

    GridView {

        width: parent.width
        height: parent.height
        cellHeight: 110
        cellWidth: 110

        delegate: Rectangle {
            width: 100
            height: 50
            border.color: Kirigami.Theme.highlightColor
            radius: 5
            color: Kirigami.Theme.backgroundColor

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
                    onCategoryClicked(index)

                }
            }
        }

        model: categoryList
    }
}
