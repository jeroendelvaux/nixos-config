import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic
import Quickshell
import Quickshell.Io

Rectangle {
  id: volumeRoot
  height: 33
  width: 33
  color: mouseArea.pressed
    ? volumeRoot.theme.surfacePressedColor
    : (mouseArea.containsMouse
        ? volumeRoot.theme.surfaceHoverColor
        : volumeRoot.theme.surfaceColor)
  radius: 8
  border.color: volumeRoot.theme.borderColor
  border.width: 1
  scale: mouseArea.pressed ? 0.95 : 1.0
  Behavior on scale {
    NumberAnimation {
      duration: 50;
      easing.type: Easing.OutQuad
    }
  }

  readonly property Theme theme: Theme {}
  property int volumeValue: 0
  property bool muted: false

  Process {
    id: volumeProc
    command: ["sh", "-c", "wpctl get-volume @DEFAULT_AUDIO_SINK@"]
    running: true
    stdout: SplitParser {
      onRead: data => {
        let trimmed = data.trim();
        let parts = trimmed.split(/\s+/);
        if (parts.length >= 2) {
          let parsed = parseFloat(parts[1]);
          volumeRoot.volumeValue = Math.round(parsed * 100);
          volumeRoot.muted = trimmed.includes("MUTED");
        }
      }
    }
  }

  Process {
    id: toggleProc
    command: ["sh", "-c", "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"];
    onExited: volumeProc.running = true
  }

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: {
      volumeRoot.muted = !volumeRoot.muted;
      toggleProc.running = true;
    }
  }

  Timer {
    interval: 2000
    running: true
    repeat: true
    onTriggered: volumeProc.running = true
  }

  Text {
    anchors.centerIn: parent
    text: volumeRoot.muted || volumeRoot.volumeValue === 0 ? "󰝟" : "󰕾"
    color: volumeRoot.muted || volumeRoot.volumeValue === 0
      ? volumeRoot.theme.alertColor
      : volumeRoot.theme.successColor
    font: volumeRoot.theme.textFont
  }
}
