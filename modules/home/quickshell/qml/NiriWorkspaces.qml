import QtQuick
import Quickshell
import Quickshell.Io

Item {
  id: root
  property var workspaces: []

  Process {
    id: niri
    command: [
      "niri",
      "msg",
      "--json",
      "event-stream"
    ]
    running: true
    stdout: SplitParser {
      onRead: function(line) {
        try {
          const event = JSON.parse(line)
          if (event.WorkspacesChanged) {
            let ws = event.WorkspacesChanged.workspaces;
            ws.sort((a, b) => a.idx - b.idx);
            root.workspaces = ws;
          }
        } catch (e) {
          console.warn(
            "NiriWorkspaces:",
            "failed to parse:",
            line
          )
        }
      }
    }
    onRunningChanged: {
      if (!running) {
        restartTimer.start()
      }
    }
  }

  Timer {
    id: restartTimer
    interval: 1000
    repeat: false
    onTriggered: {
      niri.running = true
    }
  }

  function focusWorkspace(idx) {
    Quickshell.execDetached([
      "niri",
      "msg",
      "action",
      "focus-workspace",
      String(idx)
    ])
  }
}
