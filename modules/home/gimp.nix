{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.gimp;
in
{
  options.gimp.enable = lib.mkEnableOption "Enable gimp";

  config.home.packages = lib.mkIf cfg.enable (with pkgs; [
    gimp
  ]);
}
