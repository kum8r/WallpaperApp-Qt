import QtQuick 2.0

Rectangle {
    function onCategoryClicked(index) {}
    property var categoryList

    width: parent.width
    height: parent.height

    GridView {

        width: parent.width
        height: parent.height
        cellHeight: 110
        cellWidth: 110

        delegate: Rectangle {
            width: 100
            height: 50
            color: "green"

            Text {
                text: modelData.name
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
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
