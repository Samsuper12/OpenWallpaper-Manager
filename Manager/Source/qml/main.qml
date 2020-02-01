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

import QtQuick 2.12
import QtQuick.Window 2.12 as QQW

QQW.Window {
    id: superRoot
    visible: true
    width: 750
    height: 480
    minimumHeight: height
    minimumWidth: width

    title: qsTr("Wallpaper Manager")

    property int mainWinHeight: height;
    property int mainWinWidth: width;
    property int mainWinX: x;
    property int mainWinY: y;

    Connections {
        target: pluginCommunication

        onPluginVolumeChanged: {
            popupPlayback.setVolume(pluginCommunication.pluginVolume * 100.0);
        }
    }

    Rectangle {
        id: root;
        anchors.fill: parent;

        PackageGrid {
            id: pkgGrid
            anchors.top:  parent.top;
            anchors.bottom : bottomBar.top;
            width: parent.width
        }

        BottomBar {
            id: bottomBar;
            anchors.bottom: parent.bottom
            width: parent.width;
            height: 25;
            color: "white"
        }

        PlaybackPopup {
            id: popupPlayback
            width: 200
            height: 75                                    // replace
            x: bottomBar.settingsButtonRef.x - width;
            y: (parent.height - height) - (bottomBar.height + 5)

            modal: true
            opacity: 0.1
        }

        InfoPopup {
            id: popupPackageInfo;
            width: parent.width /2;
            height: parent.height /1.3;
            x:  (parent.width /2) - (width/2);
            y: 60

            modal: true;
        }
    }
}
