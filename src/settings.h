#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>
#include <QSettings>

#define HOME_PATH QString(QDir::homePath())
#define CONFIG_PATH QString(HOME_PATH + "/.config/QWall")

class Settings : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList downloadedFiles READ downloadedFiles WRITE setDownloadedFiles NOTIFY downloadedFilesChanged)
    Q_PROPERTY(QString downloadDir READ downloadDir WRITE setDownloadDir NOTIFY downloadDirChanged)
public:
    explicit Settings(QObject *parent = nullptr);

    QStringList downloadedFiles() const;

    Q_INVOKABLE void loadDownloadedFiles();
    Q_INVOKABLE void addDownloadedFiles(QString filename);
    Q_INVOKABLE void removeDownloadedFiles(QString filename);
    Q_INVOKABLE void openFile(QString filename);
    Q_INVOKABLE QString getFilename();

    QString downloadDir() const;

public slots:
    void setDownloadedFiles(QStringList downloadedFiles);

    void setDownloadDir(QString downloadDir);

signals:

    void downloadedFilesChanged(QStringList downloadedFiles);

    void downloadDirChanged(QString downloadDir);

private:
    QSettings *mSettings;
    QStringList m_downloadedFiles;
    QString m_downloadDir;
};

#endif // SETTINGS_H
