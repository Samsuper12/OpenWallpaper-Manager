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

    closePolicy: QQC2.Popup.CloseOnPressOutside

    property variant scrollRef: infoScroll
    
    property url imageSource

    property string nameText
    property string versionText
    property string typeText
    property string authorText
    property string emailText
    property string linkText
    property string commentText

    function clear() {
        nameText= "";
        versionText= "";
        typeText = "";
        imageSource = "";
        authorText = "";
        emailText = "";
        linkText = "";
        commentText = "";
    }

    QQC2.ScrollView {
        id: infoScroll
        anchors.fill: parent

        clip: true

        ListView {
            anchors.fill: parent

            model: 1

            delegate: Rectangle {
                width: parent.width
                height: infoCommentText.y + infoCommentText.height

                Image {
                    id: infoImage
                    width: infoScroll.width / 1.1
                    height: infoImage.width/ 1.8

                    x:  (infoScroll.width /2) - (width/2);
                    anchors.horizontalCenter: parent.horizontalPadding;

                    source: imageSource
                    mipmap: true;
                }

                Text {
                    id: infoNameText;
                    y: (infoImage.y + infoImage.height) + 10;
                    x: infoImage.x + 50;

                    text: nameText
                }

                QQC2.Label {
                    id: infoNameLabel;
                    anchors.right: infoNameText.left;
                    anchors.rightMargin: 15;
                    y: (infoImage.y + infoImage.height) + 10;

                    text: "Name:"
                }


                Text {
                    id: infoVersionText;
                    x: infoImage.x + 50;
                    anchors.top: infoNameText.bottom;

                    text: versionText
                }

                QQC2.Label {
                    id: infoVersionLabel;
                    anchors.right: infoVersionText.left;
                    anchors.rightMargin: 15;
                    anchors.top: infoNameLabel.bottom;

                    text: "Version:"
                }

                Text {
                    id: infoTypeText;
                    x: infoImage.x + 50;
                    anchors.top: infoVersionText.bottom;

                    text: typeText
                }

                QQC2.Label {
                    id: infoTypeLabel;
                    anchors.right: infoTypeText.left;
                    anchors.rightMargin: 15;
                    anchors.top: infoVersionLabel.bottom;

                    text: "Type:"
                }

                Text {
                    id: infoAuthorText;
                    x: infoImage.x + 50;
                    anchors.top: infoTypeText.bottom;

                    text: authorText
                }

                QQC2.Label {
                    id: infoAuthorLabel;
                    anchors.right: infoAuthorText.left;
                    anchors.rightMargin: 15;
                    anchors.top: infoTypeLabel.bottom;

                    text: "Author:"
                }

                TextInput {
                    id: infoEmailText;
                    x: infoImage.x + 50;
                    anchors.top: infoAuthorText.bottom;

                    text: emailText
                }

                QQC2.Label {
                    id: infoEmailLabel;
                    anchors.right: infoEmailText.left;
                    anchors.rightMargin: 15;
                    anchors.top: infoAuthorLabel.bottom;

                    text: "Email:"
                }

                Text {
                    id: infoLinkText;
                    x: infoImage.x + 50;
                    anchors.top: infoEmailText.bottom;

                    text: "<a href='"+ linkText + "'>" + linkText +"</a>"
                    onLinkActivated: Qt.openUrlExternally(linkText);
                }

                QQC2.Label {
                    id: infoLinkLabel;
                    anchors.right: infoLinkText.left;
                    anchors.rightMargin: 15;
                    anchors.top: infoEmailLabel.bottom;

                    text: "Link:"
                }

                Text {
                    id: infoCommentText;
                    x: infoImage.x + 50;
                    anchors.top: infoLinkText.bottom;
                    rightPadding: 0.1
                    width: parent.width - x;

                    wrapMode: Text.WordWrap
                    text: commentText
                }

                QQC2.Label {
                    id: infoCommentLabel;
                    anchors.right: infoLinkText.left;
                    anchors.rightMargin: 15;
                    anchors.top: infoLinkLabel.bottom;

                    text: "Info:"
                }
            }
        }
    }
}
