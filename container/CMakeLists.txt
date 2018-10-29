plasma_install_package(package com.github.zren.awc2)

set(groupedappletscontainer_SRCS
    groupedappletscontainer.cpp
)
ecm_qt_declare_logging_category(groupedappletscontainer_SRCS HEADER debug.h
                                            IDENTIFIER GROUPING_DEBUG
                                            CATEGORY_NAME kde.grouping
                                            DEFAULT_SEVERITY Info)

add_library(com.github.zren.awc2 MODULE ${groupedappletscontainer_SRCS})

kcoreaddons_desktop_to_json(com.github.zren.awc2 package/metadata.desktop)


target_link_libraries(com.github.zren.awc2
                      Qt5::Gui
                      Qt5::Quick
                      KF5::Plasma
                      KF5::XmlGui
                      KF5::I18n)

install(TARGETS com.github.zren.awc2 DESTINATION ${KDE_INSTALL_PLUGINDIR}/plasma/applets)


