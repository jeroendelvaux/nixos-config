{ config, lib, pkgs, secrets, ... }:
let
  wallpaper = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/x6/wallhaven-x6vjkz.png";
    sha256 = "sha256-zfNhHnnuzi20wssJ2DAzLz+o+dZYgeiKJmuXvZtlrhA=";
  };
in
{
  options.hyprpaper.enable = lib.mkEnableOption "Enable hyprpaper";

  config = lib.mkIf config.hyprpaper.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        preload = [ "${wallpaper}" ];
        # apply to all monitors (no argument before the comma):
        wallpaper = [ ",${wallpaper}" ];
      };
    };
  };
}
