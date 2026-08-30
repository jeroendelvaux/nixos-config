import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

Rectangle {
  id: wifiRoot
  height: 33
  width: 33
  color: mouseArea.pressed
    ? wifiRoot.theme.surfacePressedColor
    : (mouseArea.containsMouse
        ? wifiRoot.theme.surfaceHoverColor
        : wifiRoot.theme.surfaceColor)
  radius: 8
  border.color: wifiRoot.theme.borderColor
  border.width: 1
  scale: mouseArea.pressed ? 0.95 : 1.0
  Behavior on scale {
    NumberAnimation {
      duration: 50;
      easing.type: Easing.OutQuad
    }
  }

  readonly property Theme theme: Theme {}
  property string ssid: "Disconnected"
  property bool connected: false

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

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: {
      wifiRoot.connected = !wifiRoot.connected;
      toggleProc.running = true;
    }
  }

  Timer {
    interval: 5000
    running: true
    repeat: true
    onTriggered: wifiProc.running = true
  }

  RowLayout {
    id: wifiLayout
    anchors.centerIn: parent
    Text {
      text: wifiRoot.connected ? "󰤨 " : "󰤭 "
      color: wifiRoot.connected
        ? wifiRoot.theme.successColor
        : wifiRoot.theme.alertColor
      font: wifiRootBox.theme.textFont
    }
  }
}
