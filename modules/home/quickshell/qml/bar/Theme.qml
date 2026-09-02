import QtQuick

QtObject {
  readonly property color textColor: "#eae6df"
  readonly property color successColor: "#a6e3a1"
  readonly property color warningColor: "#fab387"
  readonly property color alertColor: "#f38ba8"
  readonly property color surfaceColor: "#1e1e2e"
  readonly property color surfaceHoverColor: "#313244"
  readonly property color surfacePressedColor: "#45475a"
  readonly property color borderColor: "#1e1e2e"
  property font textFont: Qt.font({
    family: "JetBrainsMono Nerd Font",
    pixelSize: 15
  })
}
