{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.hyprpaper;
  wallpaper = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/x6/wallhaven-x6vjkz.png";
    sha256 = "sha256-zfNhHnnuzi20wssJ2DAzLz+o+dZYgeiKJmuXvZtlrhA=";
  };
in
{
  options.hyprpaper.enable = lib.mkEnableOption "Enable hyprpaper";

  config.services.hyprpaper = lib.mkIf cfg.enable {
    enable = true;
    settings = {
      preload = [ "${wallpaper}" ];
      wallpaper = [
        { monitor = ""; path = "${wallpaper}"; }
      ];
    };
  };
}
