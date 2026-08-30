{ config, lib, pkgs, secrets, inputs, ... }:

let
  cfg = config.modules.niri;
in
{
  options.modules.niri.enable = lib.mkEnableOption "Enable niri";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.xwayland-satellite
    ];
    programs.niri = {
      enable = true;
      settings = {
        prefer-no-csd = true;
        outputs = {
          "eDP-1" = {
            scale = 1.25;
          };
        };
        input.keyboard.xkb = {
          layout = "us";
        };
        layout = {
          gaps = 8;
          focus-ring = {
            enable = true;
            width = 2;
          };
          default-column-width = {
            proportion = 0.5;
          };
          preset-column-widths = [
            { proportion = 0.33333; }
            { proportion = 0.5; }
            { proportion = 0.66667; }
            { proportion = 1.0; }
          ];
        };
        spawn-at-startup = [
          { argv = [
            "dbus-update-activation-environment"
            "--systemd"
            "WAYLAND_DISPLAY"
            "XDG_CURRENT_DESKTOP"
          ];}
          { argv = ["quickshell"]; }
        ];
        binds = {
          "Mod+Shift+E".action.quit.skip-confirmation = true;
          "Mod+L".action.spawn = "hyprlock";
          "Mod+Q".action.close-window = {};
          # Launch applications:
          "Mod+T".action.spawn = "foot";
          "Mod+Return".action.spawn = "foot";
          "Mod+Space".action.spawn = ["wofi" "--show" "drun"];
          # Focus:
          "Mod+Left".action.focus-column-left = {};
          "Mod+Right".action.focus-column-right = {};
          "Mod+Up".action.focus-window-up = {};
          "Mod+Down".action.focus-window-down = {};
          "Mod+1".action.focus-workspace = 1;
          "Mod+2".action.focus-workspace = 2;
          "Mod+3".action.focus-workspace = 3;
          "Mod+4".action.focus-workspace = 4;
          "Mod+5".action.focus-workspace = 5;
          "Mod+6".action.focus-workspace = 6;
          "Mod+7".action.focus-workspace = 7;
          "Mod+8".action.focus-workspace = 8;
          "Mod+9".action.focus-workspace = 9;
          "Mod+Shift+1".action.move-column-to-workspace = 1;
          "Mod+Shift+2".action.move-column-to-workspace = 2;
          "Mod+Shift+3".action.move-column-to-workspace = 3;
          "Mod+Shift+4".action.move-column-to-workspace = 4;
          "Mod+Shift+5".action.move-column-to-workspace = 5;
          "Mod+Shift+6".action.move-column-to-workspace = 6;
          "Mod+Shift+7".action.move-column-to-workspace = 7;
          "Mod+Shift+8".action.move-column-to-workspace = 8;
          "Mod+Shift+9".action.move-column-to-workspace = 9;
          "Mod+WheelScrollDown".action.focus-workspace-down = {};
          "Mod+WheelScrollUp".action.focus-workspace-up = {};
          # Resizing:
          "Mod+R".action.switch-preset-column-width = {};
          "Mod+F".action.fullscreen-window = {};
          # Moving:
          "Mod+Shift+Left".action.move-column-left = {};
          "Mod+Shift+Right".action.move-column-right = {};
          "Mod+Shift+F".action.toggle-window-floating = {};
          # Help:
          "Mod+O".action.toggle-overview = {};
          "Mod+H".action.show-hotkey-overlay = {};
          # Media keys:
          "XF86AudioRaiseVolume" = {
            allow-when-locked = true;
            action.spawn = [
              "wpctl"
              "set-volume"
              "@DEFAULT_AUDIO_SINK@"
              "0.05+"
            ];
          };
          "XF86AudioLowerVolume" = {
            allow-when-locked = true;
            action.spawn = [
              "wpctl"
              "set-volume"
              "@DEFAULT_AUDIO_SINK@"
              "0.05-"
            ];
          };
          "XF86AudioMute" = {
            allow-when-locked = true;
            action.spawn = [
              "wpctl"
              "set-mute"
              "@DEFAULT_AUDIO_SINK@"
              "toggle"
            ];
          };
        };
      };
    };
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
      config = {
        common = {
          default = [ "gtk" ];
        };
      };
    };
  };
}
