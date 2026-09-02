import QtQuick
import Quickshell

Item {
  id: root

  property int workspaceSize: 28
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

  Row {
    id: workspaceRow
    spacing: root.spacing
    anchors.verticalCenter: parent.verticalCenter
    Repeater {
      model: niriWorkspaces.workspaces
      delegate: Rectangle {
        required property var modelData
        readonly property bool active:
          modelData.is_active === true
        readonly property bool occupied:
          modelData.active_window_id !== null &&
          modelData.active_window_id !== undefined
        width: root.workspaceSize
        height: root.workspaceSize
        radius: width / 2
        color: {
          if (active)
            return root.activeColor
          if (occupied)
            return root.occupiedColor
          return root.emptyColor
        }
        scale: mouseArea.containsMouse ? 1.1 : 1.0
        Behavior on color {
          ColorAnimation {
            duration: 150
          }
        }
        Behavior on scale {
          NumberAnimation {
            duration: 100
            easing.type: Easing.OutCubic
          }
        }
        Text {
          anchors.centerIn: parent
          text: modelData.idx
          color: active
            ? root.activeTextColor
            : root.textColor
          font.pixelSize: 12
          font.weight: Font.Bold
        }
        MouseArea {
          id: mouseArea
          anchors.fill: parent
          hoverEnabled: true
          cursorShape: Qt.PointingHandCursor
          onClicked: {
            niriWorkspaces.focusWorkspace(
              modelData.idx
            )
          }
        }
      }
    }
  }
}
