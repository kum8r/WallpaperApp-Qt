#include "imagedownloader.h"

#include <QFile>
#include <QFileInfo>
#include <QStandardPaths>

ImageDownloader::ImageDownloader(QObject* parent) : QObject(parent)
{
    connect(&m_WebCtrl, SIGNAL(finished(QNetworkReply*)), this, SLOT(fileDownloaded(QNetworkReply*)));

    connect(this, &ImageDownloader::downloaded, this, &ImageDownloader::imageDownloaded);
}

ImageDownloader::~ImageDownloader()
{
}

void ImageDownloader::fileDownloaded(QNetworkReply* pReply)
{
    m_DownloadedData = pReply->readAll();
    // emit a signal
    pReply->deleteLater();
    emit downloaded();
}

void ImageDownloader::imageDownloaded()
{
    saveFile(imageUrl);
}

void ImageDownloader::saveFile(QUrl url)
{
    QFile output;

    QString       filename        = saveFileName(url);
    const QString downloadsFolder = QStandardPaths::writableLocation(QStandardPaths::DownloadLocation);

    output.setFileName(downloadsFolder + "/" + filename);
    if(!output.open(QIODevice::WriteOnly))
    {
        return;
    }
    output.write(m_DownloadedData);
}

QString ImageDownloader::saveFileName(QUrl url)
{
    QString path     = url.path();
    QString basename = QFileInfo(path).fileName();

    if(basename.isEmpty())
        basename = "download";

    if(QFile::exists(basename))
    {
        // already exists, don't overwrite
        int i = 0;
        basename += '.';
        while(QFile::exists(basename + QString::number(i)))
            ++i;

        basename += QString::number(i);
    }

    return basename;
}

QByteArray ImageDownloader::downloadedData() const
{
    return m_DownloadedData;
}

void ImageDownloader::setImageUrl(QUrl imageUrl)
{
    this->imageUrl = imageUrl;
}

void ImageDownloader::download()
{
    QNetworkRequest request(imageUrl);
    m_WebCtrl.get(request);

    qDebug() << "download";
}
