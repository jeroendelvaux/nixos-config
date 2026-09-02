import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick

Scope {
  property var wallpapers: []
  property int currentIndex: 0
  property string currentWallpaper: ""

  FileView {
    path: Qt.resolvedUrl("../wallpapers.json")
    onTextChanged: {
      try {
        wallpapers = JSON.parse(text());
        if (wallpapers.length > 0 && currentWallpaper === "") {
          currentIndex = Math.floor(Math.random() * wallpapers.length);
          currentWallpaper = wallpapers[currentIndex];
        }
      } catch (e) {
        console.log("Error parsing wallpapers.json: " + e);
      }
    }
  }

  Timer {
    interval: 3600000 // 1 hour
    running: wallpapers.length > 1
    repeat: true
    onTriggered: {
      let newIndex;
      do {
        newIndex = Math.floor(Math.random() * wallpapers.length);
      } while (newIndex === currentIndex);
      currentIndex = newIndex;
      currentWallpaper = wallpapers[currentIndex];
    }
  }

  Variants {
    model: Quickshell.screens
    delegate: Component {
      PanelWindow {
        required property var modelData
        screen: modelData
        WlrLayershell.layer: WlrLayer.Background
        exclusionMode: ExclusionMode.Ignore
        aboveWindows: false
        exclusiveZone: 0
        anchors {
          top: true
          bottom: true
          left: true
          right: true
        }
        color: "black"
        Image {
          anchors.fill: parent
          source: currentWallpaper
          fillMode: Image.PreserveAspectCrop
          asynchronous: true
          smooth: true
        }
      }
    }
  }
}
