import QtQuick
import Quickshell
import Quickshell.Io

Rectangle {
  id: vpnRoot
  height: 33
  width: 33
  color: mouseArea.pressed 
    ? vpnRoot.theme.surfacePressedColor 
    : (mouseArea.containsMouse 
        ? vpnRoot.theme.surfaceHoverColor 
        : vpnRoot.theme.surfaceColor)
  radius: 8
  border.color: vpnRoot.theme.borderColor
  border.width: 1

  scale: mouseArea.pressed ? 0.95 : 1.0
  Behavior on scale {
    NumberAnimation { duration: 50; easing.type: Easing.OutQuad }
  }

  readonly property Theme theme: Theme {}
  property bool isConnected: false

  Process {
    id: toggleProc
    command: ["sh", "-c", vpnRoot.isConnected
      ? "wg-connect" 
      : "wg-disconnect"];
    running: false
    onExited: {
      statusRefreshTimer.restart();
    }
  }

  Process {
    id: vpnProc
    command: ["sh", "-c", "wg-status"]
    running: true
    stdout: SplitParser {
      onRead: data => {
        let status = data.trim().toLowerCase();
        vpnRoot.isConnected = (status === "connected");
      }
    }
  }

  Timer {
    id: statusRefreshTimer
    interval: 300
    onTriggered: vpnProc.running = true
  }

  Timer {
    id: pollTimer
    interval: 5000
    running: true
    repeat: true
    onTriggered: {
      if (!vpnProc.running && !toggleProc.running) {
        vpnProc.running = true;
      }
    }
  }

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: {
      if (toggleProc.running) return;
      vpnRoot.isConnected = !vpnRoot.isConnected;
      toggleProc.running = true;
    }
  }

  Text {
    anchors.centerIn: parent
    text: vpnRoot.isConnected ? "󰌾" : "󰌿"
    color: vpnRoot.isConnected
      ? vpnRoot.theme.successColor
      : vpnRoot.theme.alertColor
    font: vpnRoot.theme.textFont
  }
}
