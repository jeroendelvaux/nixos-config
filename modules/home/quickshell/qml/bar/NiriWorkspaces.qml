import QtQuick
import Quickshell
import Quickshell.Io

Item {
  id: root
  property var workspaces: []
  property var activeWorkspace: null
  property var windows: []
  property var focusedWindow: null

  Process {
    id: niriStream
    command: ["niri", "msg", "--json", "event-stream"]
    running: true
    stdout: SplitParser {
      onRead: function(line) {
        try {
          const event = JSON.parse(line);
          if (event.WorkspacesChanged) {
            let ws = event.WorkspacesChanged.workspaces.reduce((acc, w) => {
              acc[w.id] = {
                position: w.idx,
                activeWindow: w.active_window_id
              };
              return acc;
            }, {});
            root.workspaces = ws;
            console.log(
              "WorkspacesChanged:",
              JSON.stringify(root.workspaces, null, 2)
            );
          }
          else if (event.WindowsChanged) {
            let ws = event.WindowsChanged.windows.reduce((acc, w) => {
              acc[w.id] = {
                workspace: w.workspace_id,
                position: w.layout.pos_in_scrolling_layout[0],
                app: w.app_id,
              };
              return acc;
            }, {});
            root.windows = ws;
            console.log(
              "WindowsChanged:",
              JSON.stringify(root.windows, null, 2)
            );
          }
          else if (event.WindowOpenedOrChanged) {
            const w = event.WindowOpenedOrChanged.window;
            let ws = Object.assign({}, root.windows);
            ws[w.id] = {
              workspace: w.workspace_id,
              position: w.layout.pos_in_scrolling_layout[0],
              app: w.app_id,
            };
            root.windows = ws;
            console.log(
              "WindowOpenedOrChanged:",
              JSON.stringify(root.windows, null, 2)
            );
          }
          else if (event.WindowClosed) {
            let ws = Object.assign({}, root.windows);
            delete ws[event.WindowClosed.id];
            root.windows = ws;
            console.log(
              "WindowClosed:",
              JSON.stringify(root.windows, null, 2)
            );
          }
          else if (event.WorkspaceActivated) {
            root.activeWorkspace = event.WorkspaceActivated.id;
            console.log(
              "WorkspaceActivated:",
              root.activeWorkspace
            );
          }
          else if (event.WorkspaceActiveWindowChanged) {
            const w = event.WorkspaceActiveWindowChanged;
            let ws = Object.assign({}, root.workspaces);
            if (ws[w.workspace_id]) {
              ws[w.workspace_id] = Object.assign({}, ws[w.workspace_id], { activeWindow: w.active_window_id });
              root.workspaces = ws;
            }
            console.log(
              "WorkspaceActiveWindowChanged:",
              JSON.stringify(root.workspaces, null, 2)
            );
          }
          else if (event.WindowFocusChanged) {
            root.focusedWindow = event.WindowFocusChanged.id;
            console.log(
              "WindowFocusChanged:",
              root.focusedWindow
            );
          }
        } catch (e) {
          console.warn("NiriEventStream: failed to parse line:", line);
        }
      }
    }
    onRunningChanged: {
      if (!running) {
        restartTimer.start();
      }
    }
  }

  Timer {
    id: restartTimer
    interval: 1000
    repeat: false
    onTriggered: niriStream.running = true
  }

  function focusWorkspace(idx) {
    Quickshell.execDetached(["niri", "msg", "action", "focus-workspace", String(idx)]);
  }

  function focusWindow(id) {
    Quickshell.execDetached(["niri", "msg", "action", "focus-window", "--id", String(id)]);
  }
}
