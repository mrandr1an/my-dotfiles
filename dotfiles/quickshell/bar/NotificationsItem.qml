import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Notifications

Item {
    id: root
    implicitWidth: 24
    implicitHeight: 24

    property url iconsDir: Qt.resolvedUrl("./icons")
    property url iconOn: iconsDir + "/notifications-activated.svg"
    property url iconOff: iconsDir + "/notifications-off.svg"
    property url iconSignal: iconsDir + "/notifications-active.svg"

    property bool enabled: Bluetooth.defaultAdapter && Bluetooth.defaultAdapter.enabled
    readonly property bool connected: Bluetooth.defaultAdapter
    && Bluetooth.defaultAdapter.devices.values.some(function(d) { return d.connected })

    readonly property url _icon: !enabled ? iconOff : (connected ? iconSignal : iconOn)

    Image {
        anchors.centerIn: parent
        source: root._icon
        sourceSize.width: 18
        sourceSize.height: 18
        fillMode: Image.PreserveAspectFit
        antialiasing: true
        smooth: true
        cache: true
    }

    Layout.alignment: Qt.AlignVCenter
    Layout.minimumWidth: implicitWidth
    Layout.minimumHeight: implicitHeight
}
