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

#include "settings.hpp"

Settings::Settings(Communication *clientPtr, QObject *parent) :
    QObject(parent),
    client(clientPtr),
    mainDir(QDir::home())
{
  if (!QDir::home().exists(shared::WP_MAIN_DIR_NAME)) {
      LOG("Cannot find the main directory.")
      client->restoreConfig();
  }

  parser.findValue("IgnoreDefaultVolume",
                   "CopyToHiddenPlace",
                   "AlwaysInFocus",
                   "MusicCycle");

  connect(client->getClient(), &org::OpenWallpaper::DBusManager::restoreSuccessfulSignal, [&]() {
      mainDir = QDir(QDir::homePath() + '/' + shared::WP_MAIN_DIR_NAME);
      update();
  });

  mainDir.cd(shared::WP_MAIN_DIR_NAME);
  update();
}

Settings::~Settings()
{

}

void Settings::setAIF(bool value)
{
    alwaysInFocus = value;
    QString strValue = value ? "True" : "False";
    client->changeConfig(sendValue::alwaysInFocusRole, strValue);
    parser.replace("AlwaysInFocus", strValue.toStdString());
    emit aifChanged();
}

void Settings::setMC(bool value)
{
    musicCycle = value;
    QString strValue = value ? "True" : "False";
    client->changeConfig(sendValue::musicCycleRole, strValue);
    parser.replace("MusicCycle", strValue.toStdString());
    emit musicCycleChanged();
}

void Settings::setIDV(bool value)
{
    ignoreDefaultVolume = value;
    QString strValue = value ? "True" : "False";
    client->changeConfig(sendValue::ignoreDefaultVolumeRole, strValue);
    parser.replace("IgnoreDefaultVolume", strValue.toStdString());
    emit idvChanged();
}

void Settings::setCTHP(bool value)
{
    copyToHiddenPlace = value;
    QString strValue = value ? "True" : "False";
    parser.replace("CopyToHiddenPlace", strValue.toStdString());
    emit cthpChanged();
}

void Settings::update()
{
    if (!parser.open(mainDir.path().toStdString() + '/' + shared::WP_SETTINGS_CONFIG_NAME)) {
        client->restoreConfig();
        LOG("Cannot find settings file.")
        return;
    }

    try {

        ignoreDefaultVolume = parser["IgnoreDefaultVolume"] == "True" ? 1.0 : 0.0;
        copyToHiddenPlace = parser["CopyToHiddenPlace"] == "True" ? 1.0 : 0.0;
        alwaysInFocus = parser["AlwaysInFocus"] == "True" ? 1.0 : 0.0;
        musicCycle = parser["MusicCycle"] == "True" ? 1.0 : 0.0;

    } catch (const std::exception& e) {
        LOG(e.what())
    }

    emit dataChanged();
}
