import QtQuick
import QtQuick.Layouts
import Quickshell         
import Quickshell.Widgets 

Variants {
    model: Quickshell.screens
    delegate: Component {
        PanelWindow {
            required property var modelData
            screen: modelData
            anchors { top: true; left: true; right: true }
            implicitHeight: 32
            Rectangle { anchors.fill: parent; color: "#121218CC" }
            RowLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 20
		Layout.minimumWidth: 32
		Layout.minimumHeight: 32

		BluetoothItem { 
		iconsDir: Qt.resolvedUrl("/home/chrisl/.dotfiles/dotfiles/quickshell/assets/")
		}

		NotificationsItem { 
		iconsDir: Qt.resolvedUrl("/home/chrisl/.dotfiles/dotfiles/quickshell/assets/")
		}
            }
        }
    }
}

