{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.blender;
in
{
  options.modules.blender.enable = lib.mkEnableOption "Enable blender";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.blender
    ];
  };
}
