{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.tcpdump;
in
{
  options.modules.tcpdump.enable = lib.mkEnableOption "Enable tcpdump";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.tcpdump
    ];
  };
}
