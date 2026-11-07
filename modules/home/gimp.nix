{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.gimp;
in
{
  options.modules.home.gimp.enable = lib.mkEnableOption "GIMP";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.gimp
    ];
  };
}
