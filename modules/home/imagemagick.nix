{ config, lib, pkgs, secrets, ... }:

{
  options.imagemagick.enable = lib.mkEnableOption "Enable imagemagick";

  config = lib.mkIf config.imagemagick.enable {
    home.packages = with pkgs; [
      imagemagick
    ];
  };
}
