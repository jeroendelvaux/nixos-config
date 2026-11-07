{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.checksec;
in
{
  options.modules.home.checksec.enable = lib.mkEnableOption "checksec";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.checksec
    ];
  };
}
