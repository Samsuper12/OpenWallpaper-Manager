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

QQC2.Popup {
    id: playbackRoot

    closePolicy: QQC2.Popup.CloseOnPressOutside

    property variant volumeImgRef: volumeImg
    property variant volumeSliderRef: volumeSlider
    property variant playButtonRef: playButton
    property variant pauseButtonRef: pauseButton
    property variant prevButtonRef: prevButton
    property variant nextButtonRef: nextButton
    property variant openAnimationRef: openAnimation

    property bool muted: false;
    property bool isNewInstance: true

    onMutedChanged: {

        // fix bug when need set muted on double click
        if (muted) {
            pluginCommunication.volume(0);
            volumeSlider.enabled = false;
            setVolumeImg(0.0);
        } else {
            volumeSlider.enabled = true;
            pluginCommunication.volume(volumeSlider.value);
            setVolumeImg(volumeSlider.value)
        }
    }

    onOpened: {
        openAnimation.start();
    }

    onClosed: {
        opacity = 0.1;
    }

    function setVolume(value) {
        volumeSlider.value = value;
        setVolumeImg(value);

        //muted = (value === 0.0) ? true :false
    }

    function setVolumeImg(volume) {

        if (volume === 0.0) {
            volumeImg.source = "file:///usr/share/openwallpaper-manager/icons/Adwaita/scalable/status/audio-volume-muted-symbolic.svg"
        }
        else if (volume <= 25.0) {
            volumeImg.source = "file:///usr/share/openwallpaper-manager/icons/Adwaita/scalable/status/audio-volume-low-symbolic.svg"
        }
        else if (volume<= 50.0) {
            volumeImg.source = "file:///usr/share/openwallpaper-manager/icons/Adwaita/scalable/status/audio-volume-medium-symbolic.svg"
        }
        else if (volume <= 75.0) {
           volumeImg.source = "file:///usr/share/openwallpaper-manager/icons/Adwaita/scalable/status/audio-volume-high-symbolic.svg"
        }
    }

    Image {
        id: volumeImg;
        x: 0
        y: 0;
        width: 15;
        height: 15;

        MouseArea {
        anchors.fill: parent;

            onClicked: {
                if  (volumeSlider.value === 0.0 && muted === false) {
                    return;
                }
                muted = !muted;
            }
        }
        
        Component.onCompleted: {
            source = "file:///usr/share/openwallpaper-manager/icons/Adwaita/scalable/status/audio-volume-muted-symbolic.svg"
        }
    }

    QQC2.Slider {
        id: volumeSlider;
        height: 15;
        anchors.left: volumeImg.right;
        width: parent.width - volumeImg.width

        from: 0;
        to: 100;

        onValueChanged: {
            pluginCommunication.volume(value);
            setVolumeImg(value);
        }
    }

    QQC2.Button {
        id: playButton;
        x:0;
        y: volumeSlider.height + 15;
        width: 42.5
        height: 25;

        display: QQC2.AbstractButton.IconOnly
        icon.source: "file:///usr/share/openwallpaper-manager/icons/Adwaita/scalable/actions/media-playback-start-symbolic.svg"

        onClicked: {
            pluginCommunication.play(1);
        }
    }

    QQC2.Button {
        id: pauseButton;
         x: (playButton.x + playButton.width) + 2;
         y: playButton.y;
         width: playButton.width;
         height: playButton.height;

         display: QQC2.AbstractButton.IconOnly
         icon.source: "file:///usr/share/openwallpaper-manager/icons/Adwaita/scalable/actions/media-playback-pause-symbolic.svg"

         onClicked: {
            pluginCommunication.play(0);
         }
    }

    QQC2.Button {
        id: prevButton;
        x: (pauseButton.x + pauseButton.width) + 2;
        y: playButton.y;
        width: playButton.width;
        height: playButton.height;

        display: QQC2.AbstractButton.IconOnly
        icon.source: "file:///usr/share/openwallpaper-manager/icons/Adwaita/scalable/actions/media-seek-backward-symbolic.svg"

        onClicked: {
            packageManager.stepTo(-1)
        }
    }

    QQC2.Button {
        id: nextButton;
        x: (prevButton.x + prevButton.width) + 2;
        y: playButton.y;
        width: playButton.width;
        height: playButton.height;

        display: QQC2.AbstractButton.IconOnly
        icon.source: "file:///usr/share/openwallpaper-manager/icons/Adwaita/scalable/actions/media-seek-forward-symbolic.svg"

        onClicked: {
            packageManager.stepTo(1)
        }
    }

    SequentialAnimation {
        id: openAnimation;
        running: false;

        NumberAnimation {
            target: playbackRoot;
            property: "opacity";

            to: 1.0;
            duration: 250
        }
    }
}
