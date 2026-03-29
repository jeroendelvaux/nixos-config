{ config, lib, pkgs, secrets, ... }:

{
  options.traceroute.enable = lib.mkEnableOption "Enable traceroute";

  config = lib.mkIf config.traceroute.enable {
    home.packages = with pkgs; [
      traceroute
    ];
  };
}
