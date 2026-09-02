import QtQuick

Rectangle {
  id: clockRoot
  height: 33
  implicitWidth: clockText.implicitWidth + 16
  color: "#1e1e2e"
  radius: 8
  border.color: "#313244"
  border.width: 1

  readonly property Theme theme: Theme {}

  Text {
    id: clockText
    anchors.centerIn: parent
    color: clockRoot.theme.textColor
    font: clockRoot.theme.textFont

    Timer {
      interval: 1000
      running: true
      repeat: true
      triggeredOnStart: true
      onTriggered: {
        let d = new Date();
        let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
        let dayName = days[d.getDay()];
        let dayNum = String(d.getDate()).padStart(2, '0');
        let monthNum = String(d.getMonth() + 1).padStart(2, '0');
        let year = d.getFullYear();
        let hours = String(d.getHours()).padStart(2, '0');
        let minutes = String(d.getMinutes()).padStart(2, '0');

        clockText.text = `${dayName} ${dayNum}/${monthNum}/${year} ${hours}:${minutes}`;
      }
    }
  }
}

