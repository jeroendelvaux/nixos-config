{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.mpv;
in
{
  options.mpv.enable = lib.mkEnableOption "Enable mpv";

  config.home.packages = lib.mkIf cfg.enable (with pkgs; [
    mpv
  ]);
}
