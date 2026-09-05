import QtQuick
import Quickshell
import Quickshell.Io

BarButton {
  id: volumeRoot

  property int volumeValue: 0
  property bool muted: false

  onClicked: {
    volumeRoot.muted = !volumeRoot.muted;
    toggleProc.running = true;
  }

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
    command: ["sh", "-c", "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"]
    onExited: volumeProc.running = true
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
    font: volumeRoot.font
  }
}

