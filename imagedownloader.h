#ifndef IMAGEDOWNLOADER_H
#define IMAGEDOWNLOADER_H

#include <QByteArray>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QObject>

class ImageDownloader : public QObject
{
    Q_OBJECT
public:
    explicit ImageDownloader(QObject* parent = 0);
    virtual ~ImageDownloader();
    QByteArray downloadedData() const;

    Q_INVOKABLE void setImageUrl(QUrl imageUrl);
    Q_INVOKABLE void download();

signals:
    void downloaded();

private slots:
    void fileDownloaded(QNetworkReply* pReply);
    void imageDownloaded();

private:
    QNetworkAccessManager m_WebCtrl;
    QByteArray            m_DownloadedData;
    QUrl                  imageUrl;

    void    saveFile(QUrl url);
    QString saveFileName(QUrl url);
};

#endif // IMAGEDOWNLOADER_H
