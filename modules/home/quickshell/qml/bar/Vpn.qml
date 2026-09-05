import QtQuick
import Quickshell
import Quickshell.Io

BarButton {
  id: vpnRoot

  property bool isConnected: false

  onClicked: {
    if (toggleProc.running) return;
    vpnRoot.isConnected = !vpnRoot.isConnected;
    toggleProc.running = true;
  }

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

  Text {
    anchors.centerIn: parent
    text: vpnRoot.isConnected ? "󰌾" : "󰌿"
    color: vpnRoot.isConnected
      ? vpnRoot.theme.successColor
      : vpnRoot.theme.alertColor
    font: vpnRoot.theme.textFont
  }
}
