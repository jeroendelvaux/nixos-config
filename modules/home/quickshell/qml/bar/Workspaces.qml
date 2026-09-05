import QtQuick
import Quickshell

Item {
  id: root

  property int workspaceSize: 28
  property int windowSize: 18
  property int spacing: 5

  property color activeColor: "#89b4fa"
  property color occupiedColor: "#585b70"
  property color emptyColor: "#313244"

  property color activeTextColor: "#11111b"
  property color textColor: "#cdd6f4"

  implicitWidth: workspaceRow.implicitWidth
  implicitHeight: workspaceSize

  NiriWorkspaces {
    id: niriWorkspaces
  }

  function resolveIcon(appId) {
    if (!appId) return "";
    let cleanId = appId.toLowerCase();
    let candidates = [cleanId];
    if (cleanId.includes('.')) {
      let parts = cleanId.split('.');
      let lastPart = parts[parts.length - 1];
      candidates.push(lastPart);
    }
    for (let candidate of candidates) {
      let path = Quickshell.iconPath(candidate, true);
      if (path !== "") {
        return path;
      }
    }
    return "";
  }

  function getLayoutModel() {
    let windowsByWs = {};
    Object.entries(niriWorkspaces.windows).forEach(([id, w]) => {
      if (!windowsByWs[w.workspace]) {
        windowsByWs[w.workspace] = [];
      }
      windowsByWs[w.workspace].push({
        id: id,
        position: w.position,
        app: w.app,
        pid: w.pid,
        focused: niriWorkspaces.focusedWindow === id
      });
    });
    Object.keys(windowsByWs).forEach(wsId => {
      windowsByWs[wsId].sort((a, b) => a.position - b.position);
    });
    return Object.entries(niriWorkspaces.workspaces).map(([id, w]) => {
      return {
        id: id,
        position: w.position,
        activeWindow: w.activeWindow,
        active: niriWorkspaces.activeWorkspace == id,
        windows: windowsByWs[id] || []
      }
    }).sort((a, b) => a.position - b.position);
  }

  Row {
    id: workspaceRow
    spacing: root.spacing
    anchors.verticalCenter: parent.verticalCenter
    Repeater {
      model: root.getLayoutModel()
      delegate: Row {
        id: workspaceGroup
        required property var modelData
        spacing: root.spacing
        anchors.verticalCenter: parent.verticalCenter
        Rectangle {
          readonly property bool active: workspaceGroup.modelData.active
          readonly property bool occupied:
            workspaceGroup.modelData.activeWindow !== null &&
            workspaceGroup.modelData.activeWindow !== undefined

          width: root.workspaceSize
          height: root.workspaceSize
          radius: 8
          anchors.verticalCenter: parent.verticalCenter
          color: {
            if (active)
              return root.activeColor
            if (occupied)
              return root.occupiedColor
            return root.emptyColor
          }
          scale: mouseArea.containsMouse ? 1.1 : 1.0
          Behavior on color {
            ColorAnimation { duration: 150 }
          }
          Behavior on scale {
            NumberAnimation { duration: 100; easing.type: Easing.OutCubic }
          }
          Text {
            anchors.centerIn: parent
            text: workspaceGroup.modelData.position
            color: active ? root.activeTextColor : root.textColor
            font.pixelSize: 12
            font.weight: Font.Bold
          }
          MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
              niriWorkspaces.focusWorkspace(workspaceGroup.modelData.position)
            }
          }
        }
        Repeater {
          model: workspaceGroup.modelData.windows
          delegate: Rectangle {
            required property var modelData
            readonly property bool focused: modelData.focused
            readonly property string iconPath: root.resolveIcon(modelData.app)
            width: root.workspaceSize
            height: root.workspaceSize
            radius: 8
            clip: true
            anchors.verticalCenter: parent.verticalCenter
            color: iconPath !== "" ? "transparent" : root.emptyColor
            border.color: focused ? root.activeColor : "transparent"
            border.width: 1
            scale: windowMouseArea.containsMouse ? 1.1 : 1.0
            Behavior on scale {
              NumberAnimation { duration: 100; easing.type: Easing.OutCubic }
            }
            Image {
              anchors.fill: parent
              anchors.margins: 2
              source: parent.iconPath
              visible: parent.iconPath !== ""
              fillMode: Image.PreserveAspectFit
              smooth: true
            }
            Text {
              anchors.centerIn: parent
              visible: parent.iconPath === ""
              text: modelData.app ? modelData.app.charAt(0).toUpperCase() : "?"
              color: root.textColor
              font.pixelSize: 10
              font.weight: Font.Bold
            }
            MouseArea {
              id: windowMouseArea
              anchors.fill: parent
              hoverEnabled: true
              cursorShape: Qt.PointingHandCursor
              onClicked: {
                niriWorkspaces.focusWindow(modelData.id)
              }
            }
          }
        }
      }
    }
  }
}
