{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.hypridle;
in
{
  options.modules.hypridle.enable = lib.mkEnableOption "Enable hypridle";

  config = lib.mkIf cfg.enable {
    services.hypridle = {
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
    home.packages = with pkgs; [
      hypridle
      hyprlock
      brightnessctl
    ];
  };
}
