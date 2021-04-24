import QtQuick 2.0
import org.kde.kirigami 2.15 as Kirigami
import QtQuick.Controls 2.15

Kirigami.OverlaySheet {

    header: Kirigami.Heading {
        text: "About QWall"
    }

    contentItem: Kirigami.Heading {

        level: 4
        text: "<h1>QWall </h1>
<p>by kum8r</p>
<p> Image Downloader using Qt</p>
<p><a href='https://wall.alphacoders.com'> Powered By Wallpaper Abyss </a></p>"
    }
}
