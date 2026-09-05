// BarButton.qml
import QtQuick

Rectangle {
  id: root
  
  signal clicked()
  property alias cursorShape: mouseArea.cursorShape
  default property alias content: contentLayout.data
  property font font: theme.textFont

  height: 32
  width: 32
  radius: 8
  border.width: 1
  border.color: theme.borderColor

  color: mouseArea.pressed 
    ? theme.surfacePressedColor 
    : (mouseArea.containsMouse ? theme.surfaceHoverColor : theme.surfaceColor)

  scale: mouseArea.pressed ? theme.hoverScale : 1.0
  Behavior on scale {
    NumberAnimation { duration: theme.animDurationFast; easing.type: Easing.OutQuad }
  }

  readonly property Theme theme: Theme {}

  Item {
    id: contentLayout
    anchors.fill: parent
  }

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: root.clicked()
  }
}




