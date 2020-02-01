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
import QtQuick.Controls 2.12 as QQC2
import QtGraphicalEffects 1.4 as QGE

QQC2.ScrollView {

    property variant gridRef: grid

    GridView {
        id: grid;
        anchors.fill: parent;
        clip: true;
        topMargin: 5
        leftMargin: 10

        model: packageModel;
        cellWidth: 185; cellHeight: 120

        delegate: Rectangle{
            width: grid.cellWidth - 15;  // 170
            height: grid.cellHeight -15;    // 105

            Image {
                id: playedImage
                anchors.fill: parent
                source: model.previewImage

                mipmap: true;
                //fillMode: Image.PreserveAspectCrop

                Rectangle {
                    id: playedName;
                    visible: false;
                    width: parent.width;
                    height: parent.height /4.5; // or 4.0?
                    anchors.bottom: parent.bottom
                    border.color: "white";

                    color: "white"
                    opacity: 0.5

                    Text {
                        anchors.verticalCenter: parent.verticalCenter;
                        anchors.horizontalCenter: parent.horizontalCenter;

                        text: model.name
                        color: "black"
                    }
                }
            }

            QGE.DropShadow {
                anchors.fill: parent
                horizontalOffset: 1
                verticalOffset: 1
                radius: 7.0
                samples: 17

                color: "#80000000"
                source: playedImage
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true;

                onEntered: {
                    infoButton.visible = true;
                    startButton.visible = true;
                    deleteButton.visible = true;
                    playedName.visible = true;
                    buttonBackground.visible = true;
                    buttonBackground2.visible = true;
                }

                onExited: {
                    infoButton.visible = false;
                    startButton.visible = false;
                    deleteButton.visible = false;
                    playedName.visible = false;
                    buttonBackground.visible = false;
                    buttonBackground2.visible = false;
                }
            }
            
            Rectangle{
                id: buttonBackground
                anchors.left: startButton.left
                anchors.leftMargin: -0.5
                anchors.verticalCenter: infoButton.verticalCenter
                width: infoButton.width + startButton.width + 5.5
                height: deleteButton.height + 2.5

                opacity: 0.5
                visible: false
                color: "white"
                radius: 5.0
            }

            Image {
                id: infoButton;
                width: 20;
                height: 20;
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 3.5
                anchors.topMargin: 3.5

                opacity: 0.75
                visible: false;

                mipmap: true
                source: "file:///usr/share/openwallpaper-manager/icons/Adwaita/96x96/apps/preferences-system-details-symbolic.symbolic.png"

                MouseArea{
                    anchors.fill: parent;

                    onClicked: {
                        popupPackageInfo.clear();

                        popupPackageInfo.imageSource = model.previewImage
                        popupPackageInfo.nameText = model.name
                        popupPackageInfo.versionText = model.version;
                        popupPackageInfo.typeText = model.type
                        popupPackageInfo.authorText = model.author
                        popupPackageInfo.emailText = model.email
                        popupPackageInfo.linkText = model.link
                        popupPackageInfo.commentText = model.comment

                        popupPackageInfo.open();
                    }
                }
            }

            Image {
                id: startButton;
                width: 20;
                height: 20;
                anchors.right: infoButton.left
                anchors.top: parent.top
                anchors.rightMargin: 3.5
                anchors.topMargin: 3.5

                opacity: 0.75
                visible: false;

                source: "file:///usr/share/openwallpaper-manager/icons/Adwaita/96x96/actions/media-playback-start-symbolic.symbolic.png"
                mipmap:true

                MouseArea{
                    anchors.fill: parent;

                    onClicked: {
                        packageManager.package = model.path;
                    }
                }
            }
            
            Rectangle{
                id: buttonBackground2
                anchors.horizontalCenter: deleteButton.horizontalCenter
                anchors.verticalCenter: deleteButton.verticalCenter
                width: deleteButton.width +2.5
                height: deleteButton.height + 2.5

                visible: false
                opacity: 0.5
                color: "white"
                radius: 5.0
            }

            Image {
                id: deleteButton;
                width: 20;
                height: 20;
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: 3.5
                anchors.topMargin:  3.5

                opacity: 0.75
                visible: false;

                source: "file:///usr/share/openwallpaper-manager/icons/Adwaita/96x96/actions/edit-delete-symbolic.symbolic.png"
                mipmap:true

                MouseArea {
                    anchors.fill: parent;

                    onClicked: {
                        packageModel.remove(model.index);
                    }
                }
            }
        }
    }
}
