{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.mpv;
in
{
  options.modules.mpv.enable = lib.mkEnableOption "Enable mpv";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.mpv
    ];
  };
}
