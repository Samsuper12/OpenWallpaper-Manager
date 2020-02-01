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

#ifndef PACKAGEMANAGER_HPP
#define PACKAGEMANAGER_HPP

#include "debug.hpp"
#include "communication.hpp"
#include "package_model.hpp"

class PackageManager : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString package READ getPackagePath WRITE setPackage NOTIFY packageChanged)
    Q_PROPERTY(QString packageName READ getPackageName NOTIFY nameChanged)

public:
    explicit PackageManager(PackageModel* modelRef, Communication* obj, QObject *parent = nullptr);

    Q_INVOKABLE void stepTo(const int value);

signals:
    void packageChanged();
    void nameChanged();

public slots:
    void setPathSlot(QString pathFromPlugin);

private:
    QString getPackageName() const {return packageName;}
    QString getPackagePath() const {return packagePath;}

    void setPackage(const QString& pathToPackage);
    void changeName(const QString& pathRole);

private:
    PackageModel* model;
    Communication* client;

    int indexInModel = 0;
    QString packagePath;
    QString packageName;
};

#endif // PACKAGEMANAGER_HPP
