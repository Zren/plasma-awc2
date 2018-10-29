cmake_minimum_required(VERSION 2.8.12 FATAL_ERROR)

set(QT_MIN_VERSION "5.6.0")
set(KF5_MIN_VERSION "5.26.0")

find_package(ECM 0.0.11 REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR})

include(KDEInstallDirs)
include(KDECMakeSettings)
include(KDECompilerSettings)
include(ECMQtDeclareLoggingCategory)

find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED
  Quick
  Widgets
)
find_package(KF5 ${KF5_MIN_VERSION} REQUIRED COMPONENTS
  Plasma
  XmlGui
  I18n
)




add_definitions(-DTRANSLATION_DOMAIN=\"plasma_applet_com.github.zren.awc2.private\")

plasma_install_package(package com.github.zren.awc2.private)

ecm_qt_declare_logging_category(groupingplasmoid_SRCS HEADER debug.h
                                            IDENTIFIER GROUPING_DEBUG
                                            CATEGORY_NAME zren.awc2
                                            DEFAULT_SEVERITY Info)

add_library(com.github.zren.awc2.private MODULE groupingcontainment.cpp ${groupingplasmoid_SRCS})

kcoreaddons_desktop_to_json(com.github.zren.awc2.private package/metadata.desktop)

target_link_libraries(com.github.zren.awc2.private
                      Qt5::Gui
                      Qt5::Quick
                      Qt5::DBus
                      Qt5::Widgets
                      KF5::Plasma
                      KF5::XmlGui
                      KF5::I18n)

install(TARGETS com.github.zren.awc2.private DESTINATION ${KDE_INSTALL_PLUGINDIR}/plasma/applets)

add_subdirectory(container)
