{ config, lib, pkgs, pkgs-unstable, secrets, ... }:

{
  options.gc.enable = lib.mkEnableOption "Enable gc";

  config = lib.mkIf config.gc.enable {
    nix.gc = {
      automatic = true; # Gives permission but does not schedule.
      dates = "weekly";
      options = "--delete-older-than 7d --max-freed 3"; 
      # Keeps 3 generations older than 7 days.
    };
    systemd.timers.nix_gc = {
      enable = true;
      timerConfig.OnCalendar = "weekly";
    };
  };
}
