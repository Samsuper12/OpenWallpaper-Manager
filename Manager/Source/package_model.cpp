/*
 * This file is part of OpenWallpaper Manager.
 * 
 * OpenWallpaper Manager is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * OpenWallpaper Manager is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * Full license: https://github.com/Samsuper12/OpenWallpaper-Manager/blob/master/LICENSE
 * Copyright (C) 2020- by Michael Skorokhodov bakaprogramm29@gmail.com
 */

#include "package_model.hpp"


PackageModel::PackageModel(Communication* clientPtr, QObject *parent)
    : QAbstractListModel(parent)
    , client(clientPtr)
    , mainDir(QDir::home())
{

    if (!QDir::home().exists(shared::WP_MAIN_DIR_NAME)) {
        client->restoreConfig();
    }

    parser.findValue("Name",
                     "Version",
                     "Author",
                     "Email",
                     "AuthorLink",
                     "Type",
                     "PreviewImage",
                     "Comment");

    connect(client->getClient(), &org::OpenWallpaper::DBusManager::restoreSuccessfulSignal, [&]() {
        mainDir = QDir(QDir::homePath() + '/' + shared::WP_MAIN_DIR_NAME);
        updateAll();
    });

    mainDir.cd(shared::WP_MAIN_DIR_NAME);
    updateAll();
}

PackageModel::~PackageModel()
{
}

void PackageModel::insert(QString path, const bool copy)
{
    parser.clear();
    
    if (copy) {
        copyDir(path, mainDir.path());
        updateAll();
        return;
    }

    if (!parser.open(path.toStdString())) {
        LOG("Cannot open the package file.")
        return;
    }

    Package buf;
    buf.path = path;
    buf.name = QString(parser["Name"].c_str());
    buf.type = QString(parser["Type"].c_str());
    buf.author = QString(parser["Author"].c_str());
    buf.version = QString(parser["Version"].c_str());
    buf.authorLink = QString(parser["AuthorLink"].c_str());
    buf.email = QString(parser["Email"].c_str());
    buf.comment = QString(parser["Comment"].c_str());

    path.remove(shared::WP_PACKAGE_CONFIG_NAME);

    buf.previewImage = QString(shared::WP_QML_PREFIX + path + parser["PreviewImage"].c_str());

    addPackage(buf);
}

void PackageModel::remove(const int index)
{
    deleteDir(packages.at(index).path);

    beginRemoveRows(QModelIndex(), index, index);
    packages.removeAt(index);
    endRemoveRows();
}

void PackageModel::updateAll()
{

    if (!QDir::home().exists(shared::WP_MAIN_DIR_NAME)) {
        client->restoreConfig();
        LOG("Cannot find the main directory.")
        return;
    }

    if (mainDir.dirName() != shared::WP_MAIN_DIR_NAME) {
        if (!mainDir.cd(QDir::homePath() + '/' + shared::WP_MAIN_DIR_NAME)) {
            LOG("Cannot find the main directory.")
            return;
        }
    }

    const QStringList& packageDirs = mainDir.entryList(QDir::Dirs | QDir::NoDotAndDotDot);

    if (rowCount() > 0) {
        beginRemoveRows(QModelIndex(), 0, rowCount());
        packages.clear();
        endRemoveRows();
    }

    if (!packageDirs.empty()) {
        for (auto itt = packageDirs.cbegin(); itt != packageDirs.cend(); ++itt) {
            insert(mainDir.path() + '/' + *itt + '/' + shared::WP_PACKAGE_CONFIG_NAME, false);
        }
    }

    emit updateSignal();
}

int PackageModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return packages.count();
}


void PackageModel::addPackage(const Package& data)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    packages << data;
    endInsertRows();
}

