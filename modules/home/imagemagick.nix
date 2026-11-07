{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.imagemagick;
in
{
  options.modules.home.imagemagick.enable = lib.mkEnableOption "imagemagick";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.imagemagick
    ];
  };
}
