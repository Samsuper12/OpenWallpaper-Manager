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
import QtQuick.Window 2.12 as QQW
import QtQuick.Layouts 1.12 as QQL

QQW.Window {
    id: settingsRoot
    height: 300;
    width: 500;
    minimumHeight: height
    minimumWidth: width

    title: qsTr("Settings")

    x: (mainWinX + (mainWinWidth/2)) - (width/2)
    y: (mainWinY + (mainWinHeight/2)) - (height/2)

    QQC2.TabBar {
        id: tbar
        anchors.fill: parent
        width: parent.width

        QQC2.TabButton {
            text: qsTr("Plugin")
        }
        QQC2.TabButton {
            text: qsTr("Manager")
        }
        QQC2.TabButton {
            text: qsTr("About")
        }
    }

    QQL.StackLayout {
        id: sl
        anchors.fill: parent;
        currentIndex: tbar.currentIndex

        Item {
            id:pluginTab

            QQC2.ScrollView {
                anchors.fill: parent;
                anchors.topMargin: 50

                clip: true

                QQL.ColumnLayout {
                    anchors.fill: parent

                    Rectangle {
                        anchors.topMargin: 5;
                        width: parent.width
                        height: parent.height

                        QQC2.Label {
                            id: lbGroup
                            x: (sl.width /2) - (width /2)
                            text: "Behaviour"
                        }

                        QQC2.CheckBox{
                            id: idvCheck
                            anchors.top: lbGroup.bottom;
                            anchors.topMargin: 5;
                            checked: settingsClass.IgnoreDefaultVolume

                            text: qsTr("Ingore default package volume")

                            onClicked: {
                                settingsClass.IgnoreDefaultVolume = checked;
                            }
                        }

                        QQC2.CheckBox {
                            id: aifCheck
                            anchors.top: idvCheck.bottom;
                            checked: settingsClass.AlwaysInFocus
                            text: qsTr("Wallpaper always in focus")

                            onClicked: {
                                settingsClass.AlwaysInFocus = checked;
                            }
                        }

                        QQC2.CheckBox {
                            id: mcCheck
                            anchors.top: aifCheck.bottom;
                            checked: settingsClass.MusicCycle

                            text: qsTr("Play music in cycle")

                            onClicked: {
                                settingsClass.MusicCycle = checked;
                            }
                        }
                    }
                }
            }
        }

        Item {
            id: managerTab

            QQC2.ScrollView {
                anchors.fill: parent;
                anchors.topMargin: 50

                clip: true

                QQL.ColumnLayout {
                    anchors.fill: parent

                    Rectangle {
                        anchors.topMargin: 5;
                        width: parent.width
                        height: parent.height // last element.y + element.height

                        QQC2.Label {
                            id: lbGroup2
                            x: (sl.width /2) - (width /2)

                            text: "Packages"
                        }

                        QQC2.CheckBox {
                            id: cthpCheck
                            anchors.top: lbGroup2.bottom;
                            anchors.topMargin: 5;
                            checked: settingsClass.CopyToHiddenPlace

                            text: qsTr("Copy new packages to hidden place")

                            onClicked: {
                                settingsClass.CopyToHiddenPlace = checked;
                            }
                        }
                   }
                }
            }
        }

        Item {
            id: aboutTab

            QQC2.Label {
                id: nameLabel;
                x: (sl.width /2) - (width /2)
                anchors.top: parent.top
                anchors.topMargin: 50;

                font.pixelSize: 20;
                text: qsTr("OpenWallpaper Manager");
            }

            QQC2.Label {
                id: versionLabel;
                x: (sl.width /2) - (width /2)
                anchors.top: nameLabel.bottom
                anchors.topMargin: 5;

                text: qsTr("Version: 0.1");
            }

            QQC2.Label {
                id: githubPluginLabel;
                x: (sl.width /2) - (width /2)
                anchors.top: versionLabel.bottom
                anchors.topMargin: 5;

                text: qsTr("<a href='https://github.com/Samsuper12/OpenWallpaper-Plasma'>Plugin on GitHub</a>");
                onLinkActivated: Qt.openUrlExternally("https://github.com/Samsuper12/OpenWallpaper-Plasma")
            }

            QQC2.Label {
                id: githubManagerLabel;
                x: (sl.width /2) - (width /2)
                anchors.top: githubPluginLabel.bottom
                anchors.topMargin: 5;

                text: qsTr("<a href='https://github.com/Samsuper12/OpenWallpaper-Manager'>Manager on GitHub</a>");
                onLinkActivated: Qt.openUrlExternally("https://github.com/Samsuper12/OpenWallpaper-Manager")
            }

            QQC2.Label {
                id: twitterLabel;
                x: (sl.width /2) - (width /2)
                anchors.top: githubManagerLabel.bottom
                anchors.topMargin: 5;

                text: qsTr("<a href='https://twitter.com/Samsuris4'>Creator on Twitter</a>");
                onLinkActivated: Qt.openUrlExternally("https://twitter.com/Samsuris4")
            }
            
            QQC2.Label {
                id: redditLabel;
                x: (sl.width /2) - (width /2)
                anchors.top: twitterLabel.bottom
                anchors.topMargin: 5;

                text: qsTr("<a href='https://www.reddit.com/r/OpenWallpaper/'>Reddit community</a>");
                onLinkActivated: Qt.openUrlExternally("https://www.reddit.com/r/OpenWallpaper/")
            }
            
            QQC2.Label {
                id: licenseLabel;
                x: (sl.width /2) - (width /2)
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5;

                text: qsTr("This software is licensed under " + "<a href='https://github.com/Samsuper12/OpenWallpaper-Manager/blob/master/LICENSE'>GNU GPL</a>" + " version 3.");
                onLinkActivated: Qt.openUrlExternally("https://github.com/Samsuper12/OpenWallpaper-Manager/blob/master/LICENSE")
            }
        }
    }

    Connections{
        target: settingsClass;

        onDataChanged: {
            idvCheck.checked = settingsClass.IgnoreDefaultVolume;
            aifCheck.checked = settingsClass.AlwaysInFocus
            cthpCheck.checked = settingsClass.CopyToHiddenPlace
            mcCheck.checked = settingsClass.MusicCycle
        }
    }

    Component.onCompleted: {
        settingsClass.update();
    }
}
