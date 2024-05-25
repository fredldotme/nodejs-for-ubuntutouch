/*
 * Copyright (C) 2024  Alfred Neumayer
 */

import QtQuick 2.7
import Lomiri.Components 1.3
import QtQuick.Controls 2.2 as QQC
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

import Tools 1.0

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'tools.fredldotme'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    function check() {
        nodeRow.ok = Tools.check("node")
        npmRow.ok = Tools.check("npm")
    }

    Component.onCompleted: check()

    Page {
        anchors.fill: parent

        header: PageHeader {
            id: header
            title: i18n.tr('Node.js')
            StyleHints {
                foregroundColor: "white"
                backgroundColor: "#1c5f18"
                dividerColor: LomiriColors.slate
            }
        }

        QQC.ScrollView {
            id: scrollView
            anchors {
                top: parent.top
                topMargin: header.height
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            contentWidth: parent.width
            contentHeight: mainLayout.height
            background: Rectangle { color: "#1c5f18" }

            ColumnLayout {
                id: mainLayout
                width: parent.width
                height: scrollView.height > nittyGritty.height ? Math.max(scrollView.height, implicitHeight) : nittyGritty.height
                spacing: units.gu(1)

                Item {
                    Layout.fillHeight: scrollView.height > nittyGritty.height
                }

                ColumnLayout {
                    id: nittyGritty
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: implicitHeight
                    spacing: units.gu(2)

                    Image {
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: parent.width / 3
                        Layout.preferredHeight: width
                        source: "qrc:/assets/logo.png"
                    }

                    Label {
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: parent.width - (units.gu(2) * 2)
                        text: i18n.tr("Easily set up or remove Node.js for use in your Terminal")
                        font.pixelSize: units.gu(3)
                        wrapMode: Label.WordWrap
                        horizontalAlignment: Label.AlignHCenter
                        color: "white"
                    }

                    Row {
                        id: nodeRow
                        property bool ok: false
                        spacing: units.gu(2)
                        Layout.preferredHeight: implicitHeight
                        Layout.alignment: Qt.AlignHCenter

                        Label {
                            text: "node:"
                            font.pixelSize: units.gu(3)
                            color: "white"
                        }
                        Icon {
                            name: nodeRow.ok ? "tick" : "close"
                            color: "white"
                            height: nodeRow.height
                            width: height
                        }
                    }

                    Row {
                        id: npmRow
                        property bool ok: false
                        spacing: units.gu(2)
                        Layout.preferredHeight: implicitHeight
                        Layout.alignment: Qt.AlignHCenter

                        Label {
                            text: "npm:"
                            font.pixelSize: units.gu(3)
                            color: "white"
                        }
                        Icon {
                            name: npmRow.ok ? "tick" : "close"
                            color: "white"
                            height: npmRow.height
                            width: height
                        }
                    }

                    Row {
                        id: buttonsRow
                        Layout.alignment: Qt.AlignHCenter
                        spacing: units.gu(2)

                        Button {
                            text: i18n.tr('Set up')
                            onClicked: {
                                Tools.setup()
                                root.check()
                            }
                        }

                        Button {
                            text: i18n.tr('Remove')
                            onClicked: {
                                Tools.remove()
                                root.check()
                            }
                        }
                    }
                }

                Item {
                    Layout.fillHeight: scrollView.height > nittyGritty.height
                }
            }
        }
    }
}
