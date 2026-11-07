{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.blender;
in
{
  options.modules.home.blender.enable = lib.mkEnableOption "Blender";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.blender
    ];
  };
}
