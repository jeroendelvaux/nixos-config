import QtQuick
import Quickshell
import Quickshell.Io

BarButton {
  id: wifiRoot

  property string ssid: "Disconnected"
  property bool connected: false
  property int strength: 0

  onClicked: {
    if (toggleProc.running) return;
    wifiRoot.connected = !wifiRoot.connected;
    toggleProc.running = true;
  }

  Process {
    id: wifiProc
    command: ["sh", "-c", "nmcli -t -f ACTIVE,SSID,SIGNAL dev wifi | grep '^yes:'"]
    running: true
    stdout: SplitParser {
      onRead: data => {
        let trimmed = data.trim();
        if (trimmed.length > 0) {
          let parts = trimmed.split(":");
          wifiRoot.ssid = parts[1] || "Connected";
          wifiRoot.strength = parseInt(parts[2]) || 0;
          wifiRoot.connected = true;
        } else {
          wifiRoot.ssid = "Disconnected";
          wifiRoot.strength = 0;
          wifiRoot.connected = false;
        }
      }
    }
  }

  Process {
    id: toggleProc
    command: ["sh", "-c", wifiRoot.connected
      ? "nmcli radio wifi on" 
      : "nmcli radio wifi off"];
    onExited: {
      if (!wifiProc.running) {
        wifiProc.running = true;
      }
    }
  }

  Timer {
    interval: 15000
    running: true
    repeat: true
    onTriggered: {
      if (!wifiProc.running && !toggleProc.running) {
        wifiProc.running = true;
      }
    }
  }

  Text {
    anchors.centerIn: parent
    text: {
      if (!wifiRoot.connected) return "󰤭";
      if (wifiRoot.strength > 75) return "󰤨";
      if (wifiRoot.strength > 50) return "󰤥";
      if (wifiRoot.strength > 25) return "󰤢";
      return "󰤟";
    }
    color: wifiRoot.connected
      ? wifiRoot.theme.successColor
      : wifiRoot.theme.alertColor
    font: wifiRoot.theme.textFont
  }
}

