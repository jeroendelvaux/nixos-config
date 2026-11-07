{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.binwalk;
in
{
  options.modules.home.binwalk.enable = lib.mkEnableOption "binwalk";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.binwalk
    ];
  };
}
