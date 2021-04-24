#include "settings.h"

#include <QDateTime>
#include <QDebug>
#include <QDesktopServices>
#include <QDir>
#include <QFileInfo>
#include <QStandardPaths>
#include <QUrl>

Settings::Settings(QObject *parent)
    : QObject(parent)
{
    mSettings = new QSettings(CONFIG_PATH, QSettings::NativeFormat);

    m_downloadDir = QStandardPaths::standardLocations(QStandardPaths::DownloadLocation)[0];
}

QStringList Settings::downloadedFiles() const
{
    return m_downloadedFiles;
}

void Settings::loadDownloadedFiles()
{
    QStringList files;
    if (!m_downloadDir.isEmpty()) {
        QStringList downloadedfiles = mSettings->value("downloadedFiles", QStringList()).toStringList();

        for (int i = 0; i < downloadedfiles.length(); i++) {
            QFileInfo fileinfo(downloadedfiles.at(i));

            if (fileinfo.exists()) {
                files.append(fileinfo.absoluteFilePath());
            }
        }
    }
    setDownloadedFiles(files);
}

void Settings::addDownloadedFiles(QString filename)
{
    filename = filename.remove("file://");
    QFileInfo fileinfo(filename);
    if (fileinfo.exists()) {
        QStringList downloadedfiles = mSettings->value("downloadedFiles", QStringList()).toStringList();
        downloadedfiles.prepend(fileinfo.absoluteFilePath());
        mSettings->setValue("downloadedFiles", downloadedfiles);
        loadDownloadedFiles();
    }
}

void Settings::removeDownloadedFiles(QString filename)
{
    if (m_downloadedFiles.contains(filename)) {
        QStringList downloadedfiles = mSettings->value("downloadedFiles", QStringList()).toStringList();
        downloadedfiles.removeOne(filename);
        mSettings->setValue("downloadedFiles", downloadedfiles);
        loadDownloadedFiles();
    }
}

void Settings::openFile(QString filename)
{
    QFileInfo fileinfo(filename);

    if (fileinfo.exists()) {
        QDesktopServices::openUrl(fileinfo.absoluteFilePath());
    }
}

QString Settings::getFilename()
{
    QString filename = "file://" + m_downloadDir + "/QWall-" + QString::number(QDateTime().currentMSecsSinceEpoch()) + ".jpg";
    qDebug() << filename;
    return filename;
}

QString Settings::downloadDir() const
{
    return m_downloadDir;
}

void Settings::setDownloadedFiles(QStringList downloadedFiles)
{
    if (m_downloadedFiles == downloadedFiles)
        return;

    m_downloadedFiles = downloadedFiles;
    emit downloadedFilesChanged(m_downloadedFiles);
}

void Settings::setDownloadDir(QString downloadDir)
{
    if (m_downloadDir == downloadDir)
        return;

    m_downloadDir = downloadDir;
    emit downloadDirChanged(m_downloadDir);
}
