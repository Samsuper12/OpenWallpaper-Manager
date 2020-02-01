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

#ifndef PACKAGEMODEL_H
#define PACKAGEMODEL_H

#include <QAbstractListModel>
#include <QList>
#include <QVariant>
#include <QUrl>

#include "debug.hpp"
#include "shared.hpp"
#include "communication.hpp"
#include "config_parser.hpp"

class PackageModel : public QAbstractListModel
{
    Q_OBJECT

    struct Package {
        QString type;
        QString name;
        QString author;
        QString version;
        QString email;
        QString authorLink;
        QUrl previewImage;
        QString path;
        QString comment;
    };

public:
    enum PackageData : int {
        TypeRole = Qt::UserRole + 1,
        NameRole,
        VersionRole,
        AuthorRole,
        EmailRole,
        AuthorLinkRole,
        PreviewImageRole,
        PathRole,
        CommentRole
    };

public:
    PackageModel(Communication* clientPtr, QObject* parent = nullptr);
    ~PackageModel();

    Q_INVOKABLE void insert(QString path, const bool copy = false);
    Q_INVOKABLE void remove(const int index);
    Q_INVOKABLE void updateAll();

    int rowCount(const QModelIndex& parent = QModelIndex()) const ;
    int findByPath(const QString& path) const;

    QVariant data(const QModelIndex& index, int role = Qt::DisplayRole) const;
    QString getStrRole(const int index, const int role) const;

signals:
    void updateSignal();

private:
    void addPackage(const Package& data);
    void copyDir(QString& from, const QString& to);
    void deleteDir(QString path);

protected:
    QHash<int, QByteArray> roleNames() const;

private:
    Communication* client;
    QList<Package> packages;
    ConfigParser parser;
    QDir mainDir;
};


#endif // PACKAGEMODEL_H
