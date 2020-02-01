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

#ifndef SETTINGSMODEL_H
#define SETTINGSMODEL_H

#include "debug.hpp"
#include "shared.hpp"
#include "communication.hpp"
#include "config_parser.hpp"

class Settings : public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool IgnoreDefaultVolume READ getIDV WRITE setIDV NOTIFY idvChanged)
    Q_PROPERTY(bool CopyToHiddenPlace READ getCTHP WRITE setCTHP NOTIFY cthpChanged)
    Q_PROPERTY(bool AlwaysInFocus READ getAIF WRITE setAIF NOTIFY aifChanged)
    Q_PROPERTY(bool MusicCycle READ getMC WRITE setMC NOTIFY musicCycleChanged)

    enum sendValue : int {
        alwaysInFocusRole = 0,
        ignoreDefaultVolumeRole,
        musicCycleRole
    };

public:
    Settings(Communication* clientPtr, QObject* parent = nullptr );
    ~Settings();

    Q_INVOKABLE void update();

    bool getIDV() const { return ignoreDefaultVolume;}
    bool getCTHP() const {return copyToHiddenPlace;}
    bool getAIF() const { return alwaysInFocus;}
    bool getMC() const { return musicCycle;}

    void setIDV(bool value);
    void setCTHP(bool value);
    void setAIF(bool value);
    void setMC(bool value);

signals:
    void idvChanged() const;
    void cthpChanged() const;
    void aifChanged() const;
    void musicCycleChanged() const;

    void dataChanged() const;

private:
    bool ignoreDefaultVolume = 0;
    bool copyToHiddenPlace = 0;
    bool alwaysInFocus = 0;
    bool musicCycle = 0;

private:
    ConfigParser parser;
    Communication* client;
    QDir mainDir;
};


#endif // SETTINGSMODEL_H
