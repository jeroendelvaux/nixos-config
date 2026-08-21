{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.imagemagick;
in
{
  options.imagemagick.enable = lib.mkEnableOption "Enable imagemagick";

  config.home.packages = lib.mkIf cfg.enable (with pkgs; [
    imagemagick
  ]);
}
