import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.UPower

Rectangle {
  id: batteryRoot
  height: 33
  implicitWidth: batteryLayout.implicitWidth + 16
  color: "#1e1e2e"
  radius: 8
  border.color: "#313244"
  border.width: 1

  readonly property Theme theme: Theme {}

  RowLayout {
    id: batteryLayout
    anchors.centerIn: parent
    spacing: 6

    Text {
      id: batteryText
      color: batteryRoot.theme.textColor
      font: batteryRoot.theme.textFont
      property var battery: UPower.displayDevice

      text: {
        if (!batteryText.battery || !batteryText.battery.ready) return "—";
        let pct = Math.round(batteryText.battery.percentage * 100);
        let charging = batteryText.battery.state === UPowerDeviceState.Charging;
        let icon = charging ? "󰂄 " : (pct > 90 ? "󰁹 " : pct > 70 ? "󰁿 " : pct > 50 ? "󰁽 " : pct > 30 ? "󰁻 " : "󰁺 ");
        return icon + pct + "%";
      }
    }
  }
}
