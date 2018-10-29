#! /usr/bin/env bash
$EXTRACTRC `find . -name \*.rc -o -name \*.ui -o -name \*.kcfg | grep -v '/tests/'` >> rc.cpp
$XGETTEXT `find . -name \*.js -o -name \*.qml -o -name \*.cpp | grep -v '/tests/'` -o $podir/plasma_applet_com.github.zren.awc2.private.pot
rm -f rc.cpp
