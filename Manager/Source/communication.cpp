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

#include "communication.hpp"
#include <QDebug>

Communication::Communication(QObject *parent)
    : QObject(parent)
{
    dbusClient = new org::OpenWallpaper::DBusManager("org.OpenWallpaper.DBusManager", "/DBusManager", QDBusConnection::sessionBus(), this);

    if (!dbusClient) {
        LOG("Cannot connect to plugin.")
    }

    connect(dbusClient, &org::OpenWallpaper::DBusManager::volumeToManagerSignal, this, [&] (double value) {
        pluginVolume = value;
        emit pluginVolumeChanged();
    });

    dbusClient->getVolumeRequestSlot();
}

Communication::~Communication()
{
    delete dbusClient;
}

void Communication::play(int arg)
{
   dbusClient->setPlaySlot(arg);
}

void Communication::volume(double volume)
{
    dbusClient->setVolumeSlot(volume/100);
}

void Communication::changePackage(QString package)
{
    dbusClient->setPackageSlot(package);
}

void Communication::debug(QString arg)
{
    dbusClient->debugSlot(arg);
}

void Communication::changeConfig(int param, QString value)
{
    dbusClient->changeConfigSlot(param, value);
}

void Communication::restoreConfig()
{
    dbusClient->restoreConfigSlot();
}

void Communication::lastPackageRequest()
{
    dbusClient->getLastPackageRequestSlot();
}
