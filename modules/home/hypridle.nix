{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.hypridle;
in
{
  options.hypridle.enable = lib.mkEnableOption "Enable hypridle";

  config.services.hypridle = lib.mkIf cfg.enable {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
      };
      listener = [
        # Dim screen after 5 minutes:
        {
          timeout = 300;
          on-timeout = "brightnessctl -s set 10%";
          on-resume  = "brightnessctl -r";
        }
        # Lock screen after 6 minutes:
        {
          timeout = 360;
          on-timeout = "loginctl lock-session";
        }
        # Turn off screen after 10 minutes
        {
          timeout = 600;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume  = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

  config.home.packages = lib.mkIf cfg.enable (with pkgs; [
    hypridle
    hyprlock
    brightnessctl
  ]);
}
