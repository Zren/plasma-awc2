/*
 *   Copyright 2011 Marco Martin <mart@kde.org>
 *  Copyright 2016 David Edmundson <davidedmundson@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU Library General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.5
import QtQuick.Layouts 1.3
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.plasmoid 2.0
import org.kde.draganddrop 2.0 as DnD

import "items"

Item {
    id: root

    //be at least the same size as the system tray popup
    Layout.minimumWidth: 0
    Layout.minimumHeight: 0
    Layout.preferredWidth: Layout.minimumWidth
    Layout.preferredHeight: Layout.minimumHeight * 1.5

    property Component plasmoidItemComponent

    Containment.onAppletAdded: {
        addApplet(applet);
    }
    Containment.onAppletRemoved: {
       for (var i=0; i<mainStack.count; i++) {
            if (mainStack.children[i].itemId == applet.id) {
                mainStack.children[i].destroy();
                break;
            }
       }
    }

    function addApplet(applet) {
        if (!plasmoidItemComponent) {
            plasmoidItemComponent = Qt.createComponent("items/PlasmoidItem.qml");
        }
        if (plasmoidItemComponent.status == Component.Error) {
            console.warn("Could not create PlasmoidItem", plasmoidItemComponent.errorString());
        }

        var plasmoidContainer = plasmoidItemComponent.createObject(mainStack, {"applet": applet});

        plasmoidContainer.anchors.fill = mainStack
        applet.parent = plasmoidContainer;
        applet.anchors.fill = plasmoidContainer;
        applet.visible = true;
    }

    Component.onCompleted: {
        var applets = Containment.applets;
        for (var i =0 ; i < applets.length; i++) {
            addApplet(applets[i]);
        }

        if (applets.length == 0) {
            plasmoid.nativeInterface.newTask("org.kde.plasma.appmenu")
        }
    }

    Item {
        id: mainStack
        anchors.fill: parent
    }
}
