#! /usr/bin/env bash
$EXTRACTRC `find . -name \*.rc -o -name \*.ui -o -name \*.kcfg | grep -v '/tests/'` >> rc.cpp
$XGETTEXT `find . -name \*.js -o -name \*.qml -o -name \*.cpp | grep -v '/tests/'` -o $podir/plasma_applet_org.kde.plasma.private.grouping.pot
rm -f rc.cpp
