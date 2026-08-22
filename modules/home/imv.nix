{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.imv;
in
{
  options.modules.imv.enable = lib.mkEnableOption "Enable imv";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.imv
    ];
  };
}
