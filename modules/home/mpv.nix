{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.mpv;
in
{
  options.modules.home.mpv.enable = lib.mkEnableOption "mpv";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.mpv
    ];
  };
}
