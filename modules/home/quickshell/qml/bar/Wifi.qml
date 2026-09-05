import QtQuick
import Quickshell
import Quickshell.Io

BarButton {
  id: wifiRoot

  property string ssid: "Disconnected"
  property bool connected: false

  onClicked: {
    wifiRoot.connected = !wifiRoot.connected;
    toggleProc.running = true;
  }

  Process {
    id: wifiProc
    command: ["sh", "-c", "nmcli -t -f TYPE,STATE,CONNECTION device | grep '^wifi:connected:' | cut -d: -f3-"]
    running: true
    stdout: SplitParser {
      onRead: data => {
        let trimmed = data.trim();
        if (trimmed.length > 0) {
          wifiRoot.ssid = trimmed;
          wifiRoot.connected = true;
        } else {
          wifiRoot.ssid = "Disconnected";
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
    onExited: wifiProc.running = true
  }

  Timer {
    interval: 5000
    running: true
    repeat: true
    onTriggered: wifiProc.running = true
  }

  Text {
    anchors.centerIn: parent
    text: wifiRoot.connected ? "󰤨 " : "󰤭 "
    color: wifiRoot.connected
      ? wifiRoot.theme.successColor
      : wifiRoot.theme.alertColor
    font: wifiRoot.theme.textFont
  }
}
