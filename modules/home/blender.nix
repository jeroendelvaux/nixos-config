{ config, lib, pkgs, secrets, ... }:

{
  options.blender.enable = lib.mkEnableOption "Enable blender";

  config = lib.mkIf config.blender.enable {
    home.packages = with pkgs; [
      blender
    ];
  };
}
