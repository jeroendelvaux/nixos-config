{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.blender;
in
{
  options.blender.enable = lib.mkEnableOption "Enable blender";

  config.home.packages = lib.mkIf cfg.enable (with pkgs; [
    blender
  ]);
}
