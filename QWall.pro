QT += quick
QT += network
CONFIG+=qtquickcompiler
CONFIG += c++14

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        src/main.cpp \

RESOURCES += qml.qrc


include(ThirdParty/QuickDownload/quickdownload.pri)

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =


linux {

    isEmpty(PREFIX): PREFIX = /usr
    DATADIR = $${PREFIX}/share

    # install desktop file
    desktop.path = $${DATADIR}/applications
    desktop.files += QWall.desktop

    iconpng.path = $${DATADIR}/icons/hicolor/scalable/apps
    iconpng.files = QWall.png

    # install application
    target.path = $${PREFIX}/bin

    INSTALLS += target desktop  iconpng
    message("The project will be installed in prefix $${PREFIX}")

}

DISTFILES += \
    QWall.desktop \
    QWall.png

