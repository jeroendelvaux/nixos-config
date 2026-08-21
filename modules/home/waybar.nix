{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.waybar;
in
{
  options.waybar.enable = lib.mkEnableOption "Enable waybar";

  config.programs.waybar = lib.mkIf cfg.enable {
    enable = true;
    settings = {
      mainBar = {
        position = "top";
        modules-left = [ "hyprland/workspaces" ];
        modules-right = [
          "network"
          "custom/vpn"
          "bluetooth"
          "wireplumber"
          "battery"
          "clock"
        ];
        network = {
          format-wifi = "{icon} {signalStrength}%";
          format-icons = [ "󰖩" ];
          tooltip-format = ''
            <b>{essid}</b>
            IP: {ipaddr}
          '';
          on-click = "foot nmtui";
        };
        "custom/vpn" = {
          exec = ''
            status=$(wg-status 2>/dev/null)
            if [ "$status" = "connected" ]; then
              echo '{"text": "VPN: ON"}'
            else
              echo '{"text": "VPN: OFF"}'
            fi
          '';
          return-type = "json";
          interval = 5;
          format = "{}";
        };
        bluetooth = {
          format-disabled = "󰂲 off";
          format-enabled = "󰂯 on";
          format-connected = "󰂱";
          tooltip-format = ''
            Status: {status}
          '';
          on-click = "blueman-manager";
        };
        wireplumber = {
          format = "{icon} {volume}%";
          format-icons = [ "󰕾" ];
          format-muted = "";
          on-click = "easyeffects";
        };
        battery = {
          format = "{icon} {capacity}%";
          format-icons = [ "󰂎" ];
          format-plugged = " {capacity}%";
          format-charging = " {capacity}%";
          warning-threshold = 33;
          critical-threshold = 10;
        };
        clock = {
          format = "{:%a %b %d, %H:%M}";
          tooltip-format = ''
            <big>{:%A, %d %B %Y}</big>
            <tt><small>{calendar}</small></tt>
         '';
        };
      };
    };
    style = ''
      window#waybar {
        background: transparent;
        color: #ee33ee;
      }
      window#waybar {
        font-family:
          "JetBrainsMono Nerd Font",
          "Font Awesome 6 Free";
        font-size: 15px;
      }
      #workspaces button {
        background: #333333;
        padding: 0 5px;
        margin-left: 10px;
      }
      #workspaces button.active {
        color: #ee33ee;
      }
      #custom-vpn, #bluetooth, #network, #wireplumber, #battery, #clock {
        background: #333333;
        padding: 0 10px;
        margin-right: 10px;
      }
    '';
  };
}
