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

#include "package_manager.hpp"

PackageManager::PackageManager(PackageModel* modelRef, Communication* clientPtr, QObject *parent)
    : QObject(parent)
    , model(modelRef)
    , client(clientPtr)
{
    client->lastPackageRequest();

    connect(client->getClient(),  &org::OpenWallpaper::DBusManager::lastPackageSignal,
            this, &PackageManager::setPathSlot);

    connect(model, &PackageModel::updateSignal, this, [&](){

        packagePath.clear();
        client->lastPackageRequest();
    });
}

void PackageManager::setPackage(const QString& pathToPackage)
{
    client->changePackage(pathToPackage);
    this->packagePath = pathToPackage;

    changeName(pathToPackage);

    emit packageChanged();
}

void PackageManager::stepTo(const int value)
{
    const int step = indexInModel + value;

    if ( step < 0 || step >= model->rowCount() ) {
        LOG("Incorrect value");
        return;
    }

    const QString& nextPath = model->getStrRole(step, model->PathRole);

    if (nextPath.isNull()) {
        LOG("Path is NULL");
        return;
    }

    setPackage(nextPath);
}

void PackageManager::setPathSlot(QString pathFromPlugin)
{
    this->packagePath = pathFromPlugin;
    changeName(pathFromPlugin);
}

void PackageManager::changeName(const QString& pathRole)
{
    indexInModel = model->findByPath(pathRole);

    if (indexInModel == -1) {
        packageName.clear();

    } else {
        packageName = model->getStrRole(indexInModel, model->NameRole);
    }

    emit nameChanged();
}
