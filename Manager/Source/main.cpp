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

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "debug.hpp"
#include "package_model.hpp"
#include "communication.hpp"
#include "settings.hpp"
#include "package_manager.hpp"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    app.setOrganizationName("OpenWallpaper");
    app.setOrganizationDomain("org");

    Communication* plugin = new Communication(&app);
    PackageModel* pkgModel = new PackageModel(plugin);
    PackageManager *pkgMan = new PackageManager(pkgModel, plugin);
    Settings* stngs = new Settings(plugin);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/qml_src/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.rootContext()->setContextProperty("pluginCommunication", plugin);
    engine.rootContext()->setContextProperty("packageModel", pkgModel);
    engine.rootContext()->setContextProperty("settingsClass", stngs);
    engine.rootContext()->setContextProperty("packageManager", pkgMan);
    engine.load(url);

    return app.exec();
}
