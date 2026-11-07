{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.imv;
in
{
  options.modules.home.imv.enable = lib.mkEnableOption "imv";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.imv
    ];
  };
}
