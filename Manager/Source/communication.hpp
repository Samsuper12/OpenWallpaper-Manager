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

#ifndef PLUGINCOMMINICATION_HPP
#define PLUGINCOMMINICATION_HPP

#include "debug.hpp"
#include "dbus_manager_interface.h"

class Communication : public QObject
{
    Q_OBJECT
    Q_CLASSINFO("D-Bus Interface", "org.OpenWallpaper.DBusManager")
    Q_PROPERTY(double pluginVolume READ getPluginVolume NOTIFY pluginVolumeChanged)

public:
    explicit Communication(QObject *parent = nullptr);
    ~Communication();

    const org::OpenWallpaper::DBusManager* getClient() const { return dbusClient;}

public slots:
    void play(int arg);
    void volume(double volume);
    void changePackage(QString package);
    void debug(QString arg);
    void changeConfig(int param, QString value);
    void restoreConfig();
    void lastPackageRequest();

signals:
    void pluginVolumeChanged();

private:
    double getPluginVolume() const {return pluginVolume;}

private:
    org::OpenWallpaper::DBusManager* dbusClient;
    double pluginVolume = 0;
};

#endif // PLUGINCOMMINICATION_HPP
