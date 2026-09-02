import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland

PanelWindow {
  anchors {
    top: true
    left : true
    right: true
  }
  implicitHeight: 45
  color: "transparent"
  readonly property Theme theme: Theme {}

  RowLayout {
    anchors.fill: parent
    anchors.topMargin: 6
    anchors.bottomMargin: 6
    anchors.leftMargin: 12
    anchors.rightMargin: 12
    Workspaces {}
    Item { Layout.fillWidth: true }
    Clock {}
    Item { Layout.fillWidth: true }
    RowLayout {
      spacing: 10
      Vpn {}
      Wifi {}
      Volume {}
      Battery {}
    }
  }
}
