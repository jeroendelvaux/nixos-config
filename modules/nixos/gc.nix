{ config, lib, pkgs, pkgs-unstable, secrets, ... }:

let
  cfg = config.gc;
in
{
  options.gc.enable = lib.mkEnableOption "Enable gc";

  config = lib.mkIf cfg.enable {
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d --max-freed 3";
    };

    systemd.timers.nix_gc = {
      enable = true;
      timerConfig.OnCalendar = "weekly";
    };
  };
}
