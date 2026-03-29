{ config, lib, pkgs, secrets, ... }:

{
  options.mpv.enable = lib.mkEnableOption "Enable mpv";

  config = lib.mkIf config.mpv.enable {
    home.packages = with pkgs; [
      mpv
    ];
  };
}
