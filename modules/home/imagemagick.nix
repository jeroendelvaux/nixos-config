{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.imagemagick;
in
{
  options.modules.imagemagick.enable = lib.mkEnableOption "Enable imagemagick";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.imagemagick
    ];
  };
}