void PackageModel::copyDir(QString& from, const QString &to)
{
    from.remove(QString() + '/' + shared::WP_PACKAGE_CONFIG_NAME);

    if (!QDir::home().exists(shared::WP_MAIN_DIR_NAME)) {
       client->restoreConfig();
       LOG("Cannot find the main directory")
       return;
    }

    if (from.isNull() || to.isNull()) {
        LOG("Empty path to copy directory or to the main directory.")
        return;
    }

    if (from == mainDir.path() || from == QDir::homePath()) {
        LOG("Incorrect copy path.")
        return;
    }

    char* cmd = new char[from.size() + to.size() + 7]{};

    std::strcat(cmd, shared::WP_CP_COMMAND);
    std::strcat(cmd, " ");
    std::strcat(cmd, from.toLatin1().data());
    std::strcat(cmd, " ");
    std::strcat(cmd, to.toLatin1().data());

    if (std::system(cmd) > 0) {
        LOG("Command line throw the error in copy time.")
    }

    delete[] cmd;
}

void PackageModel::deleteDir(QString path)
{
    path.remove(QString() + '/' + shared::WP_PACKAGE_CONFIG_NAME);

    if (!QDir::home().exists(shared::WP_MAIN_DIR_NAME)) {
       client->restoreConfig();
       LOG("Cannot find the main directory")
       return;
    }

    if (path.isNull()) {
        LOG("Empty directory path for delete")
        return;
    }

    if (!QDir::root().exists(path)) {
        LOG("Cannot find directory for delete.")
        return;
    }

    if (path == mainDir.path() || path == QDir::homePath()) {
        LOG("Incorrect directory for delete.")
        return;
    }

    if (!path.contains(mainDir.path())) {
        // log
        // maybe add option for that?.. yep. Later.
        return;
    }

    char* cmd = new char[path.size() + 7]{};

    std::strcat(cmd, shared::WP_RM_COMMAND);
    std::strcat(cmd, " ");
    std::strcat(cmd, path.toLatin1().data());

    if (std::system(cmd) > 0) {
        LOG("Command line throw the error when tried delete dir.")
    }

    delete[] cmd;
}

QHash<int, QByteArray> PackageModel::roleNames() const
{
    QHash<int, QByteArray> ret;

    ret[TypeRole] = "type";
    ret[NameRole] = "name";
    ret[VersionRole] = "version";
    ret[AuthorRole] = "author";
    ret[EmailRole] = "email";
    ret[AuthorLinkRole] = "link";
    ret[PreviewImageRole] = "previewImage";
    ret[PathRole] = "path";
    ret[CommentRole] = "comment";

    return ret;
}

QVariant PackageModel::data(const QModelIndex& index, int role) const
{
    if (index.row() < 0 || index.row() >= packages.count()) {
        return QVariant();
    }

    const Package& ret = packages[index.row()];

    switch(role) {

    case TypeRole:
        return ret.type;
    case NameRole:
        return ret.name;
    case AuthorRole:
        return ret.author;
    case VersionRole:
        return ret.version;
    case EmailRole:
        return ret.email;
    case AuthorLinkRole:
        return ret.authorLink;
    case PreviewImageRole:
        return ret.previewImage;
    case PathRole:
        return ret.path;
    case CommentRole:
        return ret.comment;
    default:
        return QVariant();
    }
}

int PackageModel::findByPath(const QString &path) const
{
    for (int itt = 0; itt < packages.count(); ++itt) {
        if (packages.at(itt).path == path) {
            return itt;
        }
    }

    LOG("Unknown package.")
    return -1;
}

QString PackageModel::getStrRole(const int index, const int role) const
{

    if (index < 0 || index >= packages.count()) {
        return QString();
    }

    const Package& ret = packages[index];

    switch(role) {
    case TypeRole:
        return ret.type;
    case NameRole:
        return ret.name;
    case AuthorRole:
        return ret.author;
    case VersionRole:
        return ret.version;
    case EmailRole:
        return ret.email;
    case AuthorLinkRole:
        return ret.authorLink;
    case PreviewImageRole:
        return ret.previewImage.toString();
    case PathRole:
        return ret.path;
    case CommentRole:
        return ret.comment;
    default:
        return QString();
    }
}
