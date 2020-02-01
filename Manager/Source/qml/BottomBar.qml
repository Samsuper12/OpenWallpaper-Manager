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
import QtQuick.Dialogs 1.3 as QQD

Rectangle {

    property variant addButtonRef: addButton
    property variant updateButtonRef: updateButton
    property variant settingsButtonRef: settingsButton
    property variant playbackButtonRef: playbackButton
    property variant currentPlayTextRef: currentPlayText

    property variant settingsWinHandle;

    Image {
        id: addButton;
        anchors.left: parent.left;
        height: parent.height -3
        width: 45;

        fillMode: Image.PreserveAspectFit
        source: "file:///usr/share/openwallpaper-manager/icons/Adwaita/scalable/places/folder-documents-symbolic.svg"

        MouseArea {
            anchors.fill: parent;

            onClicked: {
                fileDialog.open();
            }
        }
    }

    Image {
        id: updateButton;
        anchors.left: addButton.right;
        height: parent.height -3
        width: 45;

        fillMode: Image.PreserveAspectFit
        source: "file:///usr/share/openwallpaper-manager/icons/Adwaita/scalable/emblems/emblem-synchronizing-symbolic.svg"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                packageModel.updateAll()
            }
        }
    }

    Image {
        id: settingsButton;
        anchors.right: parent.right;
        height: parent.height - 3
        width: 45;

        fillMode: Image.PreserveAspectFit
        source: "file:///usr/share/openwallpaper-manager/icons/Adwaita/scalable/emblems/emblem-system-symbolic.svg"

        MouseArea {
            anchors.fill: parent;

            onClicked: {
                var component = Qt.createComponent("qrc:/qml_src/Settings.qml");
                settingsWinHandle = component.createObject(superRoot);
                settingsWinHandle.show();
            }
        }
    }

    Image {
        id: playbackButton;
        anchors.right: settingsButton.left;
        height: parent.height - 3
        width: 45;

        fillMode: Image.PreserveAspectFit
        source: "file:///usr/share/openwallpaper-manager/icons/Adwaita/scalable/emblems/emblem-music-symbolic.svg"

        MouseArea{
            anchors.fill: parent;

            onClicked: {
                popupPlayback.open();
            }
        }
    }

    Text {
        id: currentPlayText;
        anchors.verticalCenter: parent.verticalCenter;
        anchors.horizontalCenter: parent.horizontalCenter;

        text: packageManager.packageName
    }

    QQD.FileDialog {
        id: fileDialog
        title: "Choose wallpaper file"

        selectMultiple: false
        selectFolder: false
        folder: shortcuts.home
        nameFilters: ["Wallpaper init files (*.ini)", "Archives (*.tag.gz)"];

        onAccepted: {
            packageModel.insert(fileDialog.fileUrl.toString().replace("file://", ""),
                                settingsClass.CopyToHiddenPlace);
        }
    }
}
